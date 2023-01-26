Class {
	#name : #LiveCodingTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
LiveCodingTests >> testArrayIntoScale [

	| indexes newNotes |
	indexes := #( 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14  ).

	newNotes := indexes inScale: (Scale minor: 60).
	self
		assert: newNotes
		equals: #( 60 62 63 65 67 68 70 72 74 75 77 79 80 82 84 )
]

{ #category : #tests }
LiveCodingTests >> testFullScale [

	| result |
	result := (Scale chromatic: 60) fullScale.
	self assert: result equals: (0 to: 127) asArray
]
