"
Monophonic sequencer. 
"
Class {
	#name : #SequencerMono,
	#superclass : #Sequencer,
	#type : #variable,
	#category : #'LiveCoding-Sequencers'
}

{ #category : #'as yet unclassified' }
SequencerMono >> arpeggiate: aStringOfChords [ 
	| arpNotes |
	
	arpNotes := OrderedCollection new.
aStringOfChords chordsToArrays do: [ :i | arpNotes addAll: i ].
self dirtMessage at: 'n' put: arpNotes .
]

{ #category : #'as yet unclassified' }
SequencerMono >> arpeggiate: aStringOfChords octave: anIntegerOrAnArray [
	| arpNotes |
	
	arpNotes := OrderedCollection new.
aStringOfChords chordsToArrays do: [ :i | arpNotes addAll: i ].
self dirtMessage at: 'n' put: arpNotes + (anIntegerOrAnArray * 12) .
]

{ #category : #converting }
SequencerMono >> asPolySeq [ 

| polySeq | 
polySeq := SequencerPoly new.
polySeq gates: self gates; noteIndex: self noteIndex; durations: self durations; dirtMessage: self dirtMessage; seqChords: self seqChords . 
polySeq dirtMessage removeKey: #n ifAbsent: [ ] .
polySeq isPoly: true.
^ polySeq 
]

{ #category : #'LiveCoding - sequencer' }
SequencerMono >> isPolySeq [ 
^ false
]

{ #category : #'LiveCoding  - SuperDirt' }
SequencerMono >> playFullDirtEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
| message dur stepDuration|
stepDuration := Performance uniqueInstance freq.
message := OrderedCollection new.
message add: '/dirt/play'.
dur := self durations asDirtArray  wrap: anIndex .

message add: 'delta'; add: stepDuration * dur. "delta should change"
dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].



	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : #'LiveCoding  - SuperDirt' }
SequencerMono >> playLocalEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
| message dur stepDuration|
stepDuration := Performance uniqueInstance freq.
message := OrderedCollection new.

dur := self durations asDirtArray  wrap: anIndex .

message add: 'delta'; add: stepDuration * dur. "delta should change"
dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].



	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : #'LiveCoding  - SuperDirt' }
SequencerMono >> playMIDIEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
|  gateTime dur midiNote mch stepDuration midiSender freq |
freq := Performance uniqueInstance freq.
gateTime := 0.9. "must be changeable"
midiSender := PerformerMIDI midiOut .
mch := self midiChannel .
stepDuration := Performance uniqueInstance freq.
midiNote := self notes asDirtArray  wrap: anIndex .
dur := self durations asDirtArray  wrap: anIndex .
midiSender playNote:  midiNote   onChannel: mch duration: dur * freq * gateTime  .


	^ true 
]

{ #category : #'LiveCoding  - SuperDirt' }
SequencerMono >> playPhaustEventAt: anIndex [

	"sends a message to Phausto / the DSP api must be written in a sensible way " 
| message dur stepDuration|
stepDuration := Performance uniqueInstance freq.
message := OrderedCollection new.
message add: '/dirt/play'.
dur := self durations asDirtArray  wrap: anIndex .

message add: 'delta'; add: stepDuration * dur. "delta should change"
dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].



	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : #highlighting }
SequencerMono >> reverse [
  " reverese gates"
	self gates: self gates reverse.
	
]
