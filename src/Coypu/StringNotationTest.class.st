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
