Class {
	#name : #PerformerLocal,
	#superclass : #Performer,
	#category : #'LiveCoding-Performance'
}

{ #category : #api }
PerformerLocal >> bpm: bpm [

	bpm toLocal: 'BPM'
]

{ #category : #api }
PerformerLocal >> playGate: gate withNote: note [

	note toLocal: gate asString
]

{ #category : #api }
PerformerLocal >> playGate: gate withTime: gateTimeInSeconds withNote: note [

	gate asString toLocalFor: gateTimeInSeconds note: note
]
