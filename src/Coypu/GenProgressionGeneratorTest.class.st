"
Tests for GenProgressionGenerator and GenProgression.
"
Class {
	#name : 'GenProgressionGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'context'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenProgressionGeneratorTest >> chordOnRoot: aPitchClass [

	^ GenChord degree: 1 root: aPitchClass third: 4 fifth: 7 strength: 1
]

{ #category : 'private' }
GenProgressionGeneratorTest >> generatorWith: aRandom [

	^ GenProgressionGenerator context: context random: aRandom
]

{ #category : 'running' }
GenProgressionGeneratorTest >> setUp [

	super setUp.
	context := GenScaleContext scaleNamed: #major root: 0
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testAFourBarPhraseRepeats [

	| progression |
	progression := (self generatorWith: (Random seed: 5))
		               turnaroundProbability: 0;
		               generate: 12.
	1 to: 8 do: [ :bar |
		self assert: (progression chordAtBar: bar + 4) equals: (progression chordAtBar: bar) ]
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testBarsAndStepsWrapAround [

	| progression meter |
	progression := GenProgression withAll: {
			               (context chordOnDegree: 1).
			               (context chordOnDegree: 4) }.
	meter := GenMeter stepsPerBar: 16.
	self assert: (progression chordAtBar: 3) equals: (context chordOnDegree: 1).
	self assert: (progression chordAtStep: 17 meter: meter) equals: (context chordOnDegree: 4).
	self assert: (progression chordAtStep: 33 meter: meter) equals: (context chordOnDegree: 1).
	self assert: (progression lengthInSteps: meter) equals: 32.
	self assert: progression degrees equals: #( 1 4 )
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testItNeedsABar [

	self should: [ (self generatorWith: Random new) generate: 0 ] raise: Error
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testLength [

	self assert: ((self generatorWith: (Random seed: 3)) generate: 7) size equals: 7
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testMicrotonalMovementIsInterpolated [

	| generator weight |
	generator := self generatorWith: Random new.
	weight := generator movementWeightFrom: (self chordOnRoot: 0) to: (self chordOnRoot: 6.5).
	self assert: (weight - ((generator movementWeightAt: 6) + (generator movementWeightAt: 7) / 2)) abs < 1.0e-9
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testRootMovementPreferences [
	"Up a fourth, up a fifth, then bVII, bVI, vi, bIII."

	| generator from weights |
	generator := self generatorWith: Random new.
	from := self chordOnRoot: 0.
	weights := #( 5 7 10 8 9 3 ) collect: [ :each |
		           generator movementWeightFrom: from to: (self chordOnRoot: each) ].
	1 to: weights size - 1 do: [ :index |
		self assert: (weights at: index) > (weights at: index + 1) ]
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testStartsOnTheTonic [

	1 to: 10 do: [ :seed |
		self
			assert: ((self generatorWith: (Random seed: seed)) generate: 4) first
			equals: context tonicChord ]
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testTheScriptedDiceFollowTheWeights [
	"With every draw at 0 the first candidate with a weight wins: the tonic again."

	| progression |
	progression := (self generatorWith: (GenScriptedRandom values: #( 0.0 ))) generate: 3.
	self assert: progression degrees equals: #( 1 1 1 )
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testTurnaroundChangesTheLastBar [

	| progression |
	progression := (self generatorWith: (Random seed: 5))
		               turnaroundProbability: 1;
		               generate: 8.
	self deny: (progression chordAtBar: 8) = (progression chordAtBar: 4).
	1 to: 3 do: [ :bar |
		self assert: (progression chordAtBar: bar + 4) equals: (progression chordAtBar: bar) ]
]

{ #category : 'tests' }
GenProgressionGeneratorTest >> testWeakChordsWeighLess [

	| generator from |
	generator := self generatorWith: Random new.
	from := context chordOnDegree: 3.
	self assert: (generator weightFrom: from to: (context chordOnDegree: 7)) * 5
		< (generator weightFrom: from to: (context chordOnDegree: 6))
]
