Class {
	#name : #MfMasterDelayElementTest,
	#superclass : #TestCase,
	#category : 'Mooflod-MasterDelayWidget'
}

{ #category : #tests }
MfMasterDelayElementTest >> testIfCirclesAreAddedCorrectly [

	| circle |
	circle := MfMasterDelayElement new.
	circle delayAmount: 80.
	"Increment the circles in the widget each 4% incrementation"
	self assert: circle numberOfCircles equals: 20.
]

{ #category : #tests }
MfMasterDelayElementTest >> testIfValueIsInitializedCorrectly [

	| circle |
	circle := MfMasterDelayElement new.
	circle delayAmount: 12.
	self assert: circle delayAmount equals: 12
]

{ #category : #tests }
MfMasterDelayElementTest >> testNothingAddedIfValueIsTooHigh [

	| circle |
	circle := MfMasterDelayElement new.
	circle delayAmount: 108.
	"The fractal circle works with percentage, so value is set to max if too high"
	self assert: circle delayAmount equals: 100.
	self assert: circle numberOfCircles equals: 25
]
