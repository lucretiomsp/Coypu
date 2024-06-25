Class {
	#name : 'MfVisualizerElement',
	#superclass : 'ToElement',
	#instVars : [
		'nbTracks',
		'animation',
		'squareArray'
	],
	#classVars : [
		'level'
	],
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'examples' }
MfVisualizerElement class >> exampleVisualizer [

	<script>
	| v space |
	v := self new level: 2.
	v addInstrument: 'Kick'.
	v level: 1.
	v addInstrument: 'Snare'.
	v initAnimation: 4.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	v transformDo: [ :c | c translateBy: 200 @ 50 ].
	space root addChild: v.
	space toTheme: MfMooflodTheme new.
	space show.
	^ v
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelFour: aChildren [ 

	
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelOne: aName [

	| label name sect square |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (self textFrom: aName).
	name text fontSize: 18.
	square := MfPulsingSquare new.
	label := BlTextElement new.
	label text: (self textFrom: 'Instrument :').
	label text fontSize: 18.
	label transformDo: [ :t | t translateBy: 20 @ 25 ].
	square transformDo: [ :q | q translateBy: 450 @ 15 ].
	name transformDo: [ :t | t translateBy: 130 @ 25 ].
	squareArray add: square.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelThree: aChildren [ 

	
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelTwo: aName [

	| pattern sect |
	
	self addElementsLevelOne: aName.
	sect := self children at: nbTracks.
	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 12.
	pattern transformDo: [ :q | q translateBy: 40 @ 100 ].
	sect addChild: pattern
]

{ #category : 'adding' }
MfVisualizerElement >> addInstrument: aName [

	nbTracks < 4 ifFalse: [ ^ self ].
	nbTracks := nbTracks +1.
	self initLevelRepresentation: aName
]

{ #category : 'accessing' }
MfVisualizerElement >> animation [

	^ animation
]

{ #category : 'action' }
MfVisualizerElement >> cleanVisualizer [

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ].
	nbTracks := 0
]

{ #category : 'initialization' }
MfVisualizerElement >> initAnimation: nbSteps [

	animation := BlAnimation new duration: nbSteps seconds.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e | self cleanVisualizer ]).
	self addAnimation: animation
]

{ #category : 'initialization' }
MfVisualizerElement >> initLevelRepresentation: aName [
	level == 1 ifTrue: [ self addElementsLevelOne: aName ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aName].
	level == 3 ifTrue: [ self addElementsLevelThree: aName ].
	level == 4 ifTrue: [ self addElementsLevelFour: aName ]
]

{ #category : 'initialization' }
MfVisualizerElement >> initSections [

	| y |
	y := 0.
	1 to: 4 do: [ :s |
		| sect |
		sect := BlElement new.
		sect geometry: BlRectangleGeometry new.
		sect size: 500 @ 200.
		sect border: (BlBorder paint: Color white width: 2).
		sect layout: BlFrameLayout new.
		sect transformDo: [ :t | t translateBy: 0 @ y ].
		y := y + 200.
		self addChild: sect ]
]

{ #category : 'initialization' }
MfVisualizerElement >> initialize [

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 500 @ 800.
	self border: (BlBorder paint: Color lightGray width: 2).
self initSections.
	squareArray := OrderedCollection new.
	nbTracks := 0
]

{ #category : 'accessing' }
MfVisualizerElement >> level [ 
^level
]

{ #category : 'accessing' }
MfVisualizerElement >> level: aLevel [

	level := aLevel.
	
]

{ #category : 'accessing' }
MfVisualizerElement >> nbTracks [

^nbTracks 
]

{ #category : 'instance creation' }
MfVisualizerElement >> open [ 

|space|
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	self transformDo: [ :c | c translateBy: 200 @ 50 ].
	space root addChild: self.
	space toTheme: MfMooflodTheme new.
	space show.
]

{ #category : 'accessing' }
MfVisualizerElement >> squareArray [

^squareArray
]

{ #category : 'adding' }
MfVisualizerElement >> textFrom: aName [

	^ aName asRopedText attributes:
		  { (BlTextForegroundAttribute paint: Color white) }
]
