"
I carry everything the melody brain knows about the note it is choosing (Parameter Object): the step and its beat strength, the chords heard there, what the lower lanes play there, the notes chosen so far, whether this is the last note of the loop, plus the shared consonance model and random generator.

Random decisions that must be the same for every candidate pitch (does the bass land on the root in this bar?) are flipped once and remembered, see flip:probability:.
"
Class {
	#name : 'GenNoteContext',
	#superclass : 'Object',
	#instVars : [
		'step',
		'beatStrength',
		'chords',
		'barChord',
		'barStart',
		'previousPitches',
		'lastNote',
		'lowerVoices',
		'random',
		'consonance',
		'decisions'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenNoteContext >> barChord [
	"The chord of the bar this step starts in (nil when unknown)."

	^ barChord
]

{ #category : 'accessing' }
GenNoteContext >> barChord: aChord [

	barChord := aChord
]

{ #category : 'accessing' }
GenNoteContext >> barStart: aBoolean [

	barStart := aBoolean
]

{ #category : 'accessing' }
GenNoteContext >> beatStrength [

	^ beatStrength
]

{ #category : 'accessing' }
GenNoteContext >> beatStrength: aNumber [

	beatStrength := aNumber
]

{ #category : 'accessing' }
GenNoteContext >> chords [
	"Every chord this step is heard over (several when lane and progression lengths differ)."

	^ chords
]

{ #category : 'accessing' }
GenNoteContext >> chords: aCollection [

	chords := aCollection asArray
]

{ #category : 'accessing' }
GenNoteContext >> consonance [

	^ consonance ifNil: [ consonance := GenConsonance new ]
]

{ #category : 'accessing' }
GenNoteContext >> consonance: aConsonance [

	consonance := aConsonance
]

{ #category : 'accessing' }
GenNoteContext >> firstPitch [
	"The first note of the lane, nil while choosing it."

	^ previousPitches isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ previousPitches first ]
]

{ #category : 'decisions' }
GenNoteContext >> flip: aKey probability: aProbability [
	"A coin flipped once per note: every candidate pitch sees the same outcome."

	^ decisions at: aKey ifAbsentPut: [ self random next < aProbability ]
]

{ #category : 'initialization' }
GenNoteContext >> initialize [

	super initialize.
	step := 1.
	beatStrength := 1.0.
	chords := #(  ).
	barStart := false.
	previousPitches := #(  ).
	lastNote := false.
	lowerVoices := Dictionary new.
	decisions := Dictionary new
]

{ #category : 'testing' }
GenNoteContext >> isBarStart [

	^ barStart
]

{ #category : 'testing' }
GenNoteContext >> isLastNote [

	^ lastNote
]

{ #category : 'accessing' }
GenNoteContext >> lastNote: aBoolean [

	lastNote := aBoolean
]

{ #category : 'accessing' }
GenNoteContext >> lowerVoice: aRole pitches: aCollection [
	"What the lower lane aRole plays whenever this step sounds."

	lowerVoices at: aRole put: aCollection asArray
]

{ #category : 'accessing' }
GenNoteContext >> lowerVoiceRoles [

	^ lowerVoices keys
]

{ #category : 'accessing' }
GenNoteContext >> pitchesOfLowerVoice: aRole [

	^ lowerVoices at: aRole ifAbsent: [ #(  ) ]
]

{ #category : 'accessing' }
GenNoteContext >> previousInterval [
	"Semitones of the last melodic move, 0 before the second note."

	previousPitches size < 2 ifTrue: [ ^ 0 ].
	^ previousPitches last midi - (previousPitches at: previousPitches size - 1) midi
]

{ #category : 'accessing' }
GenNoteContext >> previousPitch [

	^ previousPitches isEmpty
		  ifTrue: [ nil ]
		  ifFalse: [ previousPitches last ]
]

{ #category : 'accessing' }
GenNoteContext >> previousPitches [

	^ previousPitches
]

{ #category : 'accessing' }
GenNoteContext >> previousPitches: aCollection [
	"The notes chosen so far in this lane, oldest first."

	previousPitches := aCollection asArray
]

{ #category : 'accessing' }
GenNoteContext >> random [

	^ random ifNil: [ random := Random new ]
]

{ #category : 'accessing' }
GenNoteContext >> random: aRandom [

	random := aRandom
]

{ #category : 'accessing' }
GenNoteContext >> step [

	^ step
]

{ #category : 'accessing' }
GenNoteContext >> step: anInteger [

	step := anInteger
]
