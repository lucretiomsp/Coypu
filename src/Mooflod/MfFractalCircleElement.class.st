Class {
	#name : #MfFractalCircleElement,
	#superclass : #ToElement,
	#instVars : [
		'currentX',
		'currentY',
		'value',
		'nbOfChilds'
	],
	#category : #'Mooflod-FractalCircleWidget'
}

{ #category : #example }
MfFractalCircleElement class >> exampleSimpleFractalCircle [

	<script>
	| c space |
	c := self new.
	c setValue: 100.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	c transformDo: [ :c | c translateBy: 200 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: c.
	space show.
	^ c
]

{ #category : #initialization }
MfFractalCircleElement >> circleExtent [

	^ 390 @ 390
]

{ #category : #internal }
MfFractalCircleElement >> createCircle: x y: anY [

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c
]

{ #category : #internal }
MfFractalCircleElement >> createCircle: x y: anY color: aColor [

	| c color |
	color := Color gray: aColor.
	c := MfCircleElement new size: x @ anY.
	c background: color.
	self addChild: c
]

{ #category : #accessing }
MfFractalCircleElement >> currentX [

^currentX.
]

{ #category : #accessing }
MfFractalCircleElement >> currentY [ 
^currentY.
]

{ #category : #initialization }
MfFractalCircleElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent.
]

{ #category : #initialization }
MfFractalCircleElement >> initialize [

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self background: Color white.
	self layout: BlFrameLayout new.
	value := 0
]

{ #category : #accessing }
MfFractalCircleElement >> numberOfCircles [

^nbOfChilds 
]

{ #category : #'public api' }
MfFractalCircleElement >> setValue: aValue [

	(aValue between: 0 and: 100)
		ifTrue: [ value := aValue ]
		ifFalse: [  value := 100 ].
	nbOfChilds := value / 4.
	self updateCircles
]

{ #category : #internal }
MfFractalCircleElement >> updateCircles [

	| c |
	c := 1.
	currentX := 390.
	currentY := 390.
	1 to: value / 4 do: [ :i |
		c := c - 0.04.
		currentX := currentX - 15.
		currentY := currentY - 15.
		self createCircle: currentX y: currentY color: c ]
]

{ #category : #evaluating }
MfFractalCircleElement >> value [

^value.
]
