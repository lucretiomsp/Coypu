"
Tests for GenConsonance.
"
Class {
	#name : 'GenConsonanceTest',
	#superclass : 'TestCase',
	#instVars : [
		'consonance'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
GenConsonanceTest >> setUp [

	super setUp.
	consonance := GenConsonance new
]

{ #category : 'tests' }
GenConsonanceTest >> testIntervalRanking [

	self assert: (consonance ofInterval: 7) > (consonance ofInterval: 4).
	self assert: (consonance ofInterval: 4) > (consonance ofInterval: 3).
	self assert: (consonance ofInterval: 3) > (consonance ofInterval: 2).
	self assert: (consonance ofInterval: 2) > (consonance ofInterval: 1).
	self assert: (consonance ofInterval: 6) < (consonance ofInterval: 5).
	self assert: (consonance ofInterval: 5) < (consonance ofInterval: 7)
]

{ #category : 'tests' }
GenConsonanceTest >> testIntervalsFoldIntoTheOctave [

	self assert: (consonance ofInterval: 19) equals: (consonance ofInterval: 7).
	self assert: (consonance ofInterval: -5) equals: (consonance ofInterval: 7).
	self assert: (consonance ofInterval: -7) equals: (consonance ofInterval: 5)
]

{ #category : 'tests' }
GenConsonanceTest >> testJustIntervalsSitOnThePeaks [

	| justThird |
	justThird := GenTuning semitonesOfRatio: 5 / 4.
	self assert: ((consonance ofInterval: justThird) - 0.85) abs < 0.001.
	self assert: (consonance ofInterval: justThird) > (consonance ofInterval: 4)
]

{ #category : 'tests' }
GenConsonanceTest >> testNeverZero [

	self assert: (consonance ofInterval: 1) > 0.
	self assert: (consonance ofInterval: 0.5) > 0.
	self assert: (consonance ofInterval: 6.5) > 0
]

{ #category : 'tests' }
GenConsonanceTest >> testQuarterTonesFallInBetween [

	| neutralThird |
	neutralThird := consonance ofInterval: 3.5.
	self assert: neutralThird < (consonance ofInterval: 3).
	self assert: neutralThird > (consonance ofInterval: 2)
]

{ #category : 'tests' }
GenConsonanceTest >> testThirdAndFifthLikeness [

	self assert: (consonance thirdLikenessOf: 4) > (consonance thirdLikenessOf: 2).
	self assert: (consonance thirdLikenessOf: 3) > (consonance thirdLikenessOf: 5).
	self assert: (consonance thirdLikenessOf: 3.5) > (consonance thirdLikenessOf: 2.5).
	self assert: (consonance fifthLikenessOf: 7) > 0.99.
	self assert: (consonance fifthLikenessOf: 6) < 0.01
]

{ #category : 'tests' }
GenConsonanceTest >> testUnisonAndOctaveArePerfect [

	self assert: (consonance ofInterval: 0) equals: 1.0.
	self assert: (consonance ofInterval: 12) equals: 1.0.
	self assert: (consonance ofInterval: -24) equals: 1.0
]

{ #category : 'tests' }
GenConsonanceTest >> testWidthControlsTheTolerance [

	| strict |
	strict := GenConsonance new
		          width: 5.0;
		          yourself.
	self assert: (strict ofInterval: 4) < (consonance ofInterval: 4).
	self assert: ((strict ofInterval: 7) - (consonance ofInterval: 7)) abs < 0.1
]
