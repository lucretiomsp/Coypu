Class {
	#name : 'MfFractalCircleElementTest',
	#superclass : 'TestCase',
	#category : 'Mooflod-FractalCircleWidget',
	#package : 'Mooflod',
	#tag : 'FractalCircleWidget'
}

{ #category : 'tests' }
MfFractalCircleElementTest >> testIfCirclesAreAddedCorrectly [

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 80.
	"Increment the circles in the widget each 4% incrementation"
	self assert: circle numberOfCircles equals: 20.
]

{ #category : 'tests' }
MfFractalCircleElementTest >> testIfValueIsInitializedCorrectly [

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 12.
	self assert: circle value equals: 12
]

{ #category : 'tests' }
MfFractalCircleElementTest >> testNothingAddedIfValueIsTooHigh [

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 108.
	"The fractal circle works with percentage, so value is set to max if too high"
	self assert: circle value equals: 100.
	self assert: circle numberOfCircles equals: 25.
]
