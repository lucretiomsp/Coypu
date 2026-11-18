"
Tests for GenScale.
"
Class {
	#name : 'GenScaleTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenScaleTest >> scale: aSymbol [

	^ GenScaleLibrary default at: aSymbol
]

{ #category : 'tests' }
GenScaleTest >> testDescendingForm [

	| melodicMinor |
	melodicMinor := self scale: #melodicMinor.
	self assert: melodicMinor hasDescendingForm.
	self assert: (melodicMinor semitonesAtStep: 5) equals: 9.
	self assert: (melodicMinor descendingSemitonesAtStep: 5) equals: 8.
	self assert: (melodicMinor descendingSemitonesAtStep: 2) equals: 3.
	self assert: (melodicMinor descendingSemitonesAtStep: 13) equals: 22
]

{ #category : 'tests' }
GenScaleTest >> testHeptatonic [

	self assert: (self scale: #major) isHeptatonic.
	self assert: (self scale: #rast) isHeptatonic.
	self deny: (self scale: #majorPentatonic) isHeptatonic
]

{ #category : 'tests' }
GenScaleTest >> testMajorSemitones [

	self assert: (self scale: #major) semitones equals: #( 0 2 4 5 7 9 11 )
]

{ #category : 'tests' }
GenScaleTest >> testQuarterToneScale [

	self assert: (self scale: #rast) semitones equals: #( 0 2 3.5 5 7 9 10.5 )
]

{ #category : 'tests' }
GenScaleTest >> testStepsBeyondTheOctave [

	| major |
	major := self scale: #major.
	self assert: (major semitonesAtStep: 7) equals: 12.
	self assert: (major semitonesAtStep: 9) equals: 16.
	self assert: (major semitonesAtStep: -1) equals: -1.
	self assert: (major semitonesAtStep: -7) equals: -12
]

{ #category : 'tests' }
GenScaleTest >> testWithoutDescendingFormBothDirectionsAgree [

	| dorian |
	dorian := self scale: #dorian.
	self deny: dorian hasDescendingForm.
	0 to: 13 do: [ :step |
		self assert: (dorian descendingSemitonesAtStep: step) equals: (dorian semitonesAtStep: step) ]
]
