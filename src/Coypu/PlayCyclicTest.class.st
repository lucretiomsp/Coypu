Class {
	#name : 'PlayCyclicTest',
	#superclass : 'TestCase',
	#instVars : [
		'sequencer',
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
PlayCyclicTest >> setUp [
	super setUp.

	  perf := Performance uniqueInstance.
    perf performer: MockPerformer new.
]

{ #category : 'running' }
PlayCyclicTest >> tearDown [
  super tearDown.
	perf performer: PerformerLocal new
]

{ #category : 'tests' }
PlayCyclicTest >> testPlayCyclicFiresCorrectNumberOfEvents [
    | seq |
    seq := 'c4 e4 g4' asDirtNotes.
    seq to: perf.
    perf performer playCyclicFor: 1.
    (Delay forSeconds: 2) wait.
    self assert: perf performer playedEvents size equals: 3.
]

{ #category : 'tests' }
PlayCyclicTest >> testPlayCyclicFiresEventsInOrder [
    | seq |
    seq := 'c4 e4 g4' asDirtNotes.
    seq to: perf.
    perf performer playCyclicFor: 1.
    (Delay forSeconds: 2) wait.
    self assert: perf performer playedEvents 
        equals: #(1 2 3) asOrderedCollection.
]
