Extension { #name : #Integer }

{ #category : #'*LiveCoding' }
Integer >> bpm [
"return the duration of 1/16th at self bpm"
^ ((60/  self) /4).
]

{ #category : #'*LiveCoding' }
Integer >> copiesOf: anInteger [
" retuns an array of self size with all  anInteger"
^ Array new: self withAll: anInteger.
]

{ #category : #'*LiveCoding' }
Integer >> copiesOfEach: anArray [
" retuns an array of self repetitions of each element of anArray"
| result  resultSize|
result := Array new: ((anArray size) * self).
resultSize := result  size.
( 0 to: (resultSize -1)) do: 
[ :i | result at: (i + 1) put: (anArray  at:  (i // (resultSize /anArray size)) + 1)].

^ result
]

{ #category : #'*LiveCoding' }
Integer >> major [ 
"returns an aray with the major third, fith seventh and ninth relative to the note number that is the receiver"
 ^ #(4 7 10 14) collect: [ :i | i + self ].
]

{ #category : #'*LiveCoding' }
Integer >> melodyFrom: aScale [

	| array |
	array := self randomNotesFrom: aScale.
	array at: 1 put: (aScale at: 1).
	2 to: array size do: [ :i | 
		((array at: i) rem: 12)= 0 ifTrue: [ array at: i - 1 put: (aScale at: 6) ].
		((array at: i) rem: 12)= 2 ifTrue: [ array at: i - 1 put: (aScale at: 5) ] ].
	"last note is mediante or dominante"
	^ array
]

{ #category : #'*LiveCoding' }
Integer >> minor [
"returns an aray with the major third, fith seventh and ninth relative to the note number that is the receiver"
 ^ #(3 7 10 14) collect: [ :i | i + self ].
]

{ #category : #'*LiveCoding' }
Integer >> modulo: anInteger [

	"convenience method to index arrays after incrementing"

	^ self - 1 % anInteger  + 1
]

{ #category : #'*LiveCoding' }
Integer >> ones [
	
	" retuns a Sequencer of gates size = self with all ones - same as semiquavers"
^ (Array new: self withAll: 1) asRhythm asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> sequenceFor: aDictionaryOfPatterns rate: aRateInSeconds [
"test"
" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"
"return the current process, it can be suspended!"
| step noteIndex bpm beatInSeconds|
bpm := 60 / (aRateInSeconds * 4).
beatInSeconds := aRateInSeconds * 4.
step := 0.
noteIndex := 0. "or 0???????"

^
[ 	
	bpm toKyma: 'BPM'.
	self timesRepeat: [ (Delay forSeconds: aRateInSeconds   )wait.
		" test if dictionary values is an Array of two arrays or as defined, a sequence"
		 
		aDictionaryOfPatterns keysAndValuesDo: [ :key : value |
		(value isSequencer) ifTrue: [  	
		(((value gates) at: (step modulo: (value gatesSize ))) = 1)
		ifTrue:
		[0.0 toKyma: ((key asString),'Gate'). 1 toKyma: ((key asString),'Gate'). 
		((value notes) at: ((value noteIndex) modulo: (value notesSize))) toKyma: ((key asString),'Note').
		
		((value durations) isArray) ifTrue:
		[((value durations ) at: (noteIndex modulo: (value durationsSize))) toKyma: ((key asString),'Duration')] ifFalse: [nil].

     "new experimental for extra control"
     ((value extra1) isArray) ifTrue:
		[ ((value extra1 at: 2 ) at: (value noteIndex modulo: (value extra1Size))) toKyma: ((key asString),(value extra1 at: 1))] ifFalse: [nil].
		
		"new experimental for second extra control"
     ((value extra2) isArray) ifTrue:
		[ ((value extra2 at: 2 ) at: (value noteIndex modulo: (value extra2Size))) toKyma: ((key asString),(value extra2 at: 1))] ifFalse: [nil].
		
		
		value at: 4 put: ((value noteIndex) + 1).
		"noteIndex := noteIndex + 1."
		] 
		ifFalse: [nil]]
		ifFalse: [(value at: (step modulo: (value size))) toKyma: (key asString) ] 
		].
	
		"step is incrementing in any case"
		step := step + 1.
		
	]
	
	] forkAt: (Processor timingPriority )


]

{ #category : #'*LiveCoding' }
Integer >> toSCAsGate [

	" send an OSC message to superCollider that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"

	| localAddress |
	localAddress := '127.0.0.1'.


	(OSCMessage for: { 
			 15.
			 self.
			 'gate'.
			 1 }) sendToAddressString: '127.0.0.1' port: 57110.
	(Delay forSeconds: 1) wait.
	
"note-Off"
	(OSCMessage for: { 
			 15.
			 self.
			 'gate'.
			 0 }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #'*LiveCoding' }
Integer >> toSCAsGate: aDurationInSeconds note: aNoteNumber [

	"send a note-on MIDI-like message to supercollider via OSC"

[  	(OSCMessage for: { 
			 15.
			 self.
			 'note'.
			 aNoteNumber }) sendToAddressString: '127.0.0.1' port: 57110.
	(OSCMessage for: { 
			 15.
			 self.
			 'gate'.
			 1 }) sendToAddressString: '127.0.0.1' port: 57110.

	(Delay forSeconds: aDurationInSeconds) wait.

	"note-Off"
	(OSCMessage for: { 
			 15.
			 self.
			 'gate'.
			 0 }) sendToAddressString: '127.0.0.1' port: 57110.
			] fork
]

{ #category : #'*LiveCoding' }
Integer >> zeros [
	" retuns a Sequencer of gates size = self with all zeros / to create long rests "
^ (Array new: self withAll: 0) asRhythm asSeq.
]
