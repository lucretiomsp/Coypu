"
## For the Class part:
  A UI used to replay Performance made from toplo.

## For the Responsibility part:
A graphical interface that can be used to replay Performance in a easier way.
Can be used to play, stop, load and saved replays of a Performance.

## For the Collaborators Part:
Uses a PerformanceMusicalReplayer to replay the Performance.

## Public API and Key Messages

- Can be used to replay Performance already saved.
- Can read ston and txt files of Performance.
- You can open an instance of it by calling the class message ""open""


### Instance Variables
codeEditor: <ToAlbum> The code editor part of the UI
toolBar:	<ToElement> The toolbar containing the four buttons (play,stop,load,save)
playground: <ToPane> The ""mother"" element that has the codeEditor and toolBar has childrens
replayer: <PerformanceMusicalReplayer> the replayer used by the UI

"
Class {
	#name : 'RecorderPlayground',
	#superclass : 'Object',
	#instVars : [
		'codeEditor',
		'toolBar',
		'playground',
		'replayer'
	],
	#category : 'CoypuRecorder_Graphics',
	#package : 'CoypuRecorder_Graphics'
}

{ #category : 'instance creation' }
RecorderPlayground class >> open [
|x|
x := self new.
x playground openInSpace
]

{ #category : 'accessing' }
RecorderPlayground >> codeEditor [

^codeEditor 
]

{ #category : 'initialization' }
RecorderPlayground >> codeEditorInitialize [

	| album menuBuilder |
	album := ToAlbum new.
	album
		defaultEditorElement;
		hasSelection;
		requestTextStyle;
		withEditsFeedback;
		localTheme: ToBeeDarkTheme new;
		styler: (BlPharoCodeStyler new
				 isScripting: true;
				 workspace: codeEditor;
				 fontName: AeFontManager defaultCodeFontFamilyName;
				 yourself);
		withRowNumbers;
		whenCancelRequestedDo: [ :cancelRequested |
		cancelRequested client text: '' ].

	menuBuilder := [ :menu :request |
	               | element |
	               element := request currentTarget.
	               menu addItem: (ToMenuItem new
			                labelText: 'Select all';
			                whenClickedDo: [ :event |
				                element selecter
					                all;
					                apply ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Copy';
			                whenClickedDo: [ :event |
				                element editor copySelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Cut';
			                whenClickedDo: [ :event |
				                element editor cutSelected ];
			                yourself).
	               menu addItem: (ToMenuItem new
			                labelText: 'Paste';
			                whenClickedDo: [ :event | element editor paste ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Accept';
			                whenClickedDo: [ :event | element requestSave ];
			                yourself).
	               menu addSeparator.
	               menu addItem: (ToMenuItem new
			                labelText: 'Cancel';
			                whenClickedDo: [ :event | element requestCancel ];
			                yourself) ].
	album
		addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryD;
				 action: [ :aShortcutEvent :aShortcut | self doIt ];
				 name: 'Do it';
				 description: 'Run selected expression.');
		contextMenu: menuBuilder;
		cursorColor: Color white.
	^ album
]

{ #category : 'as yet unclassified' }
RecorderPlayground >> doIt [

	| toDo |
	toDo := codeEditor selectedText asString.
	toDo ifEmpty: [ toDo := codeEditor text asString ].
	[
	OpalCompiler new
		source: toDo readStream;
		requestor: self;
		failBlock: [ ^ Object new ];
		evaluate ]
		on: OCUndeclaredVariableWarning
		do: [ :warn | warn traceCr ]
]

{ #category : 'initialization' }
RecorderPlayground >> initialize [

	super initialize.
	replayer := PerformanceMusicalReplayer.
	self playgroundInitialize.
	replayer := PerformanceMusicalReplayer new.
	codeEditor := self codeEditorInitialize background: Color gray slightlyWhiter.
	toolBar := self toolBarInitialize.
	playground addChild: toolBar.
	playground addChild: codeEditor
]

{ #category : 'actions' }
RecorderPlayground >> load [

	| x |
	x := UIManager default
		     chooseExistingFileReference: 'Select the ston file'
		     extensions: #( 'ston' )
		     path: FileLocator home.
	replayer readScriptFromStonFile: x.
	codeEditor text: ''.
	codeEditor text: (String streamContents: [ :s |
		replayer performanceScript do: [ :each |
			s
				nextPutAll: codeEditor text asString;
				nextPutAll: each ] ]).
]

{ #category : 'actions' }
RecorderPlayground >> play [

	replayer performanceScript:
		(codeEditor text asString substrings: String cr).
PerformanceRecorder uniqueInstance emptySavedPerformance.
	replayer replayWithoutPlayground.

]

{ #category : 'accessing' }
RecorderPlayground >> playground [

	^ playground 
]

{ #category : 'initialization' }
RecorderPlayground >> playgroundInitialize [

	playground := ToPane new
		              id: #listPane;
		              margin: (BlInsets top: 0 bottom: 5).
	playground layout: (BlLinearLayout vertical cellSpacing: 0).
	playground matchParent.
]

{ #category : 'actions' }
RecorderPlayground >> save [

	| x title path |

	x := UIManager default.
	title := x
		         request: 'The name of the save:'
		         initialAnswer:
		         'Performance of the ' , DateAndTime now asDate asString.
	path := x
		        chooseDirectory: 'Select the Directory to save the file'
		        path: FileLocator home.

	replayer performanceScript:
		((codeEditor text asString substrings: String cr) collect: [ :each |
			 each , String cr ]).


	replayer writeScriptInStonFile: title filePath: path.
]

{ #category : 'actions' }
RecorderPlayground >> stop [
	Performance uniqueInstance stop.

]

{ #category : 'accessing' }
RecorderPlayground >> toolBar [

	^ toolBar 
]

{ #category : 'initialization' }
RecorderPlayground >> toolBarInitialize [

	| bar button x |
	x := 0.

	bar := ToElement new.
	bar background: Color darkGray.
	bar geometry: BlRectangleGeometry new.
	bar size: 5000 @ 31.
	bar layout: (BlLinearLayout horizontal cellSpacing: 5).
	button := ToButton new.
	button label: (ToLabel text: 'Play').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #glamorousGo)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self play ].
	bar addChild: button.
	button := ToButton new.
	button label: (ToLabel text: 'Stop').
	button icon: (ToImage inner: (Smalltalk ui icons iconNamed: #stop)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self stop ].
	bar addChild: button.
	button := ToButton new.
	button label: (ToLabel text: 'Load').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #smallOpen)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self load ].
	bar addChild: button.
	button := ToButton new.
	button label: (ToLabel text: 'Save').
	button icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #glamorousSave)).
	button addEventHandlerOn: BlMouseDownEvent do: [ :e | self save ].
	bar addChild: button.
	bar childrenDo: [ :c |
		c transformDo: [ :cc |
			cc translateBy: x @ 3.
			x := x + 5 ] ].
	^ bar
]
