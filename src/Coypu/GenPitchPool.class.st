"
I turn a plain collection of notes into a melody (the engine behind melodyFrom: on Integer and Sequencer).

The lowest note is taken as the tonic; the pool notes that sound most like a third and a fifth above it make the tonic chord. Then the melody rules apply: chord tones on strong beats, steps rather than leaps, leap recovery, no dull repeats and a loop that closes. Only notes of the pool are used, in their own octaves. Bars are 16 steps, as everywhere in Coypu.

	(GenPitchPool withAll: (Scale minor: 60)) generate: 16 random: Random new.
	(GenPitchPool withAll: (Scale minor: 60)) notesForGates: 16 claveSon gates random: Random new.
"
Class {
	#name : 'GenPitchPool',
	#superclass : 'Object',
	#instVars : [
		'midiNotes',
		'consonance'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenPitchPool class >> withAll: aCollection [

	^ self new
		  setMidiNotes: aCollection;
		  yourself
]

{ #category : 'accessing' }
GenPitchPool >> candidates [
	"Pool notes as pitches; the step is the rank in the pool, so neighbours are steps."

	^ midiNotes withIndexCollect: [ :each :index | GenPitch midi: each step: index ]
]

{ #category : 'generating' }
GenPitchPool >> generate: aCount random: aRandom [
	"aCount notes from the pool, one per step."

	aCount < 1 ifTrue: [ ^ #(  ) ].
	^ self
		  notesFor: (GenRhythm named: #everyStep steps: (Array new: aCount withAll: true))
		  random: aRandom
]

{ #category : 'accessing' }
GenPitchPool >> midiNotes [

	^ midiNotes
]

{ #category : 'generating' }
GenPitchPool >> notesFor: aRhythm random: aRandom [
	"One note per onset of aRhythm."

	| generator |
	aRhythm onsetCount = 0 ifTrue: [ ^ #(  ) ].
	generator := GenMelodyGenerator new
		             voice: self voice;
		             candidates: self candidates;
		             progression: (GenProgression withAll: { self tonicChord });
		             meter: (GenMeter stepsPerBar: (aRhythm size min: 16));
		             random: aRandom;
		             consonance: consonance;
		             yourself.
	^ (generator laneFor: aRhythm) midiNotes
]

{ #category : 'generating' }
GenPitchPool >> notesForGates: someGates random: aRandom [
	"One note per gate that fires (a Coypu gates array of 0s and 1s), each chosen for where it falls in the bar."

	^ self
		  notesFor: (GenRhythm named: #gates steps: (someGates asArray collect: [ :each | each > 0 ]))
		  random: aRandom
]

{ #category : 'accessing' }
GenPitchPool >> pitchClasses [

	^ (midiNotes collect: [ :each | each \\ 12 ]) asSet asSortedCollection asArray
]

{ #category : 'initialization' }
GenPitchPool >> setMidiNotes: aCollection [

	aCollection isEmpty ifTrue: [ ^ self error: 'A pitch pool needs at least one note' ].
	midiNotes := aCollection asSet asSortedCollection asArray.
	consonance := GenConsonance new
]

{ #category : 'harmony' }
GenPitchPool >> tonicChord [

	| root intervals third fifth |
	root := midiNotes first \\ 12.
	intervals := (self pitchClasses collect: [ :each | each - root \\ 12 ]) copyWithout: 0.
	intervals isEmpty ifTrue: [
		^ GenChord degree: 1 root: root third: 0 fifth: 0 strength: 1 ].
	third := intervals detectMax: [ :each | consonance thirdLikenessOf: each ].
	fifth := intervals size = 1
		         ifTrue: [ third ]
		         ifFalse: [
			         (intervals copyWithout: third) detectMax: [ :each |
				         consonance fifthLikenessOf: each ] ].
	^ GenChord degree: 1 root: root third: third fifth: fifth strength: 1
]

{ #category : 'accessing' }
GenPitchPool >> voice [
	"A melodic voice spread over the whole pool, with the melody rules but no bass rules and no other lanes."

	| low high center |
	low := midiNotes first.
	high := midiNotes last.
	center := low + high / 2.0.
	^ GenVoice
		  role: #melody
		  center: center
		  range: high - low / 2
		  maxHold: 1
		  scorer: (GenCompositeFactor withAll: {
					   GenChordConsonanceFactor new.
					   GenMelodicMotionFactor new.
					   (GenRegisterFactor center: center width: (high - low / 2 max: 3)).
					   GenLoopClosureFactor new })
]
