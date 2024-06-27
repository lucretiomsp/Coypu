Class {
	#name : 'MfMasterDelayElement',
	#superclass : 'ToElement',
	#instVars : [
		'currentX',
		'currentY',
		'value',
		'nbOfChilds'
	],
	#category : 'Mooflod-MasterDelayWidget',
	#package : 'Mooflod',
	#tag : 'MasterDelayWidget'
}

{ #category : 'example' }
MfMasterDelayElement class >> exampleSimpleFractalCircle [

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

{ #category : 'initialization' }
MfMasterDelayElement >> circleExtent [

	^ 390 @ 390
]

{ #category : 'internal' }
MfMasterDelayElement >> createCircle: x y: anY [

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c
]

{ #category : 'internal' }
MfMasterDelayElement >> createCircle: x y: anY color: aColor [

	| c color |
	color := Color gray: aColor.
	c := MfCircleElement new size: x @ anY.
	c background: color.
	self addChild: c
]

{ #category : 'accessing' }
MfMasterDelayElement >> currentX [

^currentX.
]

{ #category : 'accessing' }
MfMasterDelayElement >> currentY [ 
^currentY.
]

{ #category : 'initialization' }
MfMasterDelayElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent.
]

{ #category : 'initialization' }
MfMasterDelayElement >> initialize [

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self background: Color white.
	self layout: BlFrameLayout new.
	value := 0
]

{ #category : 'accessing' }
MfMasterDelayElement >> numberOfCircles [

^nbOfChilds 
]

{ #category : 'public api' }
MfMasterDelayElement >> setValue: aValue [

	(aValue between: 0 and: 100)
		ifTrue: [ value := aValue ]
		ifFalse: [  value := 100 ].
	nbOfChilds := value / 4.
	self updateCircles
]

{ #category : 'internal' }
MfMasterDelayElement >> updateCircles [

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

{ #category : 'evaluating' }
MfMasterDelayElement >> value [

^value.
]
