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

	| tresillo |
	tresillo := #( 3 8) euclidean.
	sequencer gates: #( 1 0 0 1 0 0 1 0 ); notes: #(60 60 60).

	self assert: tresillo equals: sequencer
]

{ #category : #tests }
SequencerTests >> testSequencerToPerformance [

sequencer to: #track.
self assert: (Performance uniqueInstance at: #track) equals: sequencer
]
