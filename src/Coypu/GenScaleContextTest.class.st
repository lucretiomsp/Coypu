"
Tests for GenScaleContext.
"
Class {
	#name : 'GenScaleContextTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenScaleContextTest >> testChordsAreBuiltOnEveryDegree [

	| context |
	context := GenScaleContext scaleNamed: #hirajoshi root: 0.
	self assert: context chords size equals: 5.
	self assert: (context chords collect: [ :each | each degree ]) equals: #( 1 2 3 4 5 )
]

{ #category : 'tests' }
GenScaleContextTest >> testDescendingFormsGiveBothPitches [

	| pitches pitchAt |
	pitches := (GenScaleContext scaleNamed: #melodicMinor root: 0) pitchesFrom: 67 to: 72.
	pitchAt := [ :midi | pitches detect: [ :each | each midi = midi ] ].
	self assert: (pitches collect: [ :each | each midi ]) equals: #( 67 68 69 70 71 72 ).
	self assert: (pitchAt value: 69) isAscendingForm.
	self deny: (pitchAt value: 69) isDescendingForm.
	self assert: (pitchAt value: 68) isDescendingForm.
	self deny: (pitchAt value: 68) isAscendingForm.
	self assert: (pitchAt value: 67) isAscendingForm.
	self assert: (pitchAt value: 67) isDescendingForm
]

{ #category : 'tests' }
GenScaleContextTest >> testNames [

	| context |
	context := GenScaleContext scaleNamed: #major root: 9.
	self assert: context printString equals: 'A Major'.
	self assert: context rootName equals: 'A'.
	self assert: (context nameOf: 61) equals: 'C#4'
]

{ #category : 'tests' }
GenScaleContextTest >> testOtonalityTonicIsItsRoot [

	self assert: (GenScaleContext scaleNamed: #partch_o1 root: 0) tonicDegree equals: 1
]

{ #category : 'tests' }
GenScaleContextTest >> testPitchesInRange [

	| pitches |
	pitches := (GenScaleContext scaleNamed: #major root: 0) pitchesFrom: 60 to: 72.
	self assert: (pitches collect: [ :each | each midi ]) equals: #( 60 62 64 65 67 69 71 72 ).
	self assert: (pitches collect: [ :each | each step ]) equals: #( 35 36 37 38 39 40 41 42 )
]

{ #category : 'tests' }
GenScaleContextTest >> testQuarterTonePitches [

	| pitches |
	pitches := (GenScaleContext scaleNamed: #rast root: 0) pitchesFrom: 60 to: 66.
	self assert: (pitches collect: [ :each | each midi ]) equals: #( 60 62 63.5 65 )
]

{ #category : 'tests' }
GenScaleContextTest >> testRandomContextUsesTheLibrary [

	| context |
	context := GenScaleContext random: (Random seed: 1).
	self assert: (GenScaleLibrary default includesKey: context scale key).
	self assert: (context root between: 0 and: 11)
]

{ #category : 'tests' }
GenScaleContextTest >> testRootTransposes [

	| pitches |
	pitches := (GenScaleContext scaleNamed: #dorian root: 2) pitchesFrom: 60 to: 65.
	self assert: (pitches collect: [ :each | each midi ]) equals: #( 60 62 64 65 )
]

{ #category : 'tests' }
GenScaleContextTest >> testScriptedRandomContext [

	| context |
	context := GenScaleContext random: (GenScriptedRandom values: #( 0.0 0.5 )).
	self assert: context scale key equals: GenScaleLibrary default keys first.
	self assert: context root equals: 6
]

{ #category : 'tests' }
GenScaleContextTest >> testTonicChord [

	| chord |
	chord := (GenScaleContext scaleNamed: #major root: 0) tonicChord.
	self assert: chord tones equals: #( 0 4 7 ).
	self assert: chord degree equals: 1
]

{ #category : 'tests' }
GenScaleContextTest >> testTonicIsTheMostConsonantDegreeInJustIntonation [

	(GenScaleLibrary default scales select: [ :each | each isJustIntonation ]) do: [ :scale |
		| context score best |
		context := GenScaleContext scale: scale root: 0.
		score := [ :degree |
		         (context chordOnDegree: degree) strength
		         * (scale consonanceOfDegree: degree using: context consonance) ].
		best := score value: context tonicDegree.
		1 to: scale size do: [ :degree | self assert: (score value: degree) <= best ] ]
]

{ #category : 'tests' }
GenScaleContextTest >> testTonicOfAnEqualTemperedScaleIsTheRoot [

	#( #locrian #major #hirajoshi #rast ) do: [ :each |
		self assert: (GenScaleContext scaleNamed: each root: 5) tonicDegree equals: 1 ]
]

{ #category : 'tests' }
GenScaleContextTest >> testUtonalityTonicIsNotItsRoot [
	"Partch Utonality 1 is 1/1 8/7 4/3 16/11 8/5 16/9: its stable centre is 4/3, the root of the minor triad 4/3 8/5 2/1."

	self assert: (GenScaleContext scaleNamed: #partch_u1 root: 0) tonicDegree equals: 3
]
