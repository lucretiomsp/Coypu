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

	self assert: 'D-Major' parseChord equals: #( 2 6 9 ).
	self assert: 'major' parseChord equals: #( 0 4 7 ).
]

{ #category : 'tests' }
ChordTests >> testParseChordWithOutRoot [

	self assert: 'major' parseChordWithoutRoot equals: #( 0 4 7 ).
	self assert: 'minor' parseChordWithoutRoot equals: #( 0 3 7 ).
]
