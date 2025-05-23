"
MFTimerElement is actually used as a note visualizer in the Mooflod.
name should maybe changed.

"
Class {
	#name : 'MfTimerElement',
	#superclass : 'ToElement',
	#instVars : [
		'anim',
		'timerValue',
		'annulus',
		'currentAngle',
		'decreasingAngleStep',
		'textArray'
	],
	#classVars : [
		'value'
	],
	#category : 'Mooflod-TimerWidget',
	#package : 'Mooflod',
	#tag : 'TimerWidget'
}

{ #category : 'example' }
MfTimerElement class >> exampleSimpleTimer [

	<script>
	| timer space |
	space := BlSpace new.
	space root background: Color black.
	space root layout: BlBasicLayout new.
	timer := MfTimerElement new value: 18.
	timer transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: timer.
	space toTheme: MfMooflodTheme new.
	space show.
	^ timer
]

{ #category : 'accessing' }
MfTimerElement >> annulusGeometry [

	^ BlAnnulusSectorGeometry new
		  startAngle: 0;
		  endAngle: 360;
		  innerRadius: 0.865
]

{ #category : 'visual properties' }
MfTimerElement >> backgroundPaint [ 

	^ Color black.
]

{ #category : 'accessing' }
MfTimerElement >> currentAngle [

^currentAngle .
]

{ #category : 'initialization' }
MfTimerElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent 
]

{ #category : 'initialization' }
MfTimerElement >> initialize [

	super initialize.
	value := 60.
	textArray := Dictionary new.
	self initializeTimerValue.
	self initializeAnnulus.
	
]

{ #category : 'initialization' }
MfTimerElement >> initializeAnimation [

	anim := BlAnimation new
		        duration: 1 seconds;
		        loops: value;
		        addEventHandler: (BlEventHandler
				         on: BlAnimationLoopDoneEvent
				         do: [ :e |
					         currentAngle := currentAngle - decreasingAngleStep.
					         self updateAnnulusAngle: currentAngle.
					         self updateValue.
					         self background: Color random ]).

	self
		addEventHandlerOn: BlMouseDownEvent
		do: [ :a | anim isRunning ifFalse: [ self addAnimation: anim ] ]
]

{ #category : 'initialization' }
MfTimerElement >> initializeAnnulus [

	annulus := BlElement new background: Color yellow.
	annulus size: 65 @ 65.
	annulus geometry: self annulusGeometry.
	annulus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: annulus.
	self initializeAnimation
]

{ #category : 'initialization' }
MfTimerElement >> initializeTimerValue [

	decreasingAngleStep := 360 / value.
	currentAngle := 360.
	timerValue := BlTextElement new.
	timerValue text: value asString asRopedText.
	timerValue text fontSize: 21.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color red) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	textArray at: 'text' put: timerValue.
	self addChild: timerValue
]

{ #category : 'skin' }
MfTimerElement >> newMooflodSkin [ 

	^ MfTimerElementSkin new
]

{ #category : 'initialization' }
MfTimerElement >> replaceTimerTextValue: aValue [

	self children size = 2
		ifTrue: [ (textArray at: 'text') removeFromParent ]
		ifFalse: [  ].

	timerValue := BlTextElement new.
	timerValue text: aValue asString asRopedText.
	timerValue text fontSize: 21.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color yellow) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	textArray at: 'text' put: timerValue.
	self addChild: timerValue
]

{ #category : 'accessing' }
MfTimerElement >> setValue: aValue [

self value: (69 + (12 * (aValue / 440 log: 2))) asInteger.
]

{ #category : 'accessing' }
MfTimerElement >> textArray [ 

^textArray 
]

{ #category : 'accessing' }
MfTimerElement >> timerValue [

^timerValue
]

{ #category : 'visual properties' }
MfTimerElement >> updateAnnulusAngle: newAngle [

	annulus geometry: (BlAnnulusSectorGeometry new
			 startAngle: 0;
			 endAngle: newAngle;
			 innerRadius: 0.865)
]

{ #category : 'evaluating' }
MfTimerElement >> updateValue [

	value := value - 1.
	timerValue removeFromParent.
	self replaceTimerTextValue: value
]

{ #category : 'evaluating' }
MfTimerElement >> value [ 
		^value.
]

{ #category : 'accessing' }
MfTimerElement >> value: aValue [

	value := aValue.
	self replaceTimerTextValue: aValue 
]
