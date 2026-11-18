"
I am a generated lane: a voice, its rhythm and its notes, one per onset. Steps are 1-based and wrap around, so I can be asked what sounds at any global step.

To use me in a sequencer: midiNotes (one MIDI number per onset), gates (1 or 0 per step) or stepArray (one MIDI number or nil per step).
"
Class {
	#name : 'GenLane',
	#superclass : 'Object',
	#instVars : [
		'voice',
		'rhythm',
		'events'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenLane class >> voice: aVoice rhythm: aRhythm events: aCollection [

	^ self new
		  setVoice: aVoice rhythm: aRhythm events: aCollection asArray;
		  yourself
]

{ #category : 'converting' }
GenLane >> asSequencer [
	"A Coypu SequencerMono playing this lane: my gates, then per onset one note, one duration in steps and one gate time.
	(GenComposer new compose lane: #lead) asSequencer to: #superpiano"

	| seq |
	seq := self gates asSeq.
	events isEmpty ifTrue: [ ^ seq ].
	seq notes: self midiNotes.
	seq durations: self durations.
	seq gateTimes: (events collect: [ :each | each gate ]).
	^ seq
]

{ #category : 'accessing' }
GenLane >> durations [

	^ events collect: [ :each | each duration ]
]

{ #category : 'accessing' }
GenLane >> eventAtStep: aStep [
	"The note starting at aStep of the loop, or nil."

	| position |
	position := aStep - 1 \\ self length + 1.
	^ events detect: [ :each | each step = position ] ifNone: [ nil ]
]

{ #category : 'accessing' }
GenLane >> events [

	^ events
]

{ #category : 'accessing' }
GenLane >> gates [
	"1 on every step that starts a note, 0 elsewhere."

	^ rhythm steps collect: [ :each |
		  each
			  ifTrue: [ 1 ]
			  ifFalse: [ 0 ] ]
]

{ #category : 'accessing' }
GenLane >> length [
	"Steps in the loop."

	^ rhythm size
]

{ #category : 'accessing' }
GenLane >> midiNotes [
	"One MIDI number per onset."

	^ events collect: [ :each | each midi ]
]

{ #category : 'accessing' }
GenLane >> names [

	^ events collect: [ :each | each name ]
]

{ #category : 'accessing' }
GenLane >> pitchSoundingAt: aStep [
	"The pitch of the latest onset at or before aStep, wrapping around the loop; nil for an empty lane."

	| position |
	events isEmpty ifTrue: [ ^ nil ].
	position := aStep - 1 \\ self length + 1.
	^ (events reversed detect: [ :each | each step <= position ] ifNone: [ events last ]) pitch
]

{ #category : 'accessing' }
GenLane >> pitches [

	^ events collect: [ :each | each pitch ]
]

{ #category : 'printing' }
GenLane >> printOn: aStream [

	aStream
		nextPutAll: self role;
		nextPutAll: ': '.
	self names do: [ :each | aStream nextPutAll: each ] separatedBy: [ aStream space ]
]

{ #category : 'accessing' }
GenLane >> rhythm [

	^ rhythm
]

{ #category : 'accessing' }
GenLane >> role [

	^ voice role
]

{ #category : 'initialization' }
GenLane >> setVoice: aVoice rhythm: aRhythm events: anArray [

	voice := aVoice.
	rhythm := aRhythm.
	events := anArray
]

{ #category : 'accessing' }
GenLane >> stepArray [
	"One slot per step: the MIDI number of the note starting there, or nil."

	^ (1 to: self length) collect: [ :each |
		  (self eventAtStep: each) ifNotNil: [ :event | event midi ] ]
]

{ #category : 'accessing' }
GenLane >> voice [

	^ voice
]
