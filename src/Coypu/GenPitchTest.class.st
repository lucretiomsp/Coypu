"
Tests for GenPitch.
"
Class {
	#name : 'GenPitchTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenPitchTest >> testEquality [

	self assert: (GenPitch midi: 60 step: 0) equals: (GenPitch midi: 60 step: 0).
	self assert: (GenPitch midi: 60 step: 0) hash equals: (GenPitch midi: 60 step: 0) hash.
	self deny: (GenPitch midi: 60 step: 0) = (GenPitch midi: 60 step: 7)
]

{ #category : 'tests' }
GenPitchTest >> testForms [

	| pitch |
	pitch := GenPitch midi: 69 step: 5 ascending: true descending: false.
	self assert: pitch isAscendingForm.
	self deny: pitch isDescendingForm.
	self assert: (GenPitch midi: 60 step: 0) isAscendingForm.
	self assert: (GenPitch midi: 60 step: 0) isDescendingForm
]

{ #category : 'tests' }
GenPitchTest >> testNames [

	self assert: (GenPitch nameOfMidi: 60) equals: 'C4'.
	self assert: (GenPitch nameOfMidi: 61) equals: 'C#4'.
	self assert: (GenPitch nameOfMidi: 21) equals: 'A0'.
	self assert: (GenPitch nameOfMidi: 60.5) equals: 'C#4-50c'.
	self assert: (GenPitch nameOfMidi: 63.86) equals: 'E4-14c'.
	self assert: (GenPitch midi: 67 step: 4) printString equals: 'G4'
]

{ #category : 'tests' }
GenPitchTest >> testPitchClassNames [

	self assert: (GenPitch nameOfPitchClass: 0) equals: 'C'.
	self assert: (GenPitch nameOfPitchClass: 3.5) equals: 'E-50c'
]

{ #category : 'tests' }
GenPitchTest >> testSamePitchClass [

	self assert: ((GenPitch midi: 72 step: 7) isSamePitchClassAs: (GenPitch midi: 60 step: 0)).
	self deny: ((GenPitch midi: 61 step: 1) isSamePitchClassAs: (GenPitch midi: 60 step: 0))
]
