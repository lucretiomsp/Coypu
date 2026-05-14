Class {
	#name : 'PlayDispatchTest',
	#superclass : 'TestCase',
	#instVars : [
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
PlayDispatchTest >> setUp [

	super setUp.
	perf := Performance uniqueInstance performer: MockPerformer new.
	perf removeAll
]

{ #category : 'tests' }
PlayDispatchTest >> testCyclicPlayerFiresOnQuery [

'c4 e4 g4' asMondoNotes to: #kick.
	
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

	| seq  |

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
