"
Tests for GenPitchPool and the randomMelodyFrom: it powers (on Integer and Sequencer). randomNotesFrom: stays truly random.
"
Class {
	#name : 'GenPitchPoolTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenPitchPoolTest >> testAnEmptyPoolIsAnError [

	self should: [ GenPitchPool withAll: #(  ) ] raise: Error
]

{ #category : 'tests' }
GenPitchPoolTest >> testDuplicatesAreIgnored [

	self assert: (GenPitchPool withAll: #( 64 60 64 60 )) midiNotes equals: #( 60 64 )
]

{ #category : 'tests' }
GenPitchPoolTest >> testEveryCountWorks [

	self assert: (0 randomMelodyFrom: #( 60 64 67 )) isEmpty.
	self assert: (1 randomMelodyFrom: #( 60 64 67 )) size equals: 1.
	self assert: (5 randomMelodyFrom: #( 60 )) equals: #( 60 60 60 60 60 )
]

{ #category : 'tests' }
GenPitchPoolTest >> testFillWithRandomMelodyUsesThePerformanceScale [

	| previous scale seq |
	previous := Performance scale.
	scale := Scale sakura: 60.
	[
	Performance scale: scale.
	seq := 16 rumba.
	seq fillWithRandomMelody.
	self assert: seq notes size equals: seq numberOfGates.
	self assert: (seq notes allSatisfy: [ :each | scale includes: each ]) ]
		ensure: [ Performance scale: previous ]
]

{ #category : 'tests' }
GenPitchPoolTest >> testNotesComeFromThePool [

	| scale notes |
	scale := Scale minor: 60.
	notes := 16 randomMelodyFrom: scale.
	self assert: notes size equals: 16.
	self assert: (notes allSatisfy: [ :each | scale includes: each ])
]

{ #category : 'tests' }
GenPitchPoolTest >> testNotesForGatesFollowTheTrigs [

	| pool |
	pool := GenPitchPool withAll: (Scale major: 60).
	self assert: (pool notesForGates: #( 1 0 0 1 0 0 1 0 ) random: (Random seed: 1)) size equals: 3.
	self assert: (pool notesForGates: #( 0 0 0 0 ) random: (Random seed: 1)) isEmpty.
	self assert: (pool notesForGates: #(  ) random: (Random seed: 1)) isEmpty
]

{ #category : 'tests' }
GenPitchPoolTest >> testRandomNotesFromStaysRandom [
	"The classic selector keeps its contract: any note of the array, uniformly."

	| notes |
	notes := 200 randomNotesFrom: #( 60 61 ).
	self assert: (notes includes: 60).
	self assert: (notes includes: 61)
]

{ #category : 'tests' }
GenPitchPoolTest >> testSameSeedSameNotes [

	| pool |
	pool := GenPitchPool withAll: #( 57 60 62 64 67 69 ).
	self
		assert: (pool generate: 32 random: (Random seed: 9))
		equals: (pool generate: 32 random: (Random seed: 9))
]

{ #category : 'tests' }
GenPitchPoolTest >> testSequencerNotesFollowItsGates [

	| scale seq |
	scale := Scale minor: 60.
	seq := 16 claveSon.
	seq randomMelodyFrom: scale.
	self assert: seq notes size equals: seq numberOfGates.
	self assert: (seq notes allSatisfy: [ :each | scale includes: each ])
]

{ #category : 'tests' }
GenPitchPoolTest >> testStrongBeatsFavourChordTones [
	"Over many loops the downbeat lands on C, E or G far more often than on the other notes."

	| pool hits |
	pool := GenPitchPool withAll: #( 60 62 64 65 67 69 71 ).
	hits := (1 to: 20) count: [ :seed |
		        #( 60 64 67 ) includes: (pool generate: 16 random: (Random seed: seed)) first ].
	self assert: hits >= 15
]

{ #category : 'tests' }
GenPitchPoolTest >> testTheLowestNoteIsTheTonic [

	| chord |
	chord := (GenPitchPool withAll: #( 67 60 64 62 )) tonicChord.
	self assert: chord root equals: 0.
	self assert: chord third equals: 4.
	self assert: chord fifth equals: 7
]

{ #category : 'tests' }
GenPitchPoolTest >> testTrigsOnDownbeatsLandOnChordTones [
	"The clave's first trig is a downbeat: over many tries it lands on C, E or G far more often than elsewhere."

	| scale hits |
	scale := Scale major: 60.
	hits := (1 to: 20) count: [ :each |
		        | seq |
		        seq := 16 claveSon.
		        seq randomMelodyFrom: scale.
		        #( 60 64 67 ) includes: seq notes first ].
	self assert: hits >= 15
]
