Class {
	#name : 'CoypuUtiltiesTest',
	#superclass : 'TestCase',
	#instVars : [
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
CoypuUtiltiesTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	perf := Performance uniqueInstance performer: PerformerLocal new.
]

{ #category : 'tests' }
CoypuUtiltiesTest >> testAsFallingArray [

self assert: 8 asFallingArray equals: #( 8 7 6 5 4 3 2 1 )
]

{ #category : 'converting' }
CoypuUtiltiesTest >> testAsMidiNote [

    "Plain numbers"
    self assert: '60' asMidiNote equals: 60.
    self assert: '0' asMidiNote equals: 0.
    self assert: '127' asMidiNote equals: 127.
    self assert: '200' asMidiNote equals: 127.

    "Middle C"
    self assert: 'c4' asMidiNote equals: 60.

    "Natural notes"
    self assert: 'd4' asMidiNote equals: 62.
    self assert: 'e4' asMidiNote equals: 64.
    self assert: 'f4' asMidiNote equals: 65.
    self assert: 'g4' asMidiNote equals: 67.
    self assert: 'a4' asMidiNote equals: 69.
    self assert: 'b4' asMidiNote equals: 71.

    "Octaves — 12 semitones apart"
    self assert: 'c0' asMidiNote equals: 12.
    self assert: 'c1' asMidiNote equals: 24.
    self assert: 'c2' asMidiNote equals: 36.
    self assert: 'c3' asMidiNote equals: 48.
    self assert: 'c5' asMidiNote equals: 72.

    "Sharps with #"
    self assert: 'c#4' asMidiNote equals: 61.
    self assert: 'f#3' asMidiNote equals: 54.
    self assert: 'g#2' asMidiNote equals: 44.

    "Sharps with s (TidalCycles style)"
    self assert: 'cs4' asMidiNote equals: 61.
    self assert: 'fs3' asMidiNote equals: 54.
    self assert: 'gs2' asMidiNote equals: 44.

    "Flats with b"
    self assert: 'db4' asMidiNote equals: 61.
    self assert: 'eb4' asMidiNote equals: 63.
    self assert: 'bb3' asMidiNote equals: 58.

    "Flats with f (TidalCycles style)"
    self assert: 'df4' asMidiNote equals: 61.
    self assert: 'ef4' asMidiNote equals: 63.
    self assert: 'bf3' asMidiNote equals: 58.

    "Double sharps"
    self assert: 'c##4' asMidiNote equals: 62.
    self assert: 'cx4' asMidiNote equals: 62.
    self assert: 'css4' asMidiNote equals: 62.

    "Double flats"
    self assert: 'cbb4' asMidiNote equals: 58.
    self assert: 'cff4' asMidiNote equals: 58.
    self assert: 'dbb4' asMidiNote equals: 60.

    "B note vs B-flat — the critical ambiguity"
    self assert: 'b3' asMidiNote equals: 59.
    self assert: 'bb3' asMidiNote equals: 58.
    self assert: 'bbb3' asMidiNote equals: 57.

    "Case insensitive"
    self assert: 'C4' asMidiNote equals: 60.
    self assert: 'C#4' asMidiNote equals: 61.
    self assert: 'Bb3' asMidiNote equals: 58.

    "Whitespace trimming"
    self assert: ' c4 ' asMidiNote equals: 60.
    self assert: ' f#3 ' asMidiNote equals: 54.

    "Enharmonic equivalents"
    self assert: 'c#4' asMidiNote equals: 'db4' asMidiNote.
    self assert: 'e4' asMidiNote equals: 'fb4' asMidiNote.
    self assert: 'b3' asMidiNote equals: 'cb4' asMidiNote.
    self assert: 'f4' asMidiNote equals: 'e#4' asMidiNote.
    self assert: 'c' asMidiNote equals: 60.
    self assert: 'c#' asMidiNote equals: 61.

    "Range clamping"
    self assert: ('c0' asMidiNote >= 0).
    self assert: 'g9' asMidiNote equals: 127.

    "check errors"
    self should: [ 'z4' asMidiNote ] raise: Error.
   
    "Chromatic scale — the ultimate check"
    self 
        assert: (#('c4' 'cs4' 'd4' 'ds4' 'e4' 'f4' 
                    'fs4' 'g4' 'gs4' 'a4' 'as4' 'b4')
            collect: [ :n | n asMidiNote ])
        equals: (60 to: 71) asArray.
]

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testAsRisingArray [ 


self assert: 8 asRisingArray equals: #(1 2 3 4 5 6 7  8)
]

{ #category : 'as yet unclassified' }
CoypuUtiltiesTest >> testTransposeKeyInSeq [

	16 downbeats to: #kick.
	#kick transpose: 8.
	self assert: (perf at: #kick) notes equals: #( 68 68 68 68 )
]
