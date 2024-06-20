"
Polyphonic Sequencer
"
Class {
	#name : 'SequencerPoly',
	#superclass : 'Sequencer',
	#type : 'variable',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'converting' }
SequencerPoly >> asPolySeq [ 
	^ self
]

{ #category : 'LiveCoding - sequencer' }
SequencerPoly >> isPolySeq [ 
	^ true
]

{ #category : 'LiveCoding  - SuperDirt' }
SequencerPoly >> playFullDirtEventAt: anIndex [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| message dur stepDuration notesInChord chordMessages chord|

	stepDuration := Performance uniqueInstance freq.
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := self durations asDirtArray  wrap: anIndex .
	chord := self seqChords asDirtArray wrap: anIndex.
	notesInChord := chord size.
	message add: 'delta'; add: stepDuration * dur. "delta should change"
	dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].


	chordMessages := (1 to: notesInChord) 
		collect: [ :i | OSCMessage for: ((message copyWith: 'n') copyWith: (chord at: i))].

	(OSCBundle for: chordMessages) 
		sendToAddressString: '127.0.0.1' 
		port: 57120.
	
	^ true 
]

{ #category : 'LiveCoding-Kyma' }
SequencerPoly >> playFullKymaEventAt: anIndex [
	"sends a mesaage to SuperDirt with all the desired OSC arguments and values"

	| message dur stepDuration notesInChord chord |
	stepDuration := Performance uniqueInstance freq.
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := (self durations asDirtArray wrap: anIndex) * stepDuration .
	chord := self seqChords asDirtArray wrap: anIndex.
	notesInChord := chord size.
	message
		add: 'delta';
		add: stepDuration * dur. "delta should change"
	dirtMessage keysAndValuesDo: [ :key :value |
		message
			add: key;
			add: (value asDirtArray wrap: anIndex) ].

	"chordMessages := (1 to: notesInChord) collect: [ :i |
		                 OSCMessage for:
			                 ((message copyWith: 'n') copyWith: (chord at: i)) ]."
	
	

	self extraParams keysAndValuesDo: [ :k :v  | (v wrap: anIndex ) toKyma: ( self seqKey , k asString  ) ].
	"send the notes"
	1 to: notesInChord do: [ :i | notesInChord traceCr.
		(chord at: i) toKyma: self seqKey , 'Note' , i asString.
		].
	"send the gates"
self seqKey , 'Gate' toKymaAsTrigWithDuration: dur.
	^ true
]
