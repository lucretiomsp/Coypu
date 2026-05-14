Class {
	#name : 'PlayDispatchTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
PlayDispatchTest >> testCyclicPlayerFiresOnQuery [
	| seq perf |
	perf := Performance uniqueInstance performer: PerformerLocal new.
	seq := 'c4 e4 g4' asMondoNotes.  "cyclic"
	seq to: perf.
	perf performer playStepSync.
	self assert: perf performer playedEvents size equals: 1
]

{ #category : 'tests' }
PlayDispatchTest >> testCyclicPlayerWiring [

	| seq |
	seq := 'c4 e4 g4' asMondoNotes.
	seq player: SequencerPlayerCyclic new.
	self assert: seq player class equals: SequencerPlayerCyclic
]

{ #category : 'tests' }
PlayDispatchTest >> testLinearPlayerFiresOnGate [

	| seq perf |
	perf := Performance uniqueInstance performer: PerformerLocal new.
	seq := '60 62 64' asDirtNotes. "linear by default"
	seq to: perf.
	perf performer playStepSync.
	self assert: perf performer playedEvents size equals: 1
]

{ #category : 'tests' }
PlayDispatchTest >> testPlayerIsCorrectlyAssigned [
	| linear cyclic |
	linear := '60 62' asDirtNotes.
	cyclic := 'c4 e4' asMondoNotes.
	self assert: linear player class equals: SequencerPlayerLinear.
	self assert: cyclic player class equals: SequencerPlayerCyclic
]
