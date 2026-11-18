"
Tests for GenTuning.
"
Class {
	#name : 'GenTuningTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenTuningTest >> testEt12StepsAreSemitones [

	self assert: (GenTuning et12 semitonesAt: 7) equals: 7.
	self assert: GenTuning et12 size equals: 12.
	self deny: GenTuning et12 isJustIntonation
]

{ #category : 'tests' }
GenTuningTest >> testEt24StepsAreQuarterTones [

	| et24 |
	et24 := GenTuning et24.
	self assert: et24 size equals: 24.
	self assert: (et24 semitonesAt: 3) equals: 1.5.
	self assert: (et24 semitonesAt: 4) equals: 2
]

{ #category : 'tests' }
GenTuningTest >> testPartchIsJustIntonation [

	| partch |
	partch := GenTuning partch.
	self assert: partch size equals: 43.
	self assert: partch isJustIntonation.
	self assert: (partch semitonesAt: 0) equals: 0.
	self assert: ((partch semitonesAt: 25) - 7.01955) abs < 0.0001
]

{ #category : 'tests' }
GenTuningTest >> testSemitonesOfRatio [

	self assert: ((GenTuning semitonesOfRatio: 2) - 12) abs < 1.0e-9.
	self assert: ((GenTuning semitonesOfRatio: 5 / 4) - 3.86314) abs < 0.0001
]

{ #category : 'tests' }
GenTuningTest >> testStepsWrapAroundTheOctave [

	self assert: (GenTuning et12 semitonesAt: 14) equals: 14.
	self assert: (GenTuning et12 semitonesAt: -1) equals: -1.
	self assert: (GenTuning et24 semitonesAt: 25) equals: 12.5
]

{ #category : 'tests' }
GenTuningTest >> testValueEquality [

	self assert: GenTuning et12 equals: GenTuning et12.
	self assert: GenTuning et12 hash equals: GenTuning et12 hash.
	self deny: GenTuning et12 = GenTuning et24
]
