Class {
	#name : 'ChordTests',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
ChordTests >> testChordsToArrays [

	| result |
	result := #( #( 0 3 7 ) #( 2 6 9 ) ).

	self assert: 'C-minor D-major' chordsToArrays asArray equals: result
]

{ #category : 'tests' }
ChordTests >> testParseChord [

self assert: 'D-Major' parseChord equals: #(2 6 9)
]
