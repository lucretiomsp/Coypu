Class {
	#name : #MfVisualizerElement,
	#superclass : #ToElement,
	#instVars : [
		'nbTracks',
		'animation',
		'squareArray',
		'patternArray',
		'sliderArray'
	],
	#classVars : [
		'level'
	],
	#category : #'Mooflod-VisualizerRepresentation'
}

{ #category : #examples }
MfVisualizerElement class >> exampleVisualizer [

	<script>
	| v space |
	v := self new level: 3.
	v addInstrument: 'Kick'.
	v addInstrument: 'Snare'.
	v initAnimation: 400.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	v transformDo: [ :c | c translateBy: 200 @ 0 ].
	space root addChild: v.
	space toTheme: MfMooflodTheme new.
	space show.
	^ v
]

{ #category : #adding }
MfVisualizerElement >> addElementsLevelFour: aChildren [ 

	
]

{ #category : #adding }
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
	label transformDo: [ :t | t translateBy: 20 @ 17 ].
	square transformDo: [ :q | q translateBy: 550 @ 10 ].
	name transformDo: [ :t | t translateBy: 130 @ 17 ].
	squareArray at:aName put: square.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name
]

{ #category : #adding }
MfVisualizerElement >> addElementsLevelThree: aName [

	| sect slider1 slider2 |
	self addElementsLevelTwo: aName.
	sect := self children at: nbTracks.
	slider1 := ICSlider new name: 'aaa'.
	slider2 := ICSlider new.
	slider1 transformDo: [ :q | q translateBy: 100 @ 100 ].
	slider2 transformDo: [ :q | q translateBy: 400 @ 100 ].
	sect addChild: slider1.
	sect addChild: slider2.
	self
		setLabelToSlider: aName
		firstSlider: slider1
		secondSlider: slider2
]

{ #category : #adding }
MfVisualizerElement >> addElementsLevelTwo: aName [

	| pattern sect |
	self addElementsLevelOne: aName.
	sect := self children at: nbTracks.
	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 16.
	pattern transformDo: [ :q | q translateBy: 20 @ 50 ].
	"pattern forSequencer: aName ."
	patternArray at: aName put: pattern.
	sect addChild: pattern
]

{ #category : #adding }
MfVisualizerElement >> addInstrument: aName [

	nbTracks < 5 ifFalse: [ ^ self ].
	nbTracks := nbTracks + 1.
	self initLevelRepresentation: aName
]

{ #category : #adding }
MfVisualizerElement >> addLabelToSliders: aSlider secondSlider: anOtherSlider [

	| label1 label2 sect |
	sect := self children at: nbTracks.
	label1 := BlTextElement new.
	label2 := BlTextElement new.
	label1 text: (self textFrom: (sliderArray keyAtValue: aSlider)).
	label2 text: (self textFrom: (sliderArray keyAtValue: anOtherSlider)).
	label1 text fontSize: 12.
	label2 text fontSize: 12.
	label1 transformDo: [ :t | t translateBy: 132 @ 85 ].
	label2 transformDo: [ :t | t translateBy: 432 @ 85 ].
	sect addChild: label1.
	sect addChild: label2
]

{ #category : #accessing }
MfVisualizerElement >> animation [

	^ animation
]

{ #category : #action }
MfVisualizerElement >> cleanVisualizer [

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ].
	nbTracks := 0
]

{ #category : #initialization }
MfVisualizerElement >> initAnimation: nbSteps [

	animation := BlAnimation new duration: (nbSteps) seconds.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e | self cleanVisualizer ]).
	self addAnimation: animation
]

{ #category : #initialization }
MfVisualizerElement >> initLevelRepresentation: aName [

	level == 1 ifTrue: [ self addElementsLevelOne: aName ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aName].
	level == 3 ifTrue: [ self addElementsLevelThree: aName ].
	level == 4 ifTrue: [ self addElementsLevelFour: aName ]
]

{ #category : #initialization }
MfVisualizerElement >> initSections [

	| y |
	y := 0.
	1 to: 5 do: [ :s |
		| sect |
		sect := BlElement new.
		sect geometry: BlRectangleGeometry new.
		sect size: 600 @ 180.
		sect border: (BlBorder paint: Color black width: 2).
		sect layout: BlFrameLayout new.
		sect transformDo: [ :t | t translateBy: 0 @ y ].
		y := y + 180.
		self addChild: sect ]
]

{ #category : #initialization }
MfVisualizerElement >> initialize [

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 600 @ 900.
	self border: (BlBorder paint: Color lightGray width: 2).
	self initSections.
	squareArray := Dictionary new.
	patternArray := Dictionary new.
	sliderArray := Dictionary new.
	nbTracks := 0
]

{ #category : #accessing }
MfVisualizerElement >> level [ 
^level
]

{ #category : #accessing }
MfVisualizerElement >> level: aLevel [

	level := aLevel.
	
]

{ #category : #accessing }
MfVisualizerElement >> nbTracks [

^nbTracks 
]

{ #category : #accessing }
MfVisualizerElement >> patternArray [ 

^patternArray 
]

{ #category : #initialization }
MfVisualizerElement >> setLabelToSlider: aName firstSlider: aSlider secondSlider: anOtherSlider [

	| isValidName |
	isValidName := false.
	aName = 'Kick' ifTrue: [
		sliderArray at: 'KickDrive' put: aSlider.
		sliderArray at: 'KickDecay' put: anOtherSlider.
		isValidName := true ].
	aName = 'TpSampler' ifTrue: [
		sliderArray at: 'TpSamplerIndex' put: aSlider.
		sliderArray at: 'TpSamplerEffect' put: anOtherSlider.
		isValidName := true ].
	aName = 'PsgPlus' ifTrue: [
		sliderArray at: 'PsgPlusIndex' put: aSlider.
		sliderArray at: 'PsgPlusLfoAmount' put: anOtherSlider.
		isValidName := true ].
	aName = 'Chordy' ifTrue: [
		sliderArray at: 'ChordyMode' put: aSlider.
		sliderArray at: 'ChordyCutoff' put: anOtherSlider.
		isValidName := true ].
	aName = 'Fm2Op' ifTrue: [
		sliderArray at: 'Fm2OpModIndex' put: aSlider.
		sliderArray at: 'F2OpModRatio' put: anOtherSlider.
		isValidName := true ].
	isValidName ifTrue: [
		self addLabelToSliders: aSlider secondSlider: anOtherSlider ]
]

{ #category : #accessing }
MfVisualizerElement >> squareArray [

^squareArray
]

{ #category : #adding }
MfVisualizerElement >> textFrom: aName [

	^ aName asRopedText attributes:
		  { (BlTextForegroundAttribute paint: Color green) }
]
