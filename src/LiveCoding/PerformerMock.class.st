Class {
	#name : #PerformerMock,
	#superclass : #Performer,
	#instVars : [
		'bpm',
		'playedGates',
		'durations'
	],
	#category : #'LiveCoding-Tests'
}

{ #category : #accessing }
PerformerMock >> bpm [

	^ bpm
]

{ #category : #api }
PerformerMock >> bpm: aBPM [

	bpm := aBPM
]

{ #category : #api }
PerformerMock >> duration: duration forGate: gate [

	durations at: gate put: duration
]

{ #category : #accessing }
PerformerMock >> durationFor: gate [

	^ durations at: gate
]

{ #category : #initialization }
PerformerMock >> initialize [

	playedGates := Dictionary new.
	durations := Dictionary new
]

{ #category : #accessing }
PerformerMock >> lastGate [

	^ playedGates keys last
]

{ #category : #accessing }
PerformerMock >> noteFor: gate [

	^ playedGates at: gate
]

{ #category : #api }
PerformerMock >> playGate: gate withNote: note [

	playedGates at: gate put: note
]

{ #category : #api }
PerformerMock >> playGate: gate withTime: gateTimeInSeconds withNote: note [

	playedGates at: gate put: note
]
