Class {
	#name : 'MfTimerElement',
	#superclass : 'ToElement',
	#instVars : [
		'anim',
		'timerValue',
		'annulus',
		'currentAngle',
		'decreasingAngleStep'
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
MfTimerElement >> initializeAnimation [

	| started |
	anim := BlAnimation new
		        duration: 1 seconds;
		        loops: value.
	started := false.
	
	self addEventHandlerOn: BlMouseDownEvent do: [ :a |
		started ifFalse: [ 
			started := true.
		anim addEventHandler: (BlEventHandler
				 on: BlAnimationLoopDoneEvent
				 do: [ :e |
					 currentAngle := currentAngle - decreasingAngleStep.
					 self updateAnnulusAngle: currentAngle.
					 self updateValue.
					 self background: Color random ]) ]] .

	self addAnimation: anim
]

{ #category : 'initialization' }
MfTimerElement >> initializeAnnulus [

	annulus := BlElement new background: Color lightOrange.
	annulus size: 300 @ 300.
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
	self replaceTimerTextValue: value.
	self initializeAnnulus
]

{ #category : 'skin' }
MfTimerElement >> newMooflodSkin [ 

	^ MfTimerElementSkin new
]

{ #category : 'initialization' }
MfTimerElement >> replaceTimerTextValue: aValue [

	timerValue := BlTextElement new.
	timerValue text: aValue asString asRopedText.
	timerValue text fontSize: 100.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color lightOrange) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChild: timerValue
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
	self initializeTimerValue .
]
