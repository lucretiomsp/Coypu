Class {
	#name : #ParsingTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
ParsingTests >> testCharacterMultiplication [


self assert: 'a' * 3 equals: 'a a a'.
]

{ #category : #tests }
ParsingTests >> testMultiplyStringsInString [

self assert: 'bd cp:4 ~ * 2' multiplyStringsInString equals: 'bd cp:4 ~  bd cp:4 ~ '
]

{ #category : #tests }
ParsingTests >> testasSeqGates [

self assert: 'bd cp:4 ~ sd' asSeqGates equals: #(1 1 0 1).

self assert: '0 3 4 ~' asSeqGates equals: #(1 1 1 0).
]
