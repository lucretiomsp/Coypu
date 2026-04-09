Class {
	#name : 'CoypuUtiltiesTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
CoypuUtiltiesTest >> testAsFallingArray [

self assert: 8 asFallingArray equals: #( 8 7 6 5 4 3 2 1 )
]

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testAsRisingArray [ 


self assert: 8 asRisingArray equals: #(1 2 3 4 5 6 7  8)
]
