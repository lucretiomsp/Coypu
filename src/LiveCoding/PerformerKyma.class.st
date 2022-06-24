Class {
	#name : #PerformerKyma,
	#superclass : #Performer,
	#category : #'LiveCoding-Performance'
}

{ #category : #api }
PerformerKyma >> bpm: bpm [

	bpm toKyma: 'BPM'
]

{ #category : #api }
PerformerKyma >> duration: duration forGate: gate [

	duration toKyma: gate asString , 'Duration'
]

{ #category : #api }
PerformerKyma >> playGate: gate withNote: note [

	note toKyma: gate asString
]

{ #category : #api }
PerformerKyma >> playGate: gate withTime: gateTimeInSeconds withNote: note [

	gate asString toKymaAsGate: gateTimeInSeconds note: note
]
