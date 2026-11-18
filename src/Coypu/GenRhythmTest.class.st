"
Tests for GenRhythm and GenRhythmLibrary.
"
Class {
	#name : 'GenRhythmTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenRhythmTest >> testAsStringRoundTrip [

	self assert: (GenRhythm pattern: 'x.xx..x.') asString equals: 'x.xx..x.'
]

{ #category : 'tests' }
GenRhythmTest >> testEqualityIgnoresNames [

	self assert: (GenRhythm named: #a pattern: 'x.x.') equals: (GenRhythm named: #b pattern: 'x.x.').
	self deny: (GenRhythm pattern: 'x.x.') = (GenRhythm pattern: 'xx..')
]

{ #category : 'tests' }
GenRhythmTest >> testFittedToALongerLaneTiles [

	self assert: ((GenRhythm pattern: 'x..') fittedTo: 7) asString equals: 'x..x..x'
]

{ #category : 'tests' }
GenRhythmTest >> testFittedToAShorterLaneCuts [

	self assert: ((GenRhythm pattern: 'x..x..x.') fittedTo: 5) asString equals: 'x..x.'
]

{ #category : 'tests' }
GenRhythmTest >> testLibraryKnowsWorldRhythms [

	| names |
	names := GenRhythmLibrary default names.
	#( #tresillo #sonClave #rumbaClave #bembe #cinquillo ) do: [ :each |
		self assert: (names includes: each) ].
	self assert: (GenRhythmLibrary default at: #tresillo) asString equals: 'x..x..x.'.
	self assert: (GenRhythmLibrary default at: #bembe) size equals: 12
]

{ #category : 'tests' }
GenRhythmTest >> testLibraryPrefersRhythmsThatTileTheLane [

	| tiling |
	tiling := GenRhythmLibrary default rhythmsTiling: 12.
	self deny: tiling isEmpty.
	self assert: (tiling allSatisfy: [ :each | 12 \\ each size = 0 ]).
	self
		assert: (GenRhythmLibrary default randomRhythmOfSize: 12 random: (GenScriptedRandom values: #( 0.0 )))
		equals: (GenRhythmLibrary default at: #bembe)
]

{ #category : 'tests' }
GenRhythmTest >> testLibraryRhythmsFitAnyLane [

	#( 8 12 13 16 64 ) do: [ :size |
		self
			assert: (GenRhythmLibrary default randomRhythmOfSize: size random: (Random seed: size)) size
			equals: size ]
]

{ #category : 'tests' }
GenRhythmTest >> testPattern [

	| tresillo |
	tresillo := GenRhythm named: #tresillo pattern: 'x..x..x.'.
	self assert: tresillo size equals: 8.
	self assert: tresillo onsets equals: #( 1 4 7 ).
	self assert: tresillo onsetCount equals: 3.
	self assert: tresillo name equals: #tresillo
]

{ #category : 'tests' }
GenRhythmTest >> testRotation [

	self assert: ((GenRhythm pattern: 'x..x..x.') rotatedBy: 1) asString equals: '..x..x.x'
]

{ #category : 'tests' }
GenRhythmTest >> testStepsWrapAround [

	| rhythm |
	rhythm := GenRhythm pattern: 'x..x'.
	self assert: (rhythm isOnsetAt: 5).
	self deny: (rhythm isOnsetAt: 6)
]
