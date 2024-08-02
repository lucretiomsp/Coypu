Class {
	#name : #MfMasterDelayElement,
	#superclass : #ToElement,
	#instVars : [
		'currentX',
		'currentY',
		'delayAmount',
		'delayTime',
		'nbOfChilds'
	],
	#category : #'Mooflod-MasterDelayWidget'
}

{ #category : #example }
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

{ #category : #initialization }
MfMasterDelayElement >> circleExtent [

	^ 104 @ 104
]

{ #category : #internal }
MfMasterDelayElement >> createCircle: x y: anY [

	| c |
	c := MfCircleElement new size: x @ anY.
	self addChild: c
]

{ #category : #internal }
MfMasterDelayElement >> createCircle: x y: anY color: aColor [

	| c color |
	color := Color r: aColor g: 255 b:0.
	c := MfCircleElement new size: x @ anY.
	c background: color.
	self addChild: c
]

{ #category : #accessing }
MfMasterDelayElement >> currentX [

^currentX.
]

{ #category : #accessing }
MfMasterDelayElement >> currentY [ 
^currentY.
]

{ #category : #initialization }
MfMasterDelayElement >> defaultGeometry [

	^ BlCircleGeometry new matchExtent: self extent.
]

{ #category : #evaluating }
MfMasterDelayElement >> delayAmount [

	^ delayAmount
]

{ #category : #'public api' }
MfMasterDelayElement >> delayAmount: aValue [

	(aValue between: 0 and: 100)
		ifTrue: [ delayAmount := aValue ]
		ifFalse: [ delayAmount := 100 ].
	nbOfChilds := delayAmount / 4.
	self updateCircles
]

{ #category : #accessing }
MfMasterDelayElement >> delayTime [ 

^delayTime 
]

{ #category : #accessing }
MfMasterDelayElement >> delayTime: aDelay [

	delayTime := aDelay.
	self background: (Color r: self rColor g: 255 b: 0).
	^self rColor 
]

{ #category : #initialization }
MfMasterDelayElement >> initialize [

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	delayAmount := 0.
	delayTime := 0
]

{ #category : #accessing }
MfMasterDelayElement >> numberOfCircles [

^nbOfChilds 
]

{ #category : #accessing }
MfMasterDelayElement >> rColor [

	^ 0 + (12.75 * (delayTime * 10))
]

{ #category : #initialization }
MfMasterDelayElement >> setValue: aFloat [

	self delayAmount: (aFloat * 98 ) + 0.1
]

{ #category : #internal }
MfMasterDelayElement >> updateCircles [

	currentX := 104.
	currentY := 104.
	1 to: delayAmount / 4 do: [ :i |
		currentX := currentX - 4.
		currentY := currentY - 4.
		self createCircle: currentX y: currentY color: self rColor ]
]
