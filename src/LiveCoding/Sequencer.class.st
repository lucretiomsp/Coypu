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
		'extra2String'
	],
	#category : #LiveCoding
}

{ #category : #copying }
Sequencer >> , anotherSequencer [
"combine the gates of two sequencers, returns an array"
| newGates notes1 notes2|
notes1 := (self at: 2).
notes2:= (anotherSequencer  at: 2).
newGates := (self at: 1), (anotherSequencer at: 1).
( (notes1 = #(60)) & (notes1 = #(60)))
 ifTrue: [ ^ (newGates asSeq) ] ifFalse:
[^ newGates].
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
" change notes in the sequencer - binary variant for notes:"
^ (Sequencer with: (self at: 1) with: anArray with: #(0.125) with: 0).
]

{ #category : #controlling }
Sequencer >> and: anotherArray [
" add array of  extravalues to the Sequencer
the first element of the array should be a string - for example 'Index'' - the second element o the array should be an array of numbers - for xample #( 1 2 3)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anotherArray .

]

{ #category : #controlling }
Sequencer >> and: anArray and: anotherArray [
" add array of  extravalues to the Sequencer
the first element of both arrays should be a string - for example 'Index'' - the second element o the array should be an array of numbers - for xample #( 1 2 3)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anArray with: anotherArray .

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
" returns the fifth array of the sequencer if there is one, otherwise returns false"
(self size > 4)
ifTrue: [ ^ (self at: 5)] ifFalse: [ ^ false ].
]

{ #category : #accessing }
Sequencer >> extra1Size [

^ (((self at: 5) at: 2) size)	
]

{ #category : #accessing }
Sequencer >> extra1String: aString [
"allows the definition of extra1 sufffix"
extra1String := aString.
]

{ #category : #accessing }
Sequencer >> extra2 [
" returns the fifth array of the sequencer if there is one, otherwise returns false"
(self size > 5)
ifTrue: [ ^ (self at: 6)] ifFalse: [ ^ false ].
]

{ #category : #accessing }
Sequencer >> extra2Size [

^ (((self at: 6) at: 2) size)	
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
Sequencer >> noteIndex [

" returns the fourth array of the sequencer if there is one, otherwise returns 0"
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
^ (Sequencer with: (self at: 1) with: anArray with: #(0.125) with: 0).
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
Sequencer >> seqKey [
^seqKey
]

{ #category : #'as yet unclassified' }
Sequencer >> times: anInteger [
"returns a sequence containing anInteger repetition of allthe arrays in the sequencer"

| newGates newNotes newDurations |
newNotes := self notes times: anInteger.
newGates := self gates  times: anInteger.
newDurations := self durations times: anInteger.

^ (Sequencer with: newGates with: newNotes with: newDurations with: 0)
]

{ #category : #'as yet unclassified' }
Sequencer >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : #accessing }
Sequencer >> to: aSymbol with: anArray [

^ 'cicisbeo'

]
