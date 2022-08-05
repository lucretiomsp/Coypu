"
RoassalCanvas for Lucretio's a/v performance at ESUG2022 Novi Sad
"
Class {
	#name : #EsugVisual,
	#superclass : #RSCanvas,
	#instVars : [
		'shapez',
		'nodez',
		'shapezSize',
		'shapezColorRed',
		'layoutz',
		'shapez2',
		'shapez2Size',
		'layoutz2',
		'bassLine',
		'alanText',
		'textAlpha',
		'groupToFill1'
	],
	#category : #'LiveCoding-Visuals'
}

{ #category : #'as yet unclassified' }
EsugVisual class >> alanSpeech [

	"convenience method that returns a String containing the initial speech"

	| speech |
	speech := 'The main thing about doing OOP work /
or any kind of programming work /
is that there has to be some / 
exquisite blend / 
between beauty and practicality / 
there is no reason to sacrifice /
either one of those and /
who are willing to sacrifice /  either one of those  / I dont think really 
get /  what computing is all about / 
It is like saying  / I have really great ideas for painting / but I am just gonna use / a brush with no paint /
so my ideas will be represented / by the gestures I make over the paper / 
Dont tell / any twentieth century artist / that / or they might decide to make a videotape of them doing that /  an putting it in a museum
'.
	^ speech
]

{ #category : #'instance creation' }
EsugVisual class >> for: anObservable [

	" Initialize a new EsugVisual, connect my visualization to anObservable Annoucer and open it"

	| canvas |
	canvas := self new.
	anObservable announcer isNotNil
		ifTrue: [ 
			canvas
				subscribeTo: anObservable announcer;
				"zoomToFit;"
				openOnce ]
		ifFalse: [  ].
	^ canvas
]

{ #category : #accessing }
EsugVisual >> alanText [
^ alanText
]

{ #category : #accessing }
EsugVisual >> bassLine [

	^ bassLine
]

{ #category : #accessing }
EsugVisual >> bassLine: anObject [

	bassLine := anObject
]

{ #category : #'as yet unclassified' }
EsugVisual >> bassLineWidth: anInteger [

	bassLine width: anInteger .
	self signalUpdate
]

{ #category : #'as yet unclassified' }
EsugVisual >> changeLayout: aTypeofLayout [

	" 'grid' 'tree' 'cell' 'horizontalTree' 'cluster'
	             'circle' 'radial' 'sugiyama' "

	| l |
	l := RSLayoutBuilder new.
	l perform: aTypeofLayout asSymbol.
	l on: shapez.
	self signalUpdate .
]

{ #category : #'as yet unclassified' }
EsugVisual >> circleRadius: anInteger [

	self layoutz radius: anInteger.
	layoutz on: self shapez.
	shapez translateTo: 0@0.
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> groupToFill1 [

	^ groupToFill1
]

{ #category : #accessing }
EsugVisual >> groupToFill1: anObject [

	groupToFill1 := anObject
]

{ #category : #initialization }
EsugVisual >> initialize [

	| center |
	center := 0.
	super initialize.
	self initializeAlanSpeech.
	self color: #black. " transparent"
	self shapezSize ifNil: [ shapezSize := 30 ].
	self shapezColorRed ifNil: [ shapezColorRed := 0 ].
	self nodez ifNil: [ nodez := 1 to: 16 ].
	self layoutz ifNil: [ layoutz := RSCircleLayout new radius: 220 ].
	self layoutz2 ifNil: [ layoutz2 := RSRectanglePackLayout new ].
	self groupToFill1: RSGroup new.

	" bassline"
	bassLine := RSLine new
		            color: #white;
		            width: 58;
		            yourself;
		            startPoint: 0 @ self extent y negated;
		            endPoint: 0 @ self extent y;
		            yourself.
	"add bassline"
	self add: bassLine.
	"kicks and hihats"
	shapez := RSCircle models: nodez.
	shapez2 := RSBox models: nodez.

	shapez color: (Color r: shapezColorRed g: 0 b: 20).
	shapez2 color: (Color r: 200 g: 110 b: 0).
	shapez size: shapezSize.
	shapez2 size: 50.
	self
		addAll: shapez;
		addAll: shapez2.
	layoutz on: shapez.
	shapez translateTo: center.

	layoutz2 on: shapez2.
	shapez2 translateTo: 0 @ 0
]

{ #category : #'sub item creating' }
EsugVisual >> initializeAlanSpeech [


	| r r2 r3 red blue words label |
	alanText := RSGroup new.
	textAlpha ifNil: [ textAlpha := 1.0 ].
	words := self class alanSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: ((Color r: red g: 0 b: blue) alpha: textAlpha).
		label fontSize: (r nextInteger: 38) + 10.

		
		alanText add: label ].

	RSRectanglePackLayout on: alanText.
	"RSFlowLayout new
		alignLabel;
		on: alanText."

]

{ #category : #accessing }
EsugVisual >> layoutz [

	^ layoutz
]

{ #category : #accessing }
EsugVisual >> layoutz2 [

	^ layoutz2
]

{ #category : #accessing }
EsugVisual >> layoutz2: anObject [

	layoutz2 := anObject
]

{ #category : #accessing }
EsugVisual >> layoutz: aLayout [

	^ layoutz := aLayout
]

{ #category : #accessing }
EsugVisual >> nodez [

	^ nodez
]

{ #category : #accessing }
EsugVisual >> nodez1: anObject [

	^ nodez := anObject
]

{ #category : #accessing }
EsugVisual >> nodez: anInteger [

	| newShapez |
	nodez := 1 to: anInteger.
	newShapez := RSCircle models: nodez.
	newShapez color: (Color r: shapezColorRed g: 0 b: 220).
	newShapez size: shapezSize.
	shapez add: newShapez.
	layoutz on: shapez.
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> shapez [

	^ shapez
]

{ #category : #accessing }
EsugVisual >> shapez2 [

	^ shapez2
]

{ #category : #accessing }
EsugVisual >> shapez2: anObject [

	shapez2 := anObject
]

{ #category : #accessing }
EsugVisual >> shapez2Size [

	^ shapez2Size
]

{ #category : #accessing }
EsugVisual >> shapez2Size: anInteger [

	shapez2Size := anInteger.
	shapez2 size: shapez2Size.
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> shapez: anRSGroup [

	shapez := anRSGroup 
]

{ #category : #accessing }
EsugVisual >> shapezColorRed [

	^ shapezColorRed
]

{ #category : #accessing }
EsugVisual >> shapezColorRed: anInteger [

	shapezColorRed := anInteger.
	shapez color: (Color r: anInteger g: 0 b: 120).
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> shapezSize [

	^ shapezSize
]

{ #category : #accessing }
EsugVisual >> shapezSize1: anObject [

	^ shapezSize := anObject
]

{ #category : #accessing }
EsugVisual >> shapezSize: anInteger [

	shapezSize := anInteger.
	shapez size: shapezSize.
	 self signalUpdate
]

{ #category : #subscription }
EsugVisual >> subscribeTo: anAnnouncer [

	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		self shapezSize:
			(OSCMsgReceivedAnnouncement values at: #'/kickGate') * 2
			* (OSCMsgReceivedAnnouncement values at: #'/thereIsKick').
		"self color: (Color r: kickG g: kickG b: kickG)."
		"(OSCMsgReceivedAnnouncement values at: #'/kickGate') * 255"
		self shapezColorRed:
			(OSCMsgReceivedAnnouncement values at: #'/snareGate') * 1.

		self shapez2Size:
			(OSCMsgReceivedAnnouncement values at: #'/chGate') * 6
			* (OSCMsgReceivedAnnouncement values at: #'/ohGate').
		self circleRadius:
			(OSCMsgReceivedAnnouncement values at: #'/percGate').

		self bassLineWidth:
			(OSCMsgReceivedAnnouncement values at: #'/acidNote')
			* (OSCMsgReceivedAnnouncement values at: #'/acidGate').

		self visualizeAlanSpeechAtIndex:
			(OSCMsgReceivedAnnouncement values at: #'/alanCount') 


		"self signalUpdate" ]
]

{ #category : #accessing }
EsugVisual >> textAlpha [

	^ textAlpha
]

{ #category : #accessing }
EsugVisual >> textAlpha: aFloat [

	" alpha value for texts"

	| r r2 |
	r := Random new.
	r2 := Random new.
	textAlpha := aFloat.
	alanText do: [ :w | 
		w color: (Color
				 r: r next * aFloat rounded
				 g: 0
				 b: aFloat * (r2 next)) ].

	self signalUpdate
]

{ #category : #'sub item creating' }
EsugVisual >> visualizeAlanSpeech [

	| r r2 r3 red blue words label |
	alanText := RSGroup new.
	textAlpha ifNil: [ textAlpha := 1.0 ].
	words := self class alanSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: ((Color r: red g: 0 b: blue) alpha: textAlpha).
		label fontSize: (r nextInteger: 38) + 10.

		self add: label.
		alanText add: label ].
	
	RSRectanglePackLayout on: alanText.
	"RSFlowLayout new
		alignLabel;
		on: alanText."
	self shapes translateTo: 10 @ 0
]

{ #category : #'sub item creating' }
EsugVisual >> visualizeAlanSpeechAtIndex: anInteger [

	self groupToFill1 add: (alanText at: anInteger asInteger).
	self add: groupToFill1 asShape.
	anInteger asInteger traceCr .
]
