"
Monophonic sequencer. 
"
Class {
	#name : #SequencerMono,
	#superclass : #Sequencer,
	#type : #variable,
	#category : #'LiveCoding-Sequencers'
}

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

	"| index sound message  delta|
	index := 'n' -> (self samplesIndex wrap: anIndex) asFloat.
	sound := 'sound' -> (self soundPattern wrap: anIndex).
	delta := 'delta' -> 0.125. change it to have changing delta values
   message := OrderedCollection new.
message addAll: { '_id' . '1' . 'cps' . 0.56 . 'delta' . 0.125 . 'orbit' . 0 . 's' . sound . 'n' . index}. "

	(OSCBundle for: {  OSCMessage for: message  }  )  sendToAddressString: '127.0.0.1' port: 57120.
	^ true 
]

{ #category : #highlighting }
SequencerMono >> reverse [
  " reverese gates"
	self gates: self gates reverse.
	
]
