Class {
	#name : #ParsingTests,
	#superclass : #TestCase,
	#category : #'Coypu-Tests'
}

{ #category : #tests }
ParsingTests >> testCharacterMultiplication [


	self assert: 'a' * 3 equals: 'a a a'.
]

{ #category : #tests }
ParsingTests >> testMultiplyStringsInString [

	self 
		assert: 'bd cp:4 ~ * 2' multiplyStringsInString 
		equals: 'bd cp:4 ~  bd cp:4 ~ '
]

{ #category : #tests }
ParsingTests >> testNotesFromNotatedString [

	| seq |
	seq := 8 semiquavers.
	self
		assert: (seq dirtNotes: '40*4 , 88*4') notes
		equals: #(40 40 40 40 88 88 88 88)
]

{ #category : #tests }
ParsingTests >> testStringsWitNRests [

	self 
		assert: 'bd / 4' withNRests  
		equals: 'bd  ~ ~ ~'
]

{ #category : #tests }
ParsingTests >> testasSeqGates [

	self 
		assert: 'bd cp:4 ~ sd' asSeqGates 
		equals: #(1 1 0 1).

	self 
		assert: '0 3 4 ~' asSeqGates 
		equals: #(1 1 1 0).
]
