Class {
	#name : #SequencerTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
SequencerTests >> testBinaryOperatorForExtra1 [

| seq |
seq := 16 rumba.
self assert: (seq < #(#Index #(1 2 3))) extra1 equals: #(#Index #( 1 2 3))
]

{ #category : #tests }
SequencerTests >> testCombineSequencersWithComma [

	| seq1 seq2 combinedSeq |
	seq1 := 16 downbeats.
	seq2 := 16 upbeats notes: 48.
	combinedSeq := #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0
	                  1 0 0 0 1 0 ) asRhythm  notes: #( 60 60 60 60 48 48 48 48 ).

	self assert: seq1 , seq2 equals: combinedSeq
]

{ #category : #tests }
SequencerTests >> testSequencerCreation [

	| seq |
	seq := 16 downbeats notes: #( 36 48 60 72 ).

	self assert: seq isSequencer equals: true.
	self
		assert: seq gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.
	self assert: seq notes equals: #( 36 48 60 72 )
]
