Extension { #name : #Integer }

{ #category : #'*LiveCoding' }
Integer >> adowa [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> aksak [
" create an array of self size of Balcan pseudo aksak rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 1 0 0 0 1 0 0 0).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm)  asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> banda [
" create an array of self size of Banda (Haiti/Vodoo) rhytm pulses. Better if used with self = 8 x anInteger . it is the same rhythm played in the moribayasa rhythm among the Malinke people of Guinea and in Cuba it is called cinquillo"
| pattern |
pattern := #(1 0 1 1 0 1 1 0).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm ) asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> bars [
"convert bars into steps. 16 steps per bar"
^ (self * 16).
]

{ #category : #'*LiveCoding' }
Integer >> bomba [
" create an array of self size of  puertorican Bomba rhytm pulses. Better if the receiever is a multiple of eight."
| pattern |
pattern := #(1 0 0 1 1 1 1 0 ).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm ) asSeq .

]

{ #category : #'*LiveCoding' }
Integer >> bossa [
" create an array of self size of  bossanova rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 ).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq .

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> bpm [
"return the duration of 1/16th at self bpm"
^ ((60/  self) /4).
]

{ #category : #'*LiveCoding' }
Integer >> breves [

	" returns self number of brevesin the first position of the bars"

	| result |
	result := '80000000' pattern times: self.
	result durations: #(32).
	^ result
]

{ #category : #'*LiveCoding' }
Integer >> claveSon [
" create an array of self size of  Cuban clave Son rhytm pulses. Better if the receiever is a multiple of 16."
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 1 0 0 0).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq.

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
Integer >> downbeats [

	"create a sequence of self downbeats"

	
	^ ((1 to: self) collect: [ :i | ((i rem: 4) = 1) asBit ]) asRhythm
		  asSeq
]

{ #category : #'*LiveCoding' }
Integer >> gahu [
" create an array of self size of gahu (from Ewe people) rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 0 0 1 0 ).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq .

"implement shifting to the left"
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
Integer >> microsecondsAsSecondsAndNanos [

self shouldNotImplement 
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
	" retuns an array of self size with all  ones "
^ (Array new: self withAll: 1) asRhythm.
]

{ #category : #'*LiveCoding' }
Integer >> pattern [ 
	| arrayOfCharacters s result|
	arrayOfCharacters := (self printStringBase: 2) asDirtArray.
	s := arrayOfCharacters size.
	result := (1 to: s) collect: [ :i | (arrayOfCharacters at: i) digitValue ].
	^ result asSeq. 
	
]

{ #category : #'*LiveCoding' }
Integer >> quavers [
"creates an Array of aNumber of values (0,1) with 1 to the position corresponding to a rhtyhm of quavers (downbeat + upbeat)"
	^ (((1 to: self) collect: [ :i | ((((i rem: 4) = 1)) | (((i rem: 4) = 3)) ) asBit ]) asRhythm ) asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> randomInside: anArray [

	"return an array of self size choosing from the values inside anArray"

	| result |
	result := (1 to: self) collect: [ :i | 
		          anArray at:
			          (Random new nextIntegerBetween: 1 and: anArray size) ].

	^ result
]

{ #category : #'*LiveCoding' }
Integer >> randomIntegers: aMaximum [

| result |
result := Array new: self.

1 to: self do: [ :i | result at: i put: (Random new next *  aMaximum) rounded ].
^ result .
]

{ #category : #'*LiveCoding' }
Integer >> randomNotesFrom: anArray root: aRootNote octaves: aNumber [

	"return an array of self size of a random note from anArray of note numbers with root aRootNote, and aNumber octave range"

	| intervals melody |
	intervals := (1 to: self) collect: [ :i | 
		             (anArray at: (Random new nextInteger: anArray size))
		             + ((Random new nextInteger: aNumber + 1) - 1 * 12) ].
	melody := intervals + aRootNote.
	^ melody
]

{ #category : #'*LiveCoding' }
Integer >> randomSequencer [

	"return a Sequencer with self random trigs and random notes  "

	| triggers randNotes |
	triggers := self randomTrigs.
	randNotes := triggers trigs randomFrom: #( 24 88 ).
	^ triggers notes: randNotes
]

{ #category : #'*LiveCoding' }
Integer >> randomSequencerIn: anArray [

	"return a Sequencer with self random trigs and random notes in the array "

	| triggers randNotes |
	triggers := self randomTrigs.
	randNotes := triggers trigs randomInside: anArray.
	^ triggers notes: randNotes
]

{ #category : #'*LiveCoding' }
Integer >> randomSequencerIn: anArray withProbability: anInteger [

	"return a Sequencer with self random trigs withProbability and random notes in the array "

	| triggers randNotes |
	triggers := self randomTrigsWithProbability: anInteger.
	randNotes := triggers trigs randomInside: anArray.
	^ triggers notes: randNotes
]

{ #category : #'*LiveCoding' }
Integer >> randomTrigs [

| result |
result := Array new: self.

1 to: self do: [ :i | result at: i put: Random new next rounded ].
^ result asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> randomTrigsWithProbability: anInteger [


| result |
result := Array new: self.

1 to: self do: [ :i | result at: i put: ((Random new nextIntegerBetween: 0 and: 100) < anInteger ) asInteger ].
^ result asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> rumba [
" create an array of self size of Cuban rumba rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 0 1 0 0 1 0 1 0 0 0 ).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm ) asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> semibreves [

	" returns self number of semibrevesin the first position of the bars"

	| result |
	result := '8000' pattern times: self.
	result durations: #(16).
	^ result
]

{ #category : #'*LiveCoding' }
Integer >> semiquavers [ 

^ ((Array new: self withAll: 1) asRhythm ) asSeq .
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
Integer >> shiko [
" create an array of self size of shiko (West-African / Caribbean) rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 0 1 0 1 0 0 0 1 0 1 0 0 0).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> sikyi [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm ) asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> soukous [
" create an array of self size of Central Africa soukous rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 ).

^ (((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm) asSeq .

"implement shifting to the left"
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
Integer >> tresillo [
" create an array of self size of  tresillo rhytm pulses. Better if used with self = 8 x anInteger "
| pattern newArray rhythm |

pattern := #(1 0 0 1 0 0 1 0 ).

newArray := (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].
rhythm := Rhythm new: (newArray size).
(1 to: (rhythm size)) do: [ :i | rhythm at: i put: (newArray  at: i) ].
^ rhythm asSeq.

"
| pattern |
pattern := #(1 0 0 1 0 0 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].
"
"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> tresillo: aNoteNumberOrAnArrayOfNN [

	" create an array of self size of  tresillo rhytm pulses. Better if used with self = 8 x anInteger "

	| pattern newArray rhythm notes |
	notes := Array with: aNoteNumberOrAnArrayOfNN.
	pattern := #( 1 0 0 1 0 0 1 0 ).

	newArray := (0 to: self - 1) collect: [ :i | 
		            pattern at: (i rem: pattern size) + 1 ].
	rhythm := Rhythm new: newArray size.
	(1 to: rhythm size) do: [ :i | rhythm at: i put: (newArray at: i) ].
	^ Sequencer new gates: rhythm; notes: notes

	"
| pattern |
pattern := #(1 0 0 1 0 0 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].
"
	"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> trueAksak [
" create an array of self size of Balcan aksak rhytm pulses. Better if used with self = 13 x anInteger "
| pattern |
pattern := #(1 0 1 0 1 0 1 0 0 1 0 1 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm .

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> tumbao [
" create an array of self size of  habanera/tumbao rhytm pulses. Better if the receiever is a multiple of eight."
| pattern rhythm |
pattern := #(1 0 0 1 1 0 1 0 ).

rhythm := ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm .
^ rhythm asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> upbeats [
"creates an Array of size=self  of values (0,1) with 1 to the position corresponding to a 4/4 upbeat rhythm"
	^ (((1 to: self) collect: [ :i | (((i rem: 4) = 3)) asBit ]) asRhythm ) asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> zeros [
	" retuns an array of self size with all zeros"
^ ((Array new: self withAll: 0) asRhythm) asSeq .
]
