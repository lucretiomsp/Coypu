"
I display the Seconds to the end of the Performance. my default time is 30 minutes = 1800 seconds
"
Class {
	#name : 'MfPerformanceStepsDisplayer',
	#superclass : 'ToElement',
	#instVars : [
		'label',
		'nbSteps',
		'text',
		'animation',
		'animationIsRunning'
	],
	#category : 'Mooflod-PerformanceStepsDisplayer',
	#package : 'Mooflod',
	#tag : 'PerformanceStepsDisplayer'
}

{ #category : 'example' }
MfPerformanceStepsDisplayer class >> exampleNbSteps [

	<script>
	| s space |
	s := self new.
	s addSteps: 189.
	s transformDo: [ :c | c translateBy: 200 @ 150 ].
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	space toTheme: MfMooflodTheme new.
	space root addChild: s.
	space show.
	^ s
]

{ #category : 'adding' }
MfPerformanceStepsDisplayer >> addSteps: aNbOfSteps [

	(aNbOfSteps between: 0 and: 30000) ifFalse: [ ^ self ].
	"we count the seconds to the end of the Performance - standard 30 minutes = 1800 seconds"
	nbSteps := 1800. "aNbOfSteps"
	self initializeStepsLabel
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> animation [

	^ animation
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> animationIsRunning [

	^ animationIsRunning 
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> animationIsRunning: aBoolean [

	animationIsRunning := aBoolean
]

{ #category : 'initialization' }
MfPerformanceStepsDisplayer >> initialize [

	super initialize.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 18).
	self size: 300 @ 50.
	self background: Color black.
	animationIsRunning := false
]

{ #category : 'initialization' }
MfPerformanceStepsDisplayer >> initializeAnimation: aBpm [

	animationIsRunning := true.
	animation := BlAnimation new duration: (60 / 4 / aBpm) seconds.
	animation beInfinite.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 animationIsRunning ifTrue: [
					 nbSteps < 30000 ifTrue: [
						"now is set to cuntDown"
						 nbSteps := nbSteps - 1.
						 self setStepsLabel: nbSteps ] ] ]).
	self addAnimation: animation
]

{ #category : 'initialization' }
MfPerformanceStepsDisplayer >> initializeStepsLabel [

	self removeChildren.
	text := BlTextElement new.
	text text: ('SECONDS TO GO' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color red) }).
	text text fontSize: 20.
	text transformDo: [ :t | t translateBy: 20 @ 18 ].


	label := BlTextElement new.
	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color red) }).
	label text fontSize: 36.
	label transformDo: [ :t | t translateBy: 220 @ 11 ].
	self addChild: label.
	self addChild: text.
	self initializeAnimation: 15
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> label [ 

^label
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> nbSteps [

^nbSteps
]

{ #category : 'instance creation' }
MfPerformanceStepsDisplayer >> newMooflodSkin [

	^ MfPerformanceStepsDisplayerSkin new 
]

{ #category : 'as yet unclassified' }
MfPerformanceStepsDisplayer >> pauseAnimation: aDuration [

	animation := BlAnimation new duration: aDuration seconds.
	animation loops: 1.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				self animationIsRunning: false]).
	self addAnimation: animation
]

{ #category : 'initialization' }
MfPerformanceStepsDisplayer >> setStepsLabel: aNbOfSteps [

	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color red) }).
	label text fontSize: 36
]

{ #category : 'accessing' }
MfPerformanceStepsDisplayer >> text [
^text
]
