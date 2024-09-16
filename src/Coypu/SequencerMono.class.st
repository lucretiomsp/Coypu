"
Monophonic sequencer. 
"
Class {
	#name : 'SequencerMono',
	#superclass : 'Sequencer',
	#type : 'variable',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'arithmetic' }
SequencerMono >> + anInteger [
	"transpose up the sequencer notes by anInteger semitones"

	self notes: self notes + anInteger
]

{ #category : 'arithmetic' }
SequencerMono >> - anInteger [
	"transpose the sequencer notes by anInteger semitones"

	self notes: self notes - anInteger
]

{ #category : 'as yet unclassified' }
SequencerMono >> arpeggiate: aStringOfChords [ 
	
	| arpNotes |
	arpNotes := OrderedCollection new.
	aStringOfChords chordsToArrays do: [ :i | arpNotes addAll: i ].
	self dirtMessage 
		at: 'n' 
		put: arpNotes
]

{ #category : 'as yet unclassified' }
SequencerMono >> arpeggiate: aStringOfChords octave: anIntegerOrAnArray [
	
	| arpNotes |
	arpNotes := OrderedCollection new.
	aStringOfChords chordsToArrays do: [ :i | arpNotes addAll: i ].
	self dirtMessage 
		at: 'n' 
		put: arpNotes + (anIntegerOrAnArray * 12)
]

{ #category : 'converting' }
SequencerMono >> asPolySeq [ 

	| polySeq | 
	polySeq := SequencerPoly new.
	polySeq 
	seqKey: self seqKey;
		gates: self gates; 
		noteIndex: self noteIndex; 
		durations: self durations; 
		dirtMessage: self dirtMessage; 
		seqChords: self seqChords. 
	polySeq dirtMessage removeKey: #n ifAbsent: [ ] .
	polySeq isPoly: true.
	^ polySeq 
]

{ #category : 'LiveCoding' }
SequencerMono >> extra: anArray [

	self kymaMessage
		ifNil: [ self kymaMessage: Dictionary new ].
	self kymaMessage at: (anArray at: 1) put: (anArray at: 2)
]

{ #category : 'LiveCoding - sequencer' }
SequencerMono >> isPolySeq [ 
	^ false
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerMono >> playFullDirtEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| message dur stepDuration|
	stepDuration := Performance uniqueInstance freq.
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := self durations asDirtArray  wrap: anIndex .

	message 
		add: 'delta'; 
		add: (stepDuration * dur) asFloat. "delta should change"
	dirtMessage keysAndValuesDo:  [ :key :value | 
			message 
				add: key; 
				add: (value asDirtArray  wrap: anIndex ) ].



	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : 'LiveCoding-Kyma' }
SequencerMono >> playFullKymaEventAt: anIndex [
	"sends a mesaage to SuperDirt with all the desired OSC arguments and values"

	| dur note stepDuration |
	stepDuration := Performance uniqueInstance freq.
	
	self extraParams keysAndValuesDo: [ :k :v  | (v wrap: anIndex ) toKyma: ( self seqKey , k asString  ) ].
	
	"as in hardware sequencer, default gate time is 80% of duration time"
	dur := (self durations asDirtArray wrap: anIndex) * stepDuration * 0.8.
	note := self notes asDirtArray wrap: anIndex.
	self seqKey toKymaAsGate: dur note: note.

	^ true
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerMono >> playLocalEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| message dur stepDuration|
	stepDuration := Performance uniqueInstance freq.
	message := OrderedCollection new.

	dur := self durations asDirtArray  wrap: anIndex .

	message add: 'delta'; add: stepDuration * dur. "delta should change"
	dirtMessage keysAndValuesDo:  [ :key :value | 
			message 
				add: key; 
				add: (value asDirtArray  wrap: anIndex ) ].



	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerMono >> playMIDIEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| gateTime dur midiNote mch stepDuration midiSender freq |
	freq := Performance uniqueInstance freq.
	gateTime := 0.9. "must be changeable"
	midiSender := PerformerMIDI midiOut.
	mch := self midiChannel.
	stepDuration := Performance uniqueInstance freq.
	midiNote := self notes asDirtArray  wrap: anIndex.
	dur := self durations asDirtArray  wrap: anIndex.
	midiSender playNote:  midiNote   onChannel: mch duration: dur * freq * gateTime.

	^ true 
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerMono >> playPhaustEventAt: anIndex [
	"sends a message to Phausto / the DSP api must be written in a sensible way "

	| dur stepDuration assignedDsp |
	assignedDsp := Performance uniqueInstance activeDSP.
	stepDuration := Performance uniqueInstance freq.

	" please use also duration for gate !!! - future implementation"
	dur := self durations asDirtArray wrap: anIndex.

	self extraParams keysAndValuesDo: [ :k :v |
		assignedDsp
			setValue: (v wrap: anIndex)
			parameter: self seqKey , k asString ].

	assignedDsp
		setValue: (self notes wrap: anIndex) midiNoteToFreq "convert note Number to Frequency"
		parameter: self phaustNoteDestination.
	"as in early sequencers, standard gate time is 80% of duration"
	assignedDsp
		trig: self phaustGateDestination
		for: dur * stepDuration * 0.8.

	^ true
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerMono >> playPhaustEventAt: anIndex perfType: aPerformanceType [
	"sends a message to Phausto / the DSP api must be written in a sensible way "

	| dur stepDuration assignedDsp |
	assignedDsp := Performance uniqueInstance activeDSP.
	stepDuration := Performance uniqueInstance freq.

	" please use also duration for gate !!! - future implementation"
	dur := self durations asDirtArray wrap: anIndex.

	self extraParams keysAndValuesDo: [ :k :v |
		assignedDsp
			setValue: (v wrap: anIndex)
			parameter: self seqKey , k asString ].

	assignedDsp
		setValue: (self notes wrap: anIndex) midiNoteToFreq
		parameter: self phaustNoteDestination. "convert note Number to Frequency"
	"as in early sequencers, standard gate time is 80% of duration"
	assignedDsp
		trig: self phaustGateDestination
		for: dur * stepDuration * 0.8.

	^ true
]

{ #category : 'highlighting' }
SequencerMono >> reverse [
	" reverese gates"
	
	self gates: self gates reverse.
	
]
