"
Tests for GenMelodyGenerator, the melody brain of a lane. The harmony is two bars of C major: I then IV.
"
Class {
	#name : 'GenMelodyGeneratorTest',
	#superclass : 'TestCase',
	#instVars : [
		'context',
		'meter',
		'progression'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenMelodyGeneratorTest >> generatorFor: aVoice seed: anInteger [

	^ GenMelodyGenerator new
		  voice: aVoice;
		  candidates: (context pitchesFrom: aVoice lowestMidi to: aVoice highestMidi);
		  progression: progression;
		  meter: meter;
		  random: (Random seed: anInteger);
		  yourself
]

{ #category : 'private' }
GenMelodyGeneratorTest >> quarterNotes [

	^ GenRhythm pattern: 'x...x...x...x...x...x...x...x...'
]

{ #category : 'running' }
GenMelodyGeneratorTest >> setUp [

	super setUp.
	context := GenScaleContext scaleNamed: #major root: 0.
	meter := GenMeter stepsPerBar: 16.
	progression := GenProgression withAll: {
			               (context chordOnDegree: 1).
			               (context chordOnDegree: 4) }
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testAStepHearsEveryChordOfItsCycle [

	| generator |
	generator := self generatorFor: GenVoice lead seed: 1.
	self assert: (generator chordsAt: (generator repeatsOf: 1 laneLength: 16 cycle: 32)) size equals: 2.
	self assert: (generator chordsAt: (generator repeatsOf: 1 laneLength: 32 cycle: 32)) size equals: 1.
	self assert: (generator repeatsOf: 3 laneLength: 13 cycle: 32) size equals: 32
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testAVoiceWithoutPitchesIsAnError [

	| generator |
	generator := (self generatorFor: GenVoice lead seed: 1)
		             candidates: #(  );
		             yourself.
	self should: [ generator laneFor: (GenRhythm pattern: 'x...') ] raise: Error
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testLowerLanesAreHeard [

	| bass note |
	bass := (self generatorFor: GenVoice bass seed: 4) laneFor: self quarterNotes.
	note := (self generatorFor: GenVoice lead seed: 4)
		        lowerLanes: { bass };
		        contextForStep: 3 laneLength: 32 previous: #(  ) last: false.
	self assert: (note pitchesOfLowerVoice: #bass) equals: { (bass pitchSoundingAt: 3) }
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testNoteWeightsScoreEveryCandidate [

	| generator weights |
	generator := self generatorFor: GenVoice lead seed: 5.
	weights := generator noteWeightsIn: (generator contextForStep: 1 laneLength: 32 previous: #(  ) last: false).
	self assert: weights size equals: generator candidates size.
	self assert: (weights allSatisfy: [ :each | each >= 0 ]).
	self assert: (weights anySatisfy: [ :each | each > 0 ])
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testOnePitchPerOnset [

	| rhythm lane |
	rhythm := GenRhythm pattern: 'x..x..x.x...x...x..x..x.x...x...'.
	lane := (self generatorFor: GenVoice lead seed: 1) laneFor: rhythm.
	self assert: lane events size equals: rhythm onsetCount.
	self assert: (lane events collect: [ :each | each step ]) equals: rhythm onsets
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testPitchesComeFromTheScaleAndTheRange [

	| voice lane |
	voice := GenVoice lead.
	lane := (self generatorFor: voice seed: 2) laneFor: (GenRhythm pattern: (String new: 32 withAll: $x)).
	lane pitches do: [ :each |
		self assert: (each midi between: voice lowestMidi and: voice highestMidi).
		self assert: (#( 0 2 4 5 7 9 11 ) includes: each midi \\ 12) ]
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testSameSeedSameMelody [

	| rhythm first second |
	rhythm := GenRhythm pattern: 'x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.x.'.
	first := (self generatorFor: GenVoice mid seed: 7) laneFor: rhythm.
	second := (self generatorFor: GenVoice mid seed: 7) laneFor: rhythm.
	self assert: first midiNotes equals: second midiNotes.
	self assert: first durations equals: second durations
]

{ #category : 'tests' }
GenMelodyGeneratorTest >> testTheBassLandsOnTheRootWhenAsked [

	| voice lane |
	voice := GenVoice
		         role: #bass
		         center: 40
		         range: 12
		         maxHold: 4
		         scorer: (GenCompositeFactor withAll: {
					          (GenRootLandingFactor new
						           probability: 1;
						           missWeight: 0;
						           yourself).
					          (GenRegisterFactor center: 40 width: 6) }).
	lane := (self generatorFor: voice seed: 3) laneFor: self quarterNotes.
	self assert: (lane eventAtStep: 1) midi \\ 12 equals: 0.
	self assert: (lane eventAtStep: 17) midi \\ 12 equals: 5
]
