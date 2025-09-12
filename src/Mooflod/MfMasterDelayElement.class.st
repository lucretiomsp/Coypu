Class {
	#name : 'MfMasterDelayElement',
	#superclass : 'ToElement',
	#instVars : [
		'currentX',
		'currentY',
		'delayAmount',
		'delayTime',
		'nbOfChilds'
	],
	#category : 'Mooflod-MasterWidgets',
	#package : 'Mooflod',
	#tag : 'MasterWidgets'
}

{ #category : 'example' }
MfMasterDelayElement class >> exampleSimpleFractalCircle [

	<script>
	| c space |
	c := self new.
	c delayTime: 2.
	c delayAmount: 150.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	c transformDo: [ :child | child translateBy: 200 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: c.
	space show.
	^ c
]

{ #category : 'initialization' }
MfMasterDelayElement >> circleExtent [

	^ 200 @ 200
]

{ #category : 'internal' }
MfMasterDelayElement >> createCircle: x y: anY [

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c
]

{ #category : 'internal' }
MfMasterDelayElement >> createCircle: x y: anY border: aColor [

	| c color |
	color := Color r: 255 - (aColor * 2 ) g: aColor * 2 b: 0.
	c := MfCircleElement new size: x @ anY.
	c background: BlPaint transparent.
	c border: (BlBorder paint: color width: 1).
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

{ #category : 'evaluating' }
MfMasterDelayElement >> delayAmount [

	^ delayAmount
]

{ #category : 'public api' }
MfMasterDelayElement >> delayAmount: aValue [

	(aValue between: 0 and: 127)
		ifTrue: [ delayAmount := aValue ]
		ifFalse: [ delayAmount := 127 ].
	nbOfChilds := delayAmount / 4.
	self updateCircles
]

{ #category : 'accessing' }
MfMasterDelayElement >> delayTime [ 

^delayTime 
]

{ #category : 'accessing' }
MfMasterDelayElement >> delayTime: aDelay [

	delayTime := aDelay.
	"self background: (Color r: self rColor g: 255 b: 0)."
	self updateCircles .
	^ self rColor
]

{ #category : 'initialization' }
MfMasterDelayElement >> initialize [

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	delayAmount := 0.
	delayTime := 0
]

{ #category : 'accessing' }
MfMasterDelayElement >> numberOfCircles [

^nbOfChilds 
]

{ #category : 'accessing' }
MfMasterDelayElement >> rColor [

	^ 0 + delayTime 
]

{ #category : 'initialization' }
MfMasterDelayElement >> setValue: aFloat [

	self delayAmount: aFloat 
]

{ #category : 'internal' }
MfMasterDelayElement >> updateCircles [

| incFactor |
	self removeChildren.
	currentX := 0.
	currentY := 0.
	incFactor := delayAmount / 7.
	1 to: delayAmount / 3 do: [ :i |
		currentX := currentX + (22 - incFactor).
		currentY := currentY + (22 - incFactor).
		self createCircle: currentX y: currentY border: self rColor ]
]
