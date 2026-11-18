"
Tests for GenChord and the chord builders.
"
Class {
	#name : 'GenChordBuilderTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenChordBuilderTest >> testChordIncludesItsTonesInAnyOctave [

	| chord |
	chord := (GenScaleContext scaleNamed: #major root: 0) chordOnDegree: 1.
	self assert: (chord includesPitch: (GenPitch midi: 76 step: 0)).
	self deny: (chord includesPitch: (GenPitch midi: 77 step: 0)).
	self assert: (chord rootMatches: (GenPitch midi: 36 step: 0)).
	self deny: (chord rootMatches: (GenPitch midi: 43 step: 0))
]

{ #category : 'tests' }
GenChordBuilderTest >> testFactoryPicksTheBuilder [

	self
		assert: (GenChordBuilder forScale: (GenScaleLibrary default at: #major)) class
		equals: GenTertianChordBuilder.
	self
		assert: (GenChordBuilder forScale: (GenScaleLibrary default at: #majorPentatonic)) class
		equals: GenClosestIntervalChordBuilder
]

{ #category : 'tests' }
GenChordBuilderTest >> testHeptatonicScalesStackThirds [

	| context |
	context := GenScaleContext scaleNamed: #major root: 0.
	self assert: (context chordOnDegree: 1) tones equals: #( 0 4 7 ).
	self assert: (context chordOnDegree: 5) tones equals: #( 7 11 2 ).
	self assert: (context chordOnDegree: 7) tones equals: #( 11 2 5 )
]

{ #category : 'tests' }
GenChordBuilderTest >> testPartchOtonalityGivesAPureTriad [

	| chord |
	chord := (GenScaleContext scaleNamed: #partch_o1 root: 0) chordOnDegree: 1.
	self assert: (chord third - (GenTuning semitonesOfRatio: 5 / 4)) abs < 1.0e-6.
	self assert: (chord fifth - (GenTuning semitonesOfRatio: 3 / 2)) abs < 1.0e-6.
	self assert: chord strength > 0.99
]

{ #category : 'tests' }
GenChordBuilderTest >> testPentatonicChordsUseTheClosestThirdAndFifth [

	| chord |
	chord := (GenScaleContext scaleNamed: #majorPentatonic root: 0) chordOnDegree: 1.
	self assert: chord third equals: 4.
	self assert: chord fifth equals: 7
]

{ #category : 'tests' }
GenChordBuilderTest >> testQuarterToneScalesGetNeutralThirds [

	| chord |
	chord := (GenScaleContext scaleNamed: #rast root: 0) chordOnDegree: 1.
	self assert: chord third equals: 3.5.
	self assert: chord fifth equals: 7.
	self assert: chord strength < ((GenScaleContext scaleNamed: #major root: 0) chordOnDegree: 1) strength
]

{ #category : 'tests' }
GenChordBuilderTest >> testTransposedChords [

	self assert: ((GenScaleContext scaleNamed: #dorian root: 2) chordOnDegree: 1) tones equals: #( 2 5 9 )
]

{ #category : 'tests' }
GenChordBuilderTest >> testWeakChordsAreWeaker [

	| context |
	context := GenScaleContext scaleNamed: #major root: 0.
	self assert: (context chordOnDegree: 7) strength < ((context chordOnDegree: 1) strength / 2).
	self assert: (context chordOnDegree: 6) strength > (context chordOnDegree: 7) strength
]

{ #category : 'tests' }
GenChordBuilderTest >> testWholeToneTriadsHaveAWeakFifth [

	| chord |
	chord := (GenScaleContext scaleNamed: #whole root: 0) chordOnDegree: 1.
	self assert: chord third equals: 4.
	self assert: chord strength < 0.2
]
