Class {
	#name : 'MfPulsingSquare',
	#superclass : 'BlElement',
	#instVars : [
		'flashingAnimation'
	],
	#category : 'Mooflod-PulsingSquare',
	#package : 'Mooflod',
	#tag : 'PulsingSquare'
}

{ #category : 'example' }
MfPulsingSquare class >> exampleSimplePulsingSquare [

	<script>
	| space aSquare |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare := MfPulsingSquare new.
	aSquare initializeAnimation: 0.5.
	aSquare transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aSquare.
	space show.
	^ aSquare
]

{ #category : 'as yet unclassified' }
MfPulsingSquare >> changeAnimationTime: aTime [

	flashingAnimation duration: aTime seconds 
]

{ #category : 'accessing' }
MfPulsingSquare >> flashingAnimation [

^flashingAnimation 
]

{ #category : 'initialization' }
MfPulsingSquare >> initialize [

	super initialize.
	self geometry: BlSquareGeometry new.
	self background: Color white.
	self size: 40 @ 40.
	self border: (BlBorder paint: Color black).
]

{ #category : 'initialization' }
MfPulsingSquare >> initializeAnimation [

	flashingAnimation := BlAnimation new duration: 0.5 seconds.
	flashingAnimation beInfinite.
	flashingAnimation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 self background paint color = Color white
					 ifTrue: [ self background: Color red ]
					 ifFalse: [ self background: Color white ] ]).
	self addAnimation: flashingAnimation
	

]

{ #category : 'initialization' }
MfPulsingSquare >> initializeAnimation: aTime [

	flashingAnimation := BlAnimation new duration: aTime seconds.
	flashingAnimation beInfinite.
	flashingAnimation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :e |
				 self background paint color = Color white
					 ifTrue: [ self background: Color red ]
					 ifFalse: [ self background: Color white ] ]).
	self addAnimation: flashingAnimation
	

]
