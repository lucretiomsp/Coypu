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
^ Sequencer with: (self at: 1) with: (self at: 2) with: anotherArray .

]

{ #category : #'as yet unclassified' }
Sequencer >> durations [
" returns the third array of the sequencer if there is one, otherwise returns false"
(self size > 2)
ifTrue: [ ^ (self at: 3)] ifFalse: [ ^ false ].

]

{ #category : #'as yet unclassified' }
Sequencer >> durationsSize [

^ ((self at: 3) size)
]

{ #category : #'as yet unclassified' }
Sequencer >> gates [

^ (self at: 1)
]

{ #category : #'as yet unclassified' }
Sequencer >> gatesSize [

^ ((self at: 1) size)
]

{ #category : #testing }
Sequencer >> isSequencer [

(((self size) > 1) & ((self at: 1) isArray ))
ifTrue: [  ^ true ] ifFalse: [ ^ false ]
]

{ #category : #'as yet unclassified' }
Sequencer >> noteIndex [

" returns the fourth array of the sequencer if there is one, otherwise returns 0"
(self size > 3)
ifTrue: [ ^ (self at: 4)] ifFalse: [ ^ 0 ].
]

{ #category : #'as yet unclassified' }
Sequencer >> notes [

^ (self at: 2)
]

{ #category : #'as yet unclassified' }
Sequencer >> notesSize [

^ ((self at: 2) size)
]

{ #category : #'as yet unclassified' }
Sequencer >> velocities [
" returns the fourth array of the sequencer if there is one, otherwise returns false"
(self size > 3)
ifTrue: [ ^ (self at: 4)] ifFalse: [ ^ false ].

]
