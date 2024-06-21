Class {
	#name : 'MfPatternElement',
	#superclass : 'ToElement',
	#instVars : [
		'nbOfSteps'
	],
	#classVars : [
		'max',
		'min',
		'nbsteps'
	],
	#category : 'Mooflod-PatternWidget',
	#package : 'Mooflod',
	#tag : 'PatternWidget'
}

{ #category : 'examples' }
MfPatternElement class >> exampleSimplePattern [

	<script>
	| patternelem space |
	patternelem := self new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	space := BlSpace new.
	space root addChild: patternelem.
	space toTheme: MfMooflodTheme new.
	patternelem transformDo: [ :c | c translateBy: 180 @ 200 ].
	space show.
	^ patternelem
]

{ #category : 'adding' }
MfPatternElement >> addInstrumentToStep [
	"Change the value of the drum attribute for the bar clicked, and update his color for visualization undestanding"

	self childrenDo: [ :child |
		child addEventHandlerOn: BlMouseDownEvent do: [ :evt |
			child instrument not
				ifTrue: [
					child background: Color black.
					child assignInstrument  ]
				ifFalse: [
					child background: Color white.
					child removeInstrument  ] ] ]
]

{ #category : 'adding' }
MfPatternElement >> addStepsToThePattern: nbSteps [
	"Add all bars element in the pattern to display them"

	| step changingX |
	nbOfSteps := 0.
	changingX := 2.5.
	(nbSteps between: min and: max) ifTrue: [
		nbOfSteps := nbSteps.
		1 to: nbSteps do: [ :i |
			step := MfStepElement new.
			step transformDo: [ :t | t translateBy: changingX @ 0 ].
			changingX := changingX + 35.
			self addChild: step ] ].
	self size: 35 * nbSteps @ 60.
	self addInstrumentToStep
]

{ #category : 'visual properties' }
MfPatternElement >> backgroundPaint [ 
	"Define the background for the pattern"
	^ Color red
]

{ #category : 'initialization' }
MfPatternElement >> initialize [

	super initialize.
	self size: self patternExtent.
	self geometry: BlRectangleGeometry new.
	self layout: BlFrameLayout new.
]

{ #category : 'accessing' }
MfPatternElement >> max [ 
	
	^max.
]

{ #category : 'accessing' }
MfPatternElement >> max: aMax [

	max:= aMax.
]

{ #category : 'accessing' }
MfPatternElement >> min [ 

	^min.
]

{ #category : 'accessing' }
MfPatternElement >> min: aMin [

	min:= aMin.
]

{ #category : 'accessing' }
MfPatternElement >> nbOfSteps [

	^ nbOfSteps
]

{ #category : 'accessing' }
MfPatternElement >> nbsteps [

	^ nbsteps
]

{ #category : 'accessing' }
MfPatternElement >> nbsteps: someNbSteps [

	nbsteps := someNbSteps.
	self addStepsToThePattern: nbsteps
]

{ #category : 'initialization' }
MfPatternElement >> newMooFlodSkin [

	^ MfPatternElementSkin new
]

{ #category : 'visual properties' }
MfPatternElement >> patternExtent [

	^ 36@60
]
