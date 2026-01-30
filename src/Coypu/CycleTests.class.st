Class {
	#name : 'CycleTests',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
CycleTests >> testArrayAsCycleDuration [

	| array expectedResult |
	array := #( 60 60 60 #( 60 #(60 60))).
	expectedResult := Array with: 1/4 with: 1/4 with: 1/4 with: 1/8 with: 1/16 with: 1/16.
	self assert: array asCycleDurations equals: expectedResult
]

{ #category : 'tests' }
CycleTests >> testCycleOf3QuarterNotesAnd2Quavers [

	| s expectedResult |
	s := #( 60 60 60 #( 60 60 ) ).
	expectedResult := Array
		                  with: 1 / 4
		                  with: 1 / 4
		                  with: 1 / 4
		         
		                  with: 1 / 8
		                  with: 1 / 8.

	self assert: s asCycleDurations equals: expectedResult
]

{ #category : 'tests' }
CycleTests >> testCycleOfQuarterNotes [

	| s expectedResult |
	s := #( 48 59 76 88 ) asCycleDurations.
	expectedResult := Array
		                  with: 1 / 4
		                  with: 1 / 4
		                  with: 1 / 4
		                  with: 1 / 4.

	self assert: s  equals: expectedResult
]
