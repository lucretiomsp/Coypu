"
Tests for the rhythm sources.
"
Class {
	#name : 'GenRhythmSourceTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenRhythmSourceTest >> testBlendedSourceFollowsTheSlider [

	| source |
	source := GenBlendedRhythmSource new
		          worldSource: (GenFixedRhythmSource rhythm: (GenRhythm pattern: 'x.x.'));
		          randomSource: (GenFixedRhythmSource rhythm: (GenRhythm pattern: 'xxxx'));
		          worldAmount: 0.3;
		          yourself.
	self
		assert: (source rhythmOfSize: 4 random: (GenScriptedRandom values: #( 0.2 ))) asString
		equals: 'x.x.'.
	self
		assert: (source rhythmOfSize: 4 random: (GenScriptedRandom values: #( 0.4 ))) asString
		equals: 'xxxx'
]

{ #category : 'tests' }
GenRhythmSourceTest >> testFixedSourceTilesItsRhythm [

	| source |
	source := GenFixedRhythmSource rhythm: (GenRhythm pattern: 'x...').
	self assert: (source rhythmOfSize: 8 random: nil) asString equals: 'x...x...'
]

{ #category : 'tests' }
GenRhythmSourceTest >> testRandomSourceAtFullDensityFiresEverywhere [

	| rhythm |
	rhythm := GenRandomRhythmSource new
		          density: 1;
		          rhythmOfSize: 16 random: (Random seed: 1).
	self assert: rhythm onsetCount equals: 16
]

{ #category : 'tests' }
GenRhythmSourceTest >> testRandomSourceFollowsTheDice [

	| rhythm |
	rhythm := GenRandomRhythmSource new
		          density: 0.5;
		          rhythmOfSize: 4 random: (GenScriptedRandom values: #( 0.9 0.1 0.6 )).
	self assert: rhythm asString equals: 'x.x.'
]

{ #category : 'tests' }
GenRhythmSourceTest >> testRandomSourceWithoutDensityKeepsTheAnchor [

	| rhythm |
	rhythm := GenRandomRhythmSource new
		          density: 0;
		          rhythmOfSize: 16 random: (Random seed: 1).
	self assert: rhythm onsets equals: #( 1 )
]

{ #category : 'tests' }
GenRhythmSourceTest >> testWorldSourceGivesALibraryRhythm [

	| rhythm |
	rhythm := GenWorldRhythmSource new rhythmOfSize: 16 random: (Random seed: 2).
	self assert: rhythm size equals: 16.
	self assert: (GenRhythmLibrary default rhythms anySatisfy: [ :each | (each fittedTo: 16) = rhythm ])
]
