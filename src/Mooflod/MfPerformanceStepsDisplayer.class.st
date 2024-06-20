Class {
	#name : #MfPerformanceStepsDisplayer,
	#superclass : #ToElement,
	#instVars : [
		'label',
		'nbSteps',
		'text',
		'animation',
		'animationIsRunning'
	],
	#category : #'Mooflod-PerformanceStepsDisplayer'
}

{ #category : #example }
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

{ #category : #adding }
MfPerformanceStepsDisplayer >> addSteps: aNbOfSteps [
	(aNbOfSteps between: 1 and: 30000) ifTrue: [  	nbSteps := aNbOfSteps.
	self initializeStepsLabel]

]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> animation [

	^ animation
]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> animationIsRunning [

	^ animationIsRunning 
]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> animationIsRunning: aBoolean [

	animationIsRunning := aBoolean
]

{ #category : #initialization }
MfPerformanceStepsDisplayer >> initialize [

	super initialize.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 18).
	self size: 350 @ 160.
	self background: Color black.
	animationIsRunning := false
]

{ #category : #initialization }
MfPerformanceStepsDisplayer >> initializeAnimation: aBpm [

	animationIsRunning := true.
	animation := BlAnimation new duration: (60 / 4 / aBpm) seconds.
	animation beInfinite.
	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 animationIsRunning ifTrue: [
					 nbSteps < 30000 ifTrue: [
						 nbSteps := nbSteps + 1.
						 self setStepsLabel: nbSteps ] ] ]).
	self addAnimation: animation
]

{ #category : #initialization }
MfPerformanceStepsDisplayer >> initializeStepsLabel [

	text := BlTextElement new.
	text text:
		('Performance elapsed number of steps' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	text text fontSize: 19.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	text transformDo: [ :t |
		t translateBy: 0@10 ].


	label := BlTextElement new.
	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	label text fontSize: 22.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: label.
	self addChild: text.
	self initializeAnimation: 139
]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> label [ 

^label
]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> nbSteps [

^nbSteps
]

{ #category : #'instance creation' }
MfPerformanceStepsDisplayer >> newMooflodSkin [

	^ MfPerformanceStepsDisplayerSkin new 
]

{ #category : #initialization }
MfPerformanceStepsDisplayer >> setStepsLabel: aNbOfSteps [

	label text: (nbSteps asString asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color green) }).
	label text fontSize: 22.

]

{ #category : #accessing }
MfPerformanceStepsDisplayer >> text [
^text
]
