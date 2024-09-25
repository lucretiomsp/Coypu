Class {
	#name : 'MfFilledSquareElement',
	#superclass : 'ToElement',
	#instVars : [
		'currentY',
		'fill'
	],
	#classVars : [
		'value'
	],
	#category : 'Mooflod-FilledSquareWidget',
	#package : 'Mooflod',
	#tag : 'FilledSquareWidget'
}

{ #category : 'example' }
MfFilledSquareElement class >> exampleSimpleFilledSquare [

	<script>
	| aSquare space |
	aSquare := self new.
	aSquare delayAmount: 65.

	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare transformDo: [ :c | c translateBy: 280 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: aSquare.
	space show.
	^ aSquare
]

{ #category : 'accessing' }
MfFilledSquareElement >> currentY [

^currentY
]

{ #category : 'initialization' }
MfFilledSquareElement >> defaultGeometry [ 

^BlSquareGeometry new 
]

{ #category : 'initialization' }
MfFilledSquareElement >> delayAmount: aValue [ 
	(aValue between: 0 and: 100) ifTrue: [ self value: aValue ].
	self updateSquare.
]

{ #category : 'accessing' }
MfFilledSquareElement >> fill [ 
^fill
]

{ #category : 'initialization' }
MfFilledSquareElement >> initFill [

	fill := MfFillingLineElement new .
	self addChild: fill
]

{ #category : 'initialization' }
MfFilledSquareElement >> initialize [

	super initialize.
	self size: self squareExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	self initFill.
	value := 0
]

{ #category : 'as yet unclassified' }
MfFilledSquareElement >> openFilledSquare: aSquare [

	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare transformDo: [ :c | c translateBy: 280 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: aSquare.
	space show.
	^ aSquare
]

{ #category : 'as yet unclassified' }
MfFilledSquareElement >> squareExtent [

	currentY := 0.
	^ 200 @ 200
]

{ #category : 'as yet unclassified' }
MfFilledSquareElement >> updateFill: anY [

	fill size:200@anY
]

{ #category : 'as yet unclassified' }
MfFilledSquareElement >> updateSquare [

	currentY := 0.
	1 to: value do: [ :i |
		currentY := currentY + 2.
		self updateFill: currentY ]
]

{ #category : 'evaluating' }
MfFilledSquareElement >> value [ 
^value
]

{ #category : 'accessing' }
MfFilledSquareElement >> value: aValue [

value:= aValue 
]
