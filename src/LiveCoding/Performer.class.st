Class {
	#name : #Performer,
	#superclass : #Object,
	#category : #'LiveCoding-Performance'
}

{ #category : #api }
Performer >> bpm: bpm [

	self subclassResponsibility 
]

{ #category : #api }
Performer >> playGate: gate withNote: note [

	self subclassResponsibility 
]

{ #category : #api }
Performer >> playGate: gate withTime: gateTimeInSeconds withNote: note [

	self subclassResponsibility
]
