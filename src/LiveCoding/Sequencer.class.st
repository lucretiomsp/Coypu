Class {
	#name : #Sequencer,
	#superclass : #Array,
	#type : #variable,
	#category : #LiveCoding
}

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

(((self size) = 2) & ((self at: 1) isArray ))
ifTrue: [  ^ true ] ifFalse: [ ^ false ]
]

{ #category : #'as yet unclassified' }
Sequencer >> notes [

^ (self at: 2)
]

{ #category : #'as yet unclassified' }
Sequencer >> notesSize [

^ ((self at: 2) size)
]
