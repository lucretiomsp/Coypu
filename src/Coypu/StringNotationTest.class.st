Class {
	#name : 'StringNotationTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
StringNotationTest >> testAsDirtLevelForMidiPerfomer [

	| seq p |
	p := Performance uniqueInstance performer: PerformerMIDI  new.
	seq := '1 , 0.5*2 , ~ , 0.3/4 ' asDirtLevel.

	self assert: (seq extraParams at: 7  ) equals: #( 1 0.5 0.5 0.3 )
]

{ #category : 'tests' }
StringNotationTest >> testAsDirtLevelForPerformer [

	| seq p|
	p := Performance uniqueInstance performer: PerformerLocal new.
	seq := '1 , 0.5*2 , ~ , 0.3/4 ' asDirtLevel.
	

	self assert: (seq extraParams at: #ULevel) equals: #( 1 0.5 0.5 0.3 )
]

{ #category : 'tests' }
StringNotationTest >> testAsDirtNotes [

	| seq |
	seq := '60 * 3 , 31 ~ * 2 , ~ , 61/4' asDirtNotes.
	self assert:  seq gates equals:  #( 1 1 1 1 0 1 0 0 1 0 0 0).
	self assert: seq notes equals: #(60 60 60 31 31 61).
	self deny: seq durations isEmpty .
]

{ #category : 'tests' }
StringNotationTest >> testGetDivisor [

self assert: '60/8' getDivisor equals: 8.
]

{ #category : 'tests' }
StringNotationTest >> testGetMultiplier [

self assert: '36*4' getMultiplier equals: 4.
]

{ #category : 'tests' }
StringNotationTest >> testSplitRespectingQuotes [

	| testString result |
	testString := ' ''65 , ~ * 4 , 63 ,57 '' asDirtNotes to: #lead .'.
	result := #( '''65 , ~ * 4 , 63 ,57 ''' 'asDirtNotes' 'to:' '#lead'
	             '.' ).
	
	self
		assert: testString splitRespectingQuotes asArray
		equals: result 
]
