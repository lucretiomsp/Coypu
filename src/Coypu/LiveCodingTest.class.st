Class {
	#name : 'LiveCodingTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
LiveCodingTest >> testArrayAsSeries [

	self assert: #(48 60) asSeries equals: (48 to: 60) asArray
]

{ #category : 'tests' }
LiveCodingTest >> testArrayIntoScale [

	| indexes newNotes |
	indexes := #( -1 0 1 2 3 4 5 6 7 8 9 10  20 ).

	newNotes := indexes inScale: (Scale chromatic: 60).
	self
		assert: newNotes
		equals: #( 59 0 60 61 62 63 64 65 66 67 68 69 79)
]

{ #category : 'tests' }
LiveCodingTest >> testArrayWrap [

	| array |
	array := (1 to: 10) asArray .
	self assert: (array wrap: 11) equals: 1
]

{ #category : 'tests' }
LiveCodingTest >> testFullScale [

	| result |
	result := (Scale chromatic: 60) fullScale.
	self assert: result equals: (0 to: 127) asArray
]

{ #category : 'tests' }
LiveCodingTest >> testMultiplyCharacter [

	self assert: $h*3 equals: 'h h h'
]

{ #category : 'tests' }
LiveCodingTest >> testMultiplyString [

	self assert: 'h'*3 equals: 'h h h'
]

{ #category : 'tests' }
LiveCodingTest >> testSawtoothTable [

| array result increment|.

array := (0 to: 1 by: 1/63).
result := 4 bars saw.

self assert: array equals: result.
]

{ #category : 'tests' }
LiveCodingTest >> testStringAsDirtNotes [



| case |

case := '0 , 2*3 , ~ , 5 ~*2' asDirtNotes.

self assert: (case dirtMessage at: 'n') equals: #(0 2 2 2 5 5).
self assert: case gates equals: #(1 1 1 1 0 1 0 1 0)







]

{ #category : 'tests' }
LiveCodingTest >> testStringEveryInt [

	self assert: 'bd' / 8 equals: 'bd ~ ~ ~ ~ ~ ~ ~'
]

{ #category : 'tests' }
LiveCodingTest >> testStringForDirt [

	| string gates seq soundsPattern samplesIndex |
	string := 'bd:1 , sd , cp:2 , ~'.
	gates := #(1 1 1 0).
	soundsPattern := #( 'bd' 'sd' 'cp' ).
	samplesIndex := #( 1 0 2 ).
	seq := string asDirtSounds.

self assert: seq gates equals: gates.
	self assert: seq soundPattern equals: soundsPattern.
	self assert: seq samplesIndex equals: samplesIndex
]

{ #category : 'tests' }
LiveCodingTest >> testStringInWords [

	self assert: 'the needs of the many' inWords equals: #('the' 'needs' 'of' 'the' 'many') asOrderedCollection 
]

{ #category : 'tests' }
LiveCodingTest >> testStringOfSoundsForDirt [

	| case |
	case := 'sd ,  cp*3 , ~ , bd ~*2' asDirtSounds.

	self 
		assert: (case dirtMessage at: 's') 
		equals: #(sd cp cp cp bd bd).
	self 
		assert: case gates 
		equals: #(1 1 1 1 0 1 0 1 0)







]

{ #category : 'tests' }
LiveCodingTest >> testTriangleTable [

	| array up down result |
	up := 0 to: 1 by: 1 / 31.
	down := up reverse.
	array := up , down.
	result := 4 bars triangle.

	self assert: array equals: result
]
