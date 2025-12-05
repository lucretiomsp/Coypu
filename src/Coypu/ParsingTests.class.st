Class {
	#name : 'ParsingTests',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
ParsingTests >> testCharacterMultiplication [

	self assert: 'a' * 3 equals: 'a a a'.
	self assert: '30 46' * 2 equals: '30 46 30 46'.
	self assert: '38 ~' * 3 equals: '38 ~ 38 ~ 38 ~'
]

{ #category : 'tests' }
ParsingTests >> testCumbiaClave [

	self
		assert: 16 cumbiaClave gates
		equals: #(1 0 0 0 1 0 1 0 1 0 0 0 1 0 1 0) asRhythm 
]

{ #category : 'tests' }
ParsingTests >> testMultiplyStringsInString [

	self 
		assert: 'bd cp:4 ~ * 2' multiplyStringsInString 
		equals: 'bd cp:4 ~  bd cp:4 ~ '
]

{ #category : 'tests' }
ParsingTests >> testNotesFromNotatedString [

	| seq |
	seq := 8 semiquavers.
	self
		assert: (seq dirtNotes: '40*4 , 88*4') notes
		equals: #(40 40 40 40 88 88 88 88)
]

{ #category : 'tests' }
ParsingTests >> testStringNoteNameToMidiNN [

self assert: 'c3' asMidiNN equals: 60.
self assert: 'c2' asMidiNN equals: 48.
self assert: 'd3' asMidiNN equals: 62.
self assert: 'c#3' asMidiNN equals: 61.
self assert: 'e2' asMidiNN equals: 52.
self assert: 'd#4' asMidiNN equals: 75.



]

{ #category : 'tests' }
ParsingTests >> testStringsWitNRests [

	self 
		assert: 'bd / 4' withNRests  
		equals: 'bd  ~ ~ ~'
]

{ #category : 'tests' }
ParsingTests >> testasSeqGates [

	self 
		assert: 'bd cp:4 ~ sd' asSeqGates 
		equals: #(1 1 0 1).

	self 
		assert: '0 3 4 ~' asSeqGates 
		equals: #(1 1 1 0).
]
