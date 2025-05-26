"
I am the visualizer for a Sequencer inside the Mooflod Performance
"
Class {
	#name : 'MfVisualizerElement',
	#superclass : 'ToElement',
	#instVars : [
		'nbTracks',
		'animation',
		'squareArray',
		'patternArray',
		'sliderArray',
		'tracks',
		'instruments',
		'activeRows'
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
	v := self new level: 4.
	v addInstrument: 'Kick'.
	v addInstrument: 'TpSampler'.
	v initAnimation: 400.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	v transformDo: [ :c | c translateBy: 200 @ 0 ].
	space root addChild: v.
	space toTheme: MfMooflodTheme new.
	space root background: (Color fromHexString: '#313339').
	space show.
	^ v
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelFour: aName [

	| sect slider1 slider2 |
	self addElementsLevelThree: aName.
	sect := self children at: nbTracks.
	slider1 := ICSlider2 new.
	slider2 := ICSlider2 new.
	slider1 transformDo: [ :q | q translateBy: 10 @ 75 ].
	slider2 transformDo: [ :q | q translateBy: 210 @ 75 ].
	sect addChild: slider1.
	sect addChild: slider2.
	self
		setLabelToSlider: aName
		firstSlider: slider1
		secondSlider: slider2
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelOne: aName [

	| label name sect square |
	sect := self children at: nbTracks.
	name := BlTextElement new.
	name text: (self textFrom: aName).
	name text fontSize: 14.
	square := MfPulsingSquare new.
	label := BlTextElement new.
	label text: (self textFrom: 'Instrument :').
	label text fontSize: 12.
	label transformDo: [ :t | t translateBy: 20 @ 17 ].
	square transformDo: [ :q | q translateBy: 450 @ 2 ].
	name transformDo: [ :t | t translateBy: 90 @ 17 ].
	squareArray at: aName put: square.
	self addIconToInstrument: aName.
	sect addChild: square.
	sect addChild: label.
	sect addChild: name
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelThree: aName [

	| number label sect |
	self addElementsLevelTwo: aName.
	sect := self children at: nbTracks.
	number := MfTimerElement new value: 60.
	label := BlTextElement new.
	label text fontSize: 12.
	label transformDo: [ :t | t translateBy: 315 @ 3 ].
	number transformDo: [ :q | q translateBy: 320 @ 20 ].
	sect addChild: number.
	sect addChild: label.
	aName = 'Kick' ifTrue: [
		sliderArray at: 'KickNote' put: number.
		label text: ('KickNote' asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color yellow) }) ].
	aName = 'TpSampler' ifTrue: [
		sliderArray at: 'TpSamplerNote' put: number.
		label text: ('TpSamplerNote' asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color yellow) }) ].
	aName = 'PsgPlus' ifTrue: [
		sliderArray at: 'PsgPlusNote' put: number.
		label text: ('PsgPlusNote' asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color yellow) }) ].
	aName = 'Fm2Op' ifTrue: [
		sliderArray at: 'Fm2OpNote' put: number.
		label text: ('Fm2OpNote' asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color yellow) }) ].
	aName = 'Chordy' ifTrue: [
		sliderArray at: 'ChordyNote' put: number.
		label text: ('ChordyNote' asRopedText attributes:
				 { (BlTextForegroundAttribute paint: Color yellow) }) ]
]

{ #category : 'adding' }
MfVisualizerElement >> addElementsLevelTwo: aName [

	| pattern sect |
	self addElementsLevelOne: aName.
	sect := self children at: nbTracks .
	pattern := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 16.
	pattern transformDo: [ :q | q translateBy: 10 @ 35 ].
	"pattern forSequencer: aName ."
	patternArray at: aName put: pattern.
	sect addChild: pattern
]

{ #category : 'adding' }
MfVisualizerElement >> addIconToInstrument: aName [

	| sect icon |
	sect := self children at: nbTracks.
	aName = 'Kick' ifTrue: [ icon := ICBassDrumIcon new ].
	aName = 'Fm2Op' ifTrue: [ icon := ICFm2OpIcon new ].
	aName = 'TpSampler' ifTrue: [ icon := ICPercussionsIcon new ].
	aName = 'PsgPlus' ifTrue: [ icon := ICWaveIcon new ].
	aName = 'Chordy' ifTrue: [ icon := ICMonoLeadIcon new ].
	
		icon transformDo: [ :t | t translateBy: 400 @ 23 ].
		sect addChild: icon 
]

{ #category : 'adding' }
MfVisualizerElement >> addInstrument: aName [

	nbTracks < 5 ifFalse: [ ^ self ].
	nbTracks := nbTracks + 1.
	(activeRows includes: nbTracks)
		ifTrue: [ ]
		ifFalse: [
			self initLevelRepresentation: aName.

			'ADDED INSTRUMENT' , nbTracks asString traceCr ]
]

{ #category : 'adding' }
MfVisualizerElement >> addLabelToSliders: aSlider secondSlider: anOtherSlider [

	| label1 label2 sect |
	sect := self children at: nbTracks.
	label1 := BlTextElement new.
	label2 := BlTextElement new.
	label1 text: (self textFrom: (sliderArray keyAtValue: aSlider)).
	label2 text: (self textFrom: (sliderArray keyAtValue: anOtherSlider)).
	label1 text fontSize: 12.
	label2 text fontSize: 12.
	label1 transformDo: [ :t | t translateBy: 15 @ 65 ].
	label2 transformDo: [ :t | t translateBy: 215 @ 65 ].
	sect addChild: label1.
	sect addChild: label2
]

{ #category : 'accessing' }
MfVisualizerElement >> animation [

	^ animation
]

{ #category : 'action' }
MfVisualizerElement >> cleanRow [

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ].
	nbTracks := 0
]

{ #category : 'action' }
MfVisualizerElement >> cleanRow: anInteger [

	| sect |
	sect := self children at: anInteger .
	sect removeChildren.
	self nbTracks: anInteger - 1
]

{ #category : 'action' }
MfVisualizerElement >> cleanVisualizer [

	self childrenDo: [ :c | c childrenDo: [ :cc | cc removeFromParent ] ].
	nbTracks := 0
]

{ #category : 'initialization' }
MfVisualizerElement >> initAnimation: nbSteps [

	animation := BlAnimation new duration: (nbSteps) seconds.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e | self cleanVisualizer ]).
	self addAnimation: animation
]

{ #category : 'initialization' }
MfVisualizerElement >> initLevelRepresentation: aName [

	level == 1 ifTrue: [ self addElementsLevelOne: aName ].
	level == 2 ifTrue: [ self addElementsLevelTwo: aName ].
	level == 3 ifTrue: [ self addElementsLevelThree: aName ].
	level == 4 ifTrue: [ self addElementsLevelFour: aName ].
		level == 5 ifTrue: [ self addElementsLevelFour: aName ].
]

{ #category : 'initialization' }
MfVisualizerElement >> initSections [

	| y |
	y := 0.
	1 to: 5 do: [ :s |
		| sect |
		sect := BlElement new.
		sect geometry: BlRectangleGeometry new.
		sect size: 600 @ 110.
		sect border: (BlBorder paint: Color black width: 2).
		sect layout: BlFrameLayout new.
		sect transformDo: [ :t | t translateBy: 0 @ y ].
		y := y + 110.
		self addChild: sect ]
]

{ #category : 'initialization' }
MfVisualizerElement >> initialize [

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 600 @ 550.
	self border: (BlBorder paint: Color lightGray width: 2).
	self initSections.
	squareArray := Dictionary new.
	patternArray := Dictionary new.
	sliderArray := Dictionary new.
	tracks := Dictionary new.
	tracks
		at: #Kick put: 1;
		at: #TpSampler put: 2;
		at: #Fm2Op put: 3;
		at: #PsgPlus put: 4;
		at: #Chordy put: 5.
	nbTracks := 0.
	activeRows := OrderedCollection new.
]

{ #category : 'accessing' }
MfVisualizerElement >> instruments [

^ instruments ifNil: [ #( #Kick . #TpSampler . #PsgPlus . #Chordy . #Fm2Op.) ]
]

{ #category : 'accessing' }
MfVisualizerElement >> instruments: anArrayOfSymbols [

instruments := anArrayOfSymbols 
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

{ #category : 'accessing' }
MfVisualizerElement >> nbTracks: anInteger [

	nbTracks := anInteger 
]

{ #category : 'accessing' }
MfVisualizerElement >> nextFreeRow [

	^ (activeRows includes: nbTracks + 1)
		  ifFalse: [ nbTracks + 1 modulo: 5 ]
		  ifTrue: [
			  self nbTracks: nbTracks + 1.
			  self nextFreeRow ]
]

{ #category : 'accessing' }
MfVisualizerElement >> patternArray [ 

^patternArray 
]

{ #category : 'initialization' }
MfVisualizerElement >> setLabelToSlider: aName firstSlider: aSlider secondSlider: anOtherSlider [

	| isValidName |
	isValidName := false.
	aName = 'Kick' ifTrue: [
		sliderArray at: 'KickDrive' put: aSlider.
		sliderArray at: 'KickDecay' put: anOtherSlider.
		aSlider
			changeMinValueLabelTo: 0.1;
			changeMaxValueLabelTo: 5.
		anOtherSlider
			changeMinValueLabelTo: 0.01;
			changeMaxValueLabelTo: 2.
		isValidName := true ].
	aName = 'TpSampler' ifTrue: [
		sliderArray at: 'TpSamplerIndex' put: aSlider.
		sliderArray at: 'TpSamplerEffect' put: anOtherSlider.
		aSlider
			changeMinValueLabelTo: 0;
			changeMaxValueLabelTo: 50.
		anOtherSlider
			changeMinValueLabelTo: 0;
			changeMaxValueLabelTo: 1.
		isValidName := true ].
	aName = 'PsgPlus' ifTrue: [
		sliderArray at: 'PsgPlusIndex' put: aSlider.
		sliderArray at: 'PsgPlusLfoAmount' put: anOtherSlider.
		aSlider
			changeMinValueLabelTo: 0;
			changeMaxValueLabelTo: 1.
		anOtherSlider
			changeMinValueLabelTo: 0;
			changeMaxValueLabelTo: 10.
		isValidName := true ].
	aName = 'Chordy' ifTrue: [
		sliderArray at: 'ChordyMode' put: aSlider.
		sliderArray at: 'ChordyCutoff' put: anOtherSlider.
		aSlider
			changeMinValueLabelTo: 1;
			changeMaxValueLabelTo: 3.
		anOtherSlider
			changeMinValueLabelTo: 0;
			changeMaxValueLabelTo: 10.
		isValidName := true ].
	aName = 'Fm2Op' ifTrue: [
		sliderArray at: 'Fm2OpModIndex' put: aSlider.
		sliderArray at: 'F2OpModRatio' put: anOtherSlider.
		aSlider
			changeMinValueLabelTo: 1;
			changeMaxValueLabelTo: 3.
		anOtherSlider
			changeMinValueLabelTo: 0.1;
			changeMaxValueLabelTo: 12.
		isValidName := true ].
	isValidName ifTrue: [
		self addLabelToSliders: aSlider secondSlider: anOtherSlider ]
]

{ #category : 'accessing' }
MfVisualizerElement >> sliderArray [		
	
^sliderArray 
]

{ #category : 'accessing' }
MfVisualizerElement >> squareArray [

^squareArray
]

{ #category : 'adding' }
MfVisualizerElement >> textFrom: aName [

	^ aName asRopedText attributes:
		  { (BlTextForegroundAttribute paint: Color red) }
]

{ #category : 'accessing' }
MfVisualizerElement >> tracks [

	^ tracks
]

{ #category : 'accessing' }
MfVisualizerElement >> tracks: anObject [

	tracks := anObject
]
