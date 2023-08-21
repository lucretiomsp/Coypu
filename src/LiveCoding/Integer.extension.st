Extension { #name : #Integer }

{ #category : #'*LiveCoding' }
Integer >> adowa [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> aksak [
" create an array of self size of Balcan pseudo aksak rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 1 0 0 0 1 0 0 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> banda [
" create an array of self size of Banda (Haiti/Vodoo) rhytm pulses. Better if used with self = 8 x anInteger . it is the same rhythm played in the moribayasa rhythm among the Malinke people of Guinea and in Cuba it is called cinquillo"
| pattern |
pattern := #(1 0 1 1 0 1 1 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> bomba [
" create an array of self size of  puertorican Bomba rhytm pulses. Better if the receiever is a multiple of eight."
| pattern |
pattern := #(1 0 0 1 1 1 1 0 ).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> bossa [
" create an array of self size of  bossanova rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 ).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq .

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
result := (('80000000' pattern ) times: self).
result durations: 32.
^ result
]

{ #category : #'*LiveCoding' }
Integer >> claveSon [
" create an array of self size of  Cuban clave Son rhytm pulses. Better if the receiever is a multiple of 16."
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 1 0 0 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

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
Integer >> debugSequenceFor: aDictionaryOfPatterns rate: aRateInSeconds [
" DEBUG THE PROCESS THAT iterates over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"
| step noteIndex bpm beatInSeconds|
bpm := 60 / (aRateInSeconds * 4).
beatInSeconds := aRateInSeconds * 4.
step := 0.
noteIndex := 0. 
"note index is inside the sequencer"


[ 	
	bpm toLocal: 'BPM'.
	self timesRepeat: [ (Delay forSeconds: aRateInSeconds   ) wait.
		" test if dictionary values is an Array od two arrays or as defined, a sequence"
		 
		aDictionaryOfPatterns keysAndValuesDo: [ :key : value |
		(value isSequencer) ifTrue: [  	
		"first of all, the noteIndex is equal to the 4th value of the Dictionary/Performance"
		
		Transcript show: 'Step is '; tab; show: step; cr.
		
		
		(((value gates) at: (step modulo: (value gatesSize ))) = 1)
		ifTrue:
		[ 
			"first of all check the noteIndex"
			Transcript show: ((key asString),'Gate'); space; show: 'Note Index is '; tab; show: (value noteIndex); cr.
			
		
			Transcript show: 0; tab; show: ((key asString),'Gate'); tab; show: 1; tab; show: (' / '); tab; 
			show: ((value notes) at: ((value noteIndex) modulo: (value notesSize))); tab; tab;
			show: ((key asString),'Note'); 
			tab; show: ' / '.		
		
		((value durations) isArray) ifTrue:
		[ Transcript  show: ((value durations ) at: (( value noteIndex) modulo: (value durationsSize))); show: ((key asString),'Duration'); tab; 		cr. ] ifFalse: [Transcript cr].
		
		value at: 4 put: ((value noteIndex) + 1).
		"noteIndex := noteIndex + 1."
		] 
		ifFalse: [nil]]
		ifFalse: [(value at: (step modulo: (value size))) toLocal: (key asString) ] 
		].
	
		"step is incrementing in any case"
		step := step + 1.
		
	]
	
	] forkAt: (Processor timingPriority )
]

{ #category : #'*LiveCoding' }
Integer >> downbeats [ 

 ^ ((1 to: self) collect: [ :i | (((i rem: 4) = 1)) asBit ]) asRhythm asSeq. 
]

{ #category : #'*LiveCoding' }
Integer >> gahu [
" create an array of self size of gahu (from Ewe people) rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 0 0 1 0 ).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
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
Integer >> pattern [ 
	| arrayOfCharacters s|
	arrayOfCharacters := (self printStringBase: 2) asArray.
	s := arrayOfCharacters size.
	^ (1 to: s) collect: [ :i | (arrayOfCharacters at: i) digitValue ] 
	
]

{ #category : #'*LiveCoding' }
Integer >> quavers [
"creates an Array of aNumber of values (0,1) with 1 to the position corresponding to a rhtyhm of quavers (downbeat + upbeat)"
	^ ((1 to: self) collect: [ :i | ((((i rem: 4) = 1)) | (((i rem: 4) = 3)) ) asBit ]) asRhythm asSeq .
]

{ #category : #'*LiveCoding' }
Integer >> randomDiv: aDivision [
"return an array of size=self random values in the range of 0,1 , with a subdivision of 1/aDivision steps with 2 decimal places"
	| r array|
	r := Random new.
	array := ( 0 to: 1 by: (( 1/ aDivision) asFloat)  ) asArray.
	^ (1 to: self) collect: [ :i | (array at: (r nextInt: (array size))) printShowingDecimalPlaces: 2 ].
]

{ #category : #'*LiveCoding' }
Integer >> randomFrom: anArray [

	"return an array of self size of random notes from anArray"

	^ (1 to: self) collect: [ :i | 
		  anArray at: (Random new nextInteger: anArray size) ]
]

{ #category : #'*LiveCoding' }
Integer >> randomInts: aNumber [
"return an array of self size with random integers with range [0, aNumber]"
| floatsArray result |
floatsArray := (self randoms) * aNumber.
result := floatsArray collect: [ :i | i rounded ].
^ result
]

{ #category : #'*LiveCoding' }
Integer >> randomNotes: anArray [

	"answer an Array of size=self with random note numbers between "

	| max min range |
	min := anArray at: 1.
	max := anArray at: 2.
	range := 1 + max - min.
	^ (1 to: self) collect: [ :i | 
		  (Random new nextInteger: range) + min - 1 ]
]

{ #category : #'*LiveCoding' }
Integer >> randomNotesFrom: anArray [

	"return an array of self size of random notes from anArray"

	^ (1 to: self) collect: [ :i | 
		  anArray at: (Random new nextInteger: anArray size) ]
]

{ #category : #'*LiveCoding' }
Integer >> randomNotesFrom: anArray octaves: aNumber [

	"return an array of self size of a random note from anArray + a random octave between 0 and aNumber"

	^ (1 to: self) collect: [ :i | 
		  (anArray at: (Random new nextInteger: anArray size))
		  + ((Random new nextInteger: aNumber + 1) - 1 * 12) ]
]

{ #category : #'*LiveCoding' }
Integer >> randomTrigs [
"generates an Array of random 0s and 1s of size: aNumber"
	| r |
	r := Random new.
	^ ((1 to: self) collect: [ :i | (r next ) rounded]) asRhythm asSeq .
]

{ #category : #'*LiveCoding' }
Integer >> randomTrigsWithProbability: anIntegerProbability [
"generates an Array of random 0s and 1s of size: aNumber with a probability of having a trig of anIntegerProbability "
	| r rytm|
	rytm:= Array new: self.
	r := Random new.
	( 1 to: self) do: [ :i| (r next) < (anIntegerProbability / 100) 
	ifTrue: [ rytm at: i put: 1 ]	ifFalse: [ rytm at: i put: 0 ]
		 ].

^ rytm asRhythm asSeq
]

{ #category : #'*LiveCoding' }
Integer >> randomWalksOn: anArrayOfNotes [

	"random walk inside an array of notes"

	| start nix randomWalker r |
	start := anArrayOfNotes at:
		         ((anArrayOfNotes size / 2) rounded).
	nix := anArrayOfNotes indexOf: start.
	randomWalker := (1 to: self) collect: [ :i | 
		                r := Random new next.
		                r > 0.5
			                ifTrue: [ 
				                nix := (nix + 1 ) min: (anArrayOfNotes size) ]
			                ifFalse: [ 
				                 nix := (nix -1) max: 1 ].


		                anArrayOfNotes at: nix ].
	^ randomWalker
]

{ #category : #'*LiveCoding' }
Integer >> randoms [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r |
	r := Random new.
	^ (1 to: self) collect: [ :i | ((r next ) printShowingDecimalPlaces: 2) asNumber].
]

{ #category : #'*LiveCoding' }
Integer >> rumba [
" create an array of self size of Cuban rumba rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 0 1 0 0 1 0 1 0 0 0 ).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> semibreves [
" returns self number of semibrevesin the first position of the bars"
| result |
result := (('8000' hexBeat ) times: self) .
result durations: 16.
^ result
]

{ #category : #'*LiveCoding' }
Integer >> semiquavers [ 

^ (Array new: self withAll: 1) asRhythm asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> shiko [
" create an array of self size of shiko (West-African / Caribbean) rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 0 1 0 1 0 0 0 1 0 1 0 0 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> sikyi [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

]

{ #category : #'*LiveCoding' }
Integer >> soukous [
" create an array of self size of Central Africa soukous rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 ).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

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
Integer >> trueAksak [
" create an array of self size of Balcan aksak rhytm pulses. Better if used with self = 13 x anInteger "
| pattern |
pattern := #(1 0 1 0 1 0 1 0 0 1 0 1 0).

^ ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> tumbao [
" create an array of self size of  habanera/tumbao rhytm pulses. Better if the receiever is a multiple of eight."
| pattern rhythm |
pattern := #(1 0 0 1 1 0 1 0 ).

rhythm := ((0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ]) asRhythm asSeq.
^ rhythm.

]

{ #category : #'*LiveCoding' }
Integer >> upbeats [
"creates an Array of size=self  of values (0,1) with 1 to the position corresponding to a 4/4 upbeat rhythm"
	^ ((1 to: self) collect: [ :i | (((i rem: 4) = 3)) asBit ]) asRhythm asSeq.
]

{ #category : #'*LiveCoding' }
Integer >> zeros [
	" retuns a Sequencer of gates size = self with all zeros / to create long rests "
^ (Array new: self withAll: 0) asRhythm asSeq asSeq.
]
