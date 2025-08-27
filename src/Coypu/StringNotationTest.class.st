Class {
	#name : 'StringNotationTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

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
	result := #( '''65 , ~ * 4 , 63 ,57''' 'asDirtNotes' 'to:' '#lead'
	             '.' ).
	self
		assert: testString splitRespectingQuotes asArray
		equals: result 
]
