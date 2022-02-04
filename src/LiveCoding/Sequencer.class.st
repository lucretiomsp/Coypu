"
A Sequencer is a bidimensional Array containing two arrays, to feed the sequenceFor: aDictionary rate: aNumber method.
The first array contains the gates, the second array contains the notes, the third array contains the durations.
"
Class {
	#name : #Sequencer,
	#superclass : #Array,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #controlling }
Sequencer >> and: anotherArray [
" add array of  values to the Sequencer"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anotherArray .

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

{ #category : #accessing }
Sequencer >> notesSize [

^ ((self at: 2) size)
]

{ #category : #accessing }
Sequencer >> to: aSymbol with: anArray [

^ 'cicisbeo'

]
