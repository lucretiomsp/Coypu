Class {
	#name : #ChordTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
ChordTests >> testParseChord [

self assert: 'D Major' parseChord equals: #(3 7 10)
]
