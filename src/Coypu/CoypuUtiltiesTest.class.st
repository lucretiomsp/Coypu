Class {
	#name : 'CoypuUtiltiesTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testOneToSelf [ 


self assert: 8 testOneToSelf equals: #(1 2 3 4 5 6 7  8)
]
