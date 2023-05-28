Class {
	#name : #LiveCodingTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
LiveCodingTests >> testArrayFromIntegerInString [

| case result |
case := '38' * 4.
result := #(38 38 38 38).

self assert: case equals: result.
]

{ #category : #tests }
LiveCodingTests >> testArrayIntoScale [

	| indexes newNotes |
	indexes := #( -1 0 1 2 3 4 5 6 7 8 9 10  20 ).

	newNotes := indexes inScale: (Scale chromatic: 60).
	self
		assert: newNotes
		equals: #( 59 0 60 61 62 63 64 65 66 67 68 69 79)
]

{ #category : #tests }
LiveCodingTests >> testArrayWrap [

	| array |
	array := (1 to: 10) asDirtArray.
	self assert: (array wrap: 11) equals: 1
]

{ #category : #tests }
LiveCodingTests >> testFullScale [

	| result |
	result := (Scale chromatic: 60) fullScale.
	self assert: result equals: (0 to: 127) asDirtArray
]

{ #category : #tests }
LiveCodingTests >> testIntegerAsArray [

	self assert: 16 asArrayOfInts equals: (1 to: 16) asDirtArray
]

{ #category : #tests }
LiveCodingTests >> testSawtoothTable [

| array result increment|.

array := (0 to: 1 by: 1/63).
result := 4 bars saw.

self assert: array equals: result.
]

{ #category : #tests }
LiveCodingTests >> testStringForDirt [

	| string gates seq soundsPattern samplesIndex |
	string := 'bd:1 sd cp:2 ~'.
	gates := #(1 1 1 0).
	soundsPattern := #( 'bd' 'sd' 'cp' ).
	samplesIndex := #( 1 0 2 ).
	seq := string forDirt.

self assert: seq gates equals: gates.
	self assert: seq soundPattern equals: soundsPattern.
	self assert: seq samplesIndex equals: samplesIndex
]

{ #category : #tests }
LiveCodingTests >> testTriangleTable [

	| array up down result |
	up := 0 to: 1 by: 1 / 31.
	down := up reverse.
	array := up , down.
	result := 4 bars triangle.

	self assert: array equals: result
]
