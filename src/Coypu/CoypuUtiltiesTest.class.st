Class {
	#name : 'CoypuUtiltiesTest',
	#superclass : 'TestCase',
	#instVars : [
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
CoypuUtiltiesTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	perf := Performance uniqueInstance performer: PerformerLocal new.
]

{ #category : 'tests' }
CoypuUtiltiesTest >> testAsFallingArray [

self assert: 8 asFallingArray equals: #( 8 7 6 5 4 3 2 1 )
]

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testAsRisingArray [ 


self assert: 8 asRisingArray equals: #(1 2 3 4 5 6 7  8)
]

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testTranposeKeyInSeq [

	16 downbeats to: #kick.
	#kick transpose: 8.
	self assert: (perf at: #kick) notes equals: #( 68 68 68 68 )
]
