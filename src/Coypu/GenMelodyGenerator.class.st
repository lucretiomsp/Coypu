"
I am the melody brain of one lane.

For every onset, in order, I build a GenNoteContext, score every candidate pitch with the voice's rules (noteWeightsIn:), sharpen the scores and draw one pitch. Then the duration policy gives each note its length (laneFor: is a Template Method).

Lanes of different lengths are handled while building the context: a step is heard at every repeat of the lane within the cycle it shares with the harmony (and with each lower lane), so it gets all the chords and lower notes it will meet.
"
Class {
	#name : 'GenMelodyGenerator',
	#superclass : 'Object',
	#instVars : [
		'voice',
		'candidates',
		'progression',
		'meter',
		'lowerLanes',
		'random',
		'sharpness',
		'consonance',
		'durationPolicy'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenMelodyGenerator >> candidates [

	^ candidates
]

{ #category : 'accessing' }
GenMelodyGenerator >> candidates: aCollectionOfPitches [

	candidates := aCollectionOfPitches asArray
]

{ #category : 'context' }
GenMelodyGenerator >> chordsAt: someSteps [
	"The distinct chords heard at these global steps."

	| chords |
	chords := OrderedCollection new.
	someSteps do: [ :each | chords addIfNotPresent: (progression chordAtStep: each meter: meter) ].
	^ chords asArray
]

{ #category : 'accessing' }
GenMelodyGenerator >> consonance: aConsonance [

	consonance := aConsonance
]

{ #category : 'context' }
GenMelodyGenerator >> contextForStep: aStep laneLength: aLength previous: somePitches last: aBoolean [

	| repeats context |
	repeats := self repeatsOf: aStep laneLength: aLength cycle: (progression lengthInSteps: meter).
	context := GenNoteContext new
		           step: aStep;
		           beatStrength: (meter strengthAt: aStep);
		           barStart: (meter isDownbeat: aStep);
		           barChord: (progression chordAtStep: aStep meter: meter);
		           chords: (self chordsAt: repeats);
		           previousPitches: somePitches;
		           lastNote: aBoolean;
		           random: random;
		           consonance: consonance;
		           yourself.
	lowerLanes do: [ :each |
		context lowerVoice: each role pitches: (self pitchesOf: each heardAt: aStep laneLength: aLength) ].
	^ context
]

{ #category : 'accessing' }
GenMelodyGenerator >> durationPolicy: aDurationPolicy [

	durationPolicy := aDurationPolicy
]

{ #category : 'initialization' }
GenMelodyGenerator >> initialize [

	super initialize.
	lowerLanes := #(  ).
	sharpness := 2.
	random := Random new.
	consonance := GenConsonance new.
	durationPolicy := GenDurationPolicy new
]

{ #category : 'generating' }
GenMelodyGenerator >> laneFor: aRhythm [
	"Pitches first, one per onset, then durations, then the lane."

	| pitches durations events |
	pitches := self pitchesFor: aRhythm.
	durations := durationPolicy durationsFor: aRhythm voice: voice meter: meter random: random.
	events := aRhythm onsets withIndexCollect: [ :onset :index |
		          GenNoteEvent
			          step: onset
			          pitch: (pitches at: index)
			          duration: (durations at: index)
			          gate: durationPolicy gate ].
	^ GenLane voice: voice rhythm: aRhythm events: events
]

{ #category : 'accessing' }
GenMelodyGenerator >> lowerLanes: aCollectionOfLanes [
	"Lanes already generated, which this one is scored against."

	lowerLanes := aCollectionOfLanes asArray
]

{ #category : 'accessing' }
GenMelodyGenerator >> meter: aMeter [

	meter := aMeter
]

{ #category : 'scoring' }
GenMelodyGenerator >> noteWeightsIn: aContext [
	"Every candidate scored by the product of the voice's factors."

	^ candidates collect: [ :each | voice weightOf: each in: aContext ]
]

{ #category : 'generating' }
GenMelodyGenerator >> pitchesFor: aRhythm [

	| onsets chooser chosen |
	candidates isEmpty ifTrue: [ ^ self error: 'No scale pitch in the range of the voice' ].
	onsets := aRhythm onsets.
	chooser := GenWeightedChooser random: random sharpness: sharpness.
	chosen := OrderedCollection new.
	onsets withIndexDo: [ :onset :index |
		| context |
		context := self
			           contextForStep: onset
			           laneLength: aRhythm size
			           previous: chosen
			           last: (index = onsets size and: [ index > 1 ]).
		chosen add: (chooser choose: candidates weights: (self noteWeightsIn: context)) ].
	^ chosen asArray
]

{ #category : 'context' }
GenMelodyGenerator >> pitchesOf: aLane heardAt: aStep laneLength: aLength [
	"What a lower lane plays whenever this step sounds."

	| pitches |
	pitches := OrderedCollection new.
	(self repeatsOf: aStep laneLength: aLength cycle: aLane length) do: [ :each |
		(aLane pitchSoundingAt: each) ifNotNil: [ :pitch | pitches addIfNotPresent: pitch ] ].
	^ pitches asArray
]

{ #category : 'accessing' }
GenMelodyGenerator >> progression: aProgression [

	progression := aProgression
]

{ #category : 'accessing' }
GenMelodyGenerator >> random: aRandom [

	random := aRandom
]

{ #category : 'context' }
GenMelodyGenerator >> repeatsOf: aStep laneLength: aLength cycle: aCycleLength [
	"Every global step where this lane step sounds, over the cycle it shares with something aCycleLength steps long."

	^ (0 to: (aLength lcm: aCycleLength) // aLength - 1) collect: [ :each | aStep + (each * aLength) ]
]

{ #category : 'accessing' }
GenMelodyGenerator >> sharpness: aNumber [
	"Power the scores are raised to before the draw."

	sharpness := aNumber
]

{ #category : 'accessing' }
GenMelodyGenerator >> voice: aVoice [

	voice := aVoice
]
