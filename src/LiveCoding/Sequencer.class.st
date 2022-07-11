"
A Sequencer is a bidimensional Array containing two arrays, to feed the sequenceFor: aDictionary rate: aNumber method.
The first array contains the gates, the second array contains the notes, the third array contains the durations.
"
Class {
	#name : #Sequencer,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'seqKey',
		'extra1String',
		'extra2String',
		'extra1',
		'extra2'
	],
	#category : #LiveCoding
}

{ #category : #copying }
Sequencer >> , anotherSequencer [
"combine the gates of two sequencers, returns an array"
| newGates newNotes newDurations notes1 notes2|
notes1 := (self at: 2).
notes2:= (anotherSequencer  at: 2).
newGates := (self at: 1), (anotherSequencer at: 1).
newDurations := (self at: 3), (anotherSequencer at: 3).
newNotes := notes1, notes2.
^ Sequencer with: newGates with: newNotes with: newDurations with: 0.
]

{ #category : #comparing }
Sequencer >> < anotherArray [
"same as and: but binary!"
" add array of  extravalues to the Sequencer
the first element of the array should be a string - for example 'Index'' - the second element o the array should be an array of numbers - for xample #( 1 2 3)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anotherArray .

]

{ #category : #'as yet unclassified' }
Sequencer >> > anArray [

" change notes in the sequencer - polysemic binary version of notes:"
^ (Sequencer with: (self at: 1) with: anArray with: #(1) with: 0).

]

{ #category : #controlling }
Sequencer >> and: anotherArray [
" add array of  extravalues to the Sequencer
the first element of both arrays should be a string - for example 'Index'' if sending out OSC or an integer value corresponding to CC message if sending out MIDI
- the second element o the array should be an array of numbers - for example #( 1 2 3)
#('Cutoff' #(34 56 78)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anotherArray .

]

{ #category : #controlling }
Sequencer >> and: anArray and: anotherArray [
" add array of  extravalues to the Sequencer
the first element of both arrays should be a string - for example 'Index'' if sending out OSC or an integer value corresponding to CC message if sending out MIDI
- the second element o the array should be an array of numbers - for example #( 1 2 3)
#('Cutoff' #(34 56 78)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anArray with: anotherArray .

]

{ #category : #controlling }
Sequencer >> and: anArray and: anotherArray and: aThirdArray [
" add array of  extravalues to the Sequencer
the first element of both arrays should be a string - for example 'Index'' if sending out OSC or an integer value corresponding to CC message if sending out MIDI
- the second element o the array should be an array of numbers - for example #( 1 2 3)
#('Cutoff' #(34 56 78)
"
| seq |
seq := Sequencer new: 7.


(1 to: 4) do:
[:i | seq at: i put: (self at: i)].
seq at: 5 put: anArray.
seq at: 6 put: anotherArray .
seq at: 7 put: aThirdArray.

^ seq.

]

{ #category : #accessing }
Sequencer >> duration [

	^ self durations at: (self noteIndex modulo: self durationsSize)
]

{ #category : #accessing }
Sequencer >> durations [
" returns the third array of the sequencer if there is one, otherwise returns false"
(self size > 2)
ifTrue: [ ^ (self at: 3)] ifFalse: [ ^ false ].

]

{ #category : #accessing }
Sequencer >> durationsSize [

^ ((self at: 3) size)
]

{ #category : #accessing }
Sequencer >> extra1 [

	" returns extra1 if it is defined, otherwise returns a dummy array"

	^ extra1
]

{ #category : #accessing }
Sequencer >> extra1: anArrayWithStringAndArray [

"example #('cutoff' #(99 111 87 56))"
extra1 := anArrayWithStringAndArray .
]

{ #category : #accessing }
Sequencer >> extra1Size [

"return the size of the array of values for extra1"
| values |
values := extra1 at: 2.
	^ extra1 notNil
		  ifTrue: [ ^ values size ]
		  ifFalse: [ ^ 1 ]
]

{ #category : #accessing }
Sequencer >> extra1String: aString [
"allows the definition of extra1 sufffix"
extra1String := aString.
]

{ #category : #accessing }
Sequencer >> extra2 [

	" returns extra1 if it is defined, otherwise returns a dummy array"

	^ extra2
]

{ #category : #accessing }
Sequencer >> extra2: anArrayWithStringAndArray [

	"example #('cutoff' #(99 111 87 56))"

	extra2 := anArrayWithStringAndArray
]

{ #category : #accessing }
Sequencer >> extra2Size [

		"return the size of the array of values for extra2"

	| values |
	values := extra1 at: 2.
	^ extra1 notNil
		  ifTrue: [ ^ values size ]
		  ifFalse: [ ^ 1 ]
]

{ #category : #accessing }
Sequencer >> extra2String: aString [
"allows the definition of extra1 sufffix"
extra2String := aString.
]

{ #category : #accessing }
Sequencer >> gates [

^ (self at: 1)
]

{ #category : #'as yet unclassified' }
Sequencer >> gates: aRhythm [
"change the rhythm inside the sequencer".
self at:1 put: aRhythm.
]

{ #category : #accessing }
Sequencer >> gatesSize [

^ ((self at: 1) size)
]

{ #category : #testing }
Sequencer >> isSequencer [

(((self size) > 1) & ((self at: 1) isArray ))
ifTrue: [  ^ true ] ifFalse: [ ^ false ]
]

{ #category : #accessing }
Sequencer >> note [

	^ self notes at: (self noteIndex modulo: self notesSize)
]

{ #category : #accessing }
Sequencer >> noteIndex [

" returns the fourth array of the sequencer if there is one, otherwise returns 0.
noteIndex is used to play the folloowing note in the array. Only if there is a trig in the gates the noteIndex  will be incremented"
(self size > 3)
ifTrue: [ ^ (self at: 4)] ifFalse: [ ^ 0 ].
]

{ #category : #accessing }
Sequencer >> notes [

^ (self at: 2)
]

{ #category : #'as yet unclassified' }
Sequencer >> notes: anArray [
" change notes in the sequencer"
^ (Sequencer with: (self at: 1) with: anArray with: #(1) with: 0).
]

{ #category : #'as yet unclassified' }
Sequencer >> notes: anArrayOfNotes durs: anArrayOfDurations [
" change notes in the sequencer"
^ (Sequencer with: (self at: 1) with: anArrayOfNotes with: anArrayOfDurations  with: 0).
]

{ #category : #accessing }
Sequencer >> notesSize [

^ ((self at: 2) size)
]

{ #category : #counting }
Sequencer >> numberOfGates [ 

"return number of elements in the Sequencer gates array that are greater than 0"
| result size |
result := (self gates) select: [ :i | i > 0 ].
size := result size.
^ size
]

{ #category : #accessing }
Sequencer >> offset: aNumber [

	"offset the rhythm inside the sequencerby aNumber of 'steps' wrapping it around its size"

	| rhythm melody |
	rhythm := self gates.
	melody := self notes.
	self gates: (rhythm offset: aNumber).
	self notes: (melody offset: aNumber)
]

{ #category : #'*LiveCoding' }
Sequencer >> randomCounterPoint [

	" creates aSequencer of trigs randomly counterpointed with self array"

	| newArray |
	newArray := Array new: self gates size.
	1 to: self gates size do: [ :i | 
		(self gates at: i) = 1
			ifTrue: [ newArray at: i put: 0 ]
			ifFalse: [ newArray at: i put: Random new nextTrig ] ].
	^ newArray asSeq
]

{ #category : #accessing }
Sequencer >> seqKey [
^seqKey
]

{ #category : #accessing }
Sequencer >> stepIndex [

	self at: 4 put: self noteIndex + 1
]

{ #category : #'as yet unclassified' }
Sequencer >> times: anInteger [

"returns a sequencer containing anInteger repetition of self"
| newGates newNotes newDurations |
newGates := (self gates times: anInteger) asRhythm.
newNotes := self notes times: anInteger.
newDurations := self durations times: anInteger.



^ (Sequencer with: newGates with: newNotes with: newDurations with: 0).

]

{ #category : #'as yet unclassified' }
Sequencer >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : #accessing }
Sequencer >> to: aSymbol with: anArray [

^ 'cicisbeo'

]

{ #category : #accessing }
Sequencer >> transpose: aNumberOfSemitones [

	| melody |
	melody := self notes.
	self notes: (melody + aNumberOfSemitones)
]

{ #category : #'as yet unclassified' }
Sequencer >> trigs [
"return the number of trigs, i.e. gates = 1,  of the sequencer"
| result |
result := 0.
(1 to: (self gates size)) do: [ :i | ((self gates at: i) = 1) ifTrue: [result := result + 1] ifFalse: [ nil]].
^ result.
]
