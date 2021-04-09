Extension { #name : #Integer }

{ #category : #'*LiveCoding' }
Integer >> adowa [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

]

{ #category : #'*LiveCoding' }
Integer >> aksak [
" create an array of self size of Balcan pseudo aksak rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 1 0 0 0 1 0 0 0).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> banda [
" create an array of self size of Banda (Haiti/Vodoo) rhytm pulses. Better if used with self = 8 x anInteger . it is the same rhythm played in the moribayasa rhythm among the Malinke people of Guinea and in Cuba it is called cinquillo"
| pattern |
pattern := #(1 0 1 1 0 1 1 0).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> bomba [
" create an array of self size of  puertorican Bomba rhytm pulses. Better if the receiever is a multiple of eight."
| pattern |
pattern := #(1 0 0 1 1 1 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

]

{ #category : #'*LiveCoding' }
Integer >> bossanova [
" create an array of self size of  bossanova rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> bpm [
"return the duration of 1/16th at self bpm"
^ ((60/  self) /4).
]

{ #category : #'*LiveCoding' }
Integer >> claveSon [
" create an array of self size of  Cuban clave Son rhytm pulses. Better if the receiever is a multiple of 16."
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 1 0 0 0).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

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
Integer >> downbeat [ 

 ^ (1 to: self) collect: [ :i | (((i rem: 4) = 1)) asBit ]. 
]

{ #category : #'*LiveCoding' }
Integer >> gahu [
" create an array of self size of gahu (from Ewe people) rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 0 0 0 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> major [ 
"returns an aray with the major third, fith seventh and thiteenth relative to the note number that is the receiver"
 ^ #(4 7 10 14) collect: [ :i | i + self ].
]

{ #category : #'*LiveCoding' }
Integer >> minor [
"returns an aray with the major third, fith seventh and thiteenth relative to the note number that is the receiver"
 ^ #(3 7 10 14) collect: [ :i | i + self ].
]

{ #category : #'*LiveCoding' }
Integer >> ones [
	" retuns an array of self size with all  ones "
^ Array new: self withAll: 1.
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
	^ (1 to: self) collect: [ :i | ((((i rem: 4) = 1)) | (((i rem: 4) = 3)) ) asBit ].
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
Integer >> randomNotes: anArray [
"answer an Array of size=self with random note numbers between "
| max min range |
min := anArray at: 1.
max := anArray at: 2.
range := 1 + max - min.
^ (1 to: self) collect: [ :i | ((Random new nextInt: range) + min) -1 ].

]

{ #category : #'*LiveCoding' }
Integer >> randomNotesFrom: anArray [
"return an array of self size of random notes from anArray"

^ (1 to: self) collect: [ :i | anArray at: (Random new nextInt: (anArray size)) ].
]

{ #category : #'*LiveCoding' }
Integer >> randomNotesFrom: anArray octaves: aNumber [
"return an array of self size of a random note from anArray + a random octave between 0 and aNumber"

^ (1 to: self) collect: [ :i | (anArray at: (Random new nextInt: (anArray size))) +
	(((Random new nextInt: (aNumber + 1)) -1) * 12).
	
	
	 ].
]

{ #category : #'*LiveCoding' }
Integer >> randomTrigs [
"generates an Array of random v0s and 1s of size: aNumber"
	| r |
	r := Random new.
	^ (1 to: self) collect: [ :i | (r next ) rounded].
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

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> semiquavers [ 

^ Array new: self withAll: 1.
]

{ #category : #'*LiveCoding' }
Integer >> shiko [
" create an array of self size of shiko (West-African / Caribbean) rhytm pulses. Better if used with self = 16 x anInteger "
| pattern |
pattern := #(1 0 0 0 1 0 1 0 0 0 1 0 1 0 0 0).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> sikiyi [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

]

{ #category : #'*LiveCoding' }
Integer >> sikyi [
" create an array of self size of  sikyi (by Ashanti people of Ghana) rhytm pulses. Better if the receiever is a multiple of 8."
| pattern |
pattern := #(0 0 0 1 0 1 0 1).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

]

{ #category : #'*LiveCoding' }
Integer >> soukous [
" create an array of self size of Central Africa soukous rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> stepsProcessfor: aDictionaryOfPatterns rate: aRateInSeconds [
" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address withou slash that will be sent out"
|   maxLength  |

maxLength := 64."~steps"
[ 	| index |
	index := 0.
	self timesRepeat: [ (Delay forSeconds: (aRateInSeconds  /2) )wait. 
		aDictionaryOfPatterns keysAndValuesDo: [ :key : value |
		(value at: (index rem: value size) + 1) toKyma: (key asString)].
		(Delay forSeconds: (aRateInSeconds /2)) wait.
		
		
		aDictionaryOfPatterns keysDo: [ : key  | ((key asString) includesSubstring: 'Gate') ifTrue: [0 		toKyma: (key asString)]].
		
		"increment of one but within the boundaries of the maxLength"
		index  := (index + 1) rem: maxLength .
		  ]  
	
	
	] forkAt:  (Processor timingPriority )
]

{ #category : #'*LiveCoding' }
Integer >> timesProcessFor: anArrayOfSharedQueues speed: anIntervalInSeconds to: anArrayOfStrings [
" repeated process for live coding- deprecated  : do we really neeed all this complexity?"
[|  arrayOfSentValues arrayOfNextValues numberOfEvents index |
	index := 0.
	numberOfEvents := (anArrayOfSharedQueues size).
arrayOfSentValues := Array new: numberOfEvents.
arrayOfNextValues := Array new: numberOfEvents.
self timesRepeat: [  (Delay forSeconds: anIntervalInSeconds) wait.
(1 to: numberOfEvents) do: [ :i |
		arrayOfNextValues at: i put: ((anArrayOfSharedQueues at: i) nextOrNil).
		(arrayOfNextValues at: i)ifNotNil: [ (arrayOfSentValues at: i put: (arrayOfNextValues at: i) )].
		((arrayOfSentValues at: i) isArray) ifTrue: [  
			
		((arrayOfSentValues at: i) at:  (index + 1) "(index + 1) )rem: ((arrayOfNextValues at: i) size))"
		) toKyma: (anArrayOfStrings at: i)] ifFalse: [ Transcript show: 'one of the shared queues is not an array'; cr ].
		index  := (index + 1) rem: 16 "((arrayOfNextValues at: i) size)".
	 ]
	
] 	

] forkAt: Processor timingPriority .
]

{ #category : #'*LiveCoding' }
Integer >> tresillo [
" create an array of self size of  tresillo rhytm pulses. Better if used with self = 8 x anInteger "
| pattern |
pattern := #(1 0 0 1 0 0 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> trueAksak [
" create an array of self size of Balcan aksak rhytm pulses. Better if used with self = 13 x anInteger "
| pattern |
pattern := #(1 0 1 0 1 0 1 0 0 1 0 1 0).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

"implement shifting to the left"
]

{ #category : #'*LiveCoding' }
Integer >> tumbao [
" create an array of self size of  habanera/tumbao rhytm pulses. Better if the receiever is a multiple of eight."
| pattern |
pattern := #(1 0 0 1 1 0 1 0 ).

^ (0 to: (self -1) ) collect: [ :i | pattern at: ((i rem: pattern size) + 1) ].

]

{ #category : #'*LiveCoding' }
Integer >> upbeat [
"creates an Array of size=self  of values (0,1) with 1 to the position corresponding to a 4/4 upbeat rhythm"
	^ (1 to: self) collect: [ :i | (((i rem: 4) = 3)) asBit ].
]

{ #category : #'*LiveCoding' }
Integer >> zeros [
	" retuns an array of self size with all zeros"
^ Array new: self withAll: 0.
]
