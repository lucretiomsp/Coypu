Class {
	#name : 'MfMasterDelayElementTest',
	#superclass : 'TestCase',
	#category : 'Mooflod-MasterDelayWidget',
	#package : 'Mooflod',
	#tag : 'MasterDelayWidget'
}

{ #category : 'tests' }
MfMasterDelayElementTest >> testIfCirclesAreAddedCorrectly [

	| circle |
	circle := MfMasterDelayElement new.
	circle setValue: 80.
	"Increment the circles in the widget each 4% incrementation"
	self assert: circle numberOfCircles equals: 20.
]

{ #category : 'tests' }
MfMasterDelayElementTest >> testIfValueIsInitializedCorrectly [

	| circle |
	circle := MfMasterDelayElement new.
	circle setValue: 12.
	self assert: circle value equals: 12
]

{ #category : 'tests' }
MfMasterDelayElementTest >> testNothingAddedIfValueIsTooHigh [

	| circle |
	circle := MfMasterDelayElement new.
	circle setValue: 108.
	"The fractal circle works with percentage, so value is set to max if too high"
	self assert: circle value equals: 100.
	self assert: circle numberOfCircles equals: 25.
]
