Class {
	#name : #ParsingTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
ParsingTests >> testCharacterMultiplication [


self assert: 'a' * 3 equals: 'a a a'.
]
