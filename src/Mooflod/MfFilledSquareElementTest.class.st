Class {
	#name : #MfFilledSquareElementTest,
	#superclass : #TestCase,
	#category : #'Mooflod-FilledSquareWidget'
}

{ #category : #tests }
MfFilledSquareElementTest >> testSquareIsFilledCorrectly [

	| square |
	square := MfFilledSquareElement new.
	square setValue: 56.
	"increase the y coordonate of the rectangle that fills the square by (2x value) "
	self assert: square currentY equals: 112
]

{ #category : #tests }
MfFilledSquareElementTest >> testSquaredIsNotFilledAtAllAtInitialization [

	| square |
	square := MfFilledSquareElement new.
	self assert: square currentY equals: 0 
]
