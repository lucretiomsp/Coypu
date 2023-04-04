Class {
	#name : #SequencerTests,
	#superclass : #TestCase,
	#instVars : [
		'sequencer'
	],
	#category : #'LiveCoding-Tests'
}

{ #category : #running }
SequencerTests >> setUp [

	sequencer := 8 downbeats.
	

	"Put here a common initialization logic for tests"
]

{ #category : #tests }
SequencerTests >> testEuclideanRhythmFromArray [

	| tresillo seq |
	tresillo := #( 3 8) euclidean.
	seq := #( 1 0 0 1 0 0 1 0) asRhythm asSeq.
	self assert: tresillo equals: seq
]

{ #category : #tests }
SequencerTests >> testFlipSequencer [

	| tresillo seq |
	tresillo := #( 3 8 ) euclidean flip.
	seq := #( 0 1 1 0 1 1 0 1 ) asRhythm asSeq .
	self assert: tresillo equals: seq
]

{ #category : #tests }
SequencerTests >> testSequencerToPerformance [

sequencer to: #track.
self assert: (Performance uniqueInstance at: #track) equals: sequencer
]
