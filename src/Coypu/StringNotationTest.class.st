Class {
	#name : 'StringNotationTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
StringNotationTest >> testAsDirtLevelForMidiPerfomer [

	| seq p |
	p := Performance uniqueInstance performer: PerformerMIDI  new.
	seq := '1 , 0.5*2 , ~ , 0.3/4 ' asDirtLevel.

	self assert: (seq extraParams at: 7  ) equals: #( 1 0.5 0.5 0.3 )
]

{ #category : 'tests' }
StringNotationTest >> testAsDirtLevelForPerformer [

	| seq p|
	p := Performance uniqueInstance performer: PerformerLocal new.
	seq := '1 , 0.5*2 , ~ , 0.3/4 ' asDirtLevel.
	

	self assert: (seq extraParams at: #ULevel) equals: #( 1 0.5 0.5 0.3 )
]

{ #category : 'tests' }
StringNotationTest >> testAsDirtNotes [
    | seq |

    "--- Plain MIDI numbers (old syntax) ---"
    seq := '60,62,64' asDirtNotes.
    self assert: seq notes equals: #( 60 62 64 ).
    self assert: seq durations equals: #( 1 1 1 ).

    "--- Note names (new syntax) ---"
    seq := 'c4,d4,e4' asDirtNotes.
    self assert: seq notes equals: #( 60 62 64 ).
    self assert: seq durations equals: #( 1 1 1 ).

    "--- Old and new mixed ---"
    seq := 'c4,62,e4,65' asDirtNotes.
    self assert: seq notes equals: #( 60 62 64 65 ).
    self assert: seq durations equals: #( 1 1 1 1 ).

    "--- Equivalence: same phrase both ways ---"
    self 
        assert: ('c4,d4,~,e4' asDirtNotes notes) 
        equals: ('60,62,~,64' asDirtNotes notes).

    "--- Rests with ~ ---"
    seq := 'c4,~,e4' asDirtNotes.
    self assert: seq notes equals: #( 60 64 ).
    self assert: seq durations equals: #( 1 1 ).

    "--- Rests with - ---"
    seq := 'c4,-,e4' asDirtNotes.
    self assert: seq notes equals: #( 60 64 ).
    self assert: seq durations equals: #( 1 1 ).

    "--- Sharps and flats ---"
    seq := 'c#4,bb3,fs3' asDirtNotes.
    self assert: seq notes equals: #( 61 58 54 ).

    "--- Multiply * ---"
    seq := 'c4*2,e4' asDirtNotes.
    self assert: seq notes equals: #( 60 60 64 ).
    self assert: seq durations equals: #( 1 1 1 ).

    "--- Divide / ---"
    seq := 'c4,e4/3' asDirtNotes.
    self assert: seq durations equals: #( 1 3 ).

    "--- Complex phrase mixing everything ---"
    seq := 'c4,~,f#3*2,bb2/3,-,d4' asDirtNotes.
    self assert: seq notes equals: #( 60 54 54 46 62 ).

 
]

{ #category : 'tests' }
StringNotationTest >> testAsDirtSounds [

	| seq pgd |
	seq := 'cp , sd , lt *2' asDirtSounds.
	pgd := #( 'cpTrigger' 'sdTrigger' 'ltTrigger' 'ltTrigger' ).
	self
		assert: (seq soundPattern first findBetweenSubstrings: ' ')
		equals: #( 'cp' 'sd' 'lt' 'lt' ) asOrderedCollection.
	self assert: seq phaustoGateDestinations equals: pgd
]

{ #category : 'tests' }
StringNotationTest >> testGetDivisor [

self assert: '60/8' getDivisor equals: 8.
]

{ #category : 'tests' }
StringNotationTest >> testGetMultiplier [

self assert: '36*4' getMultiplier equals: 4.
]

{ #category : 'tests' }
StringNotationTest >> testSplitRespectingQuotes [

	| testString result |
	testString := ' ''65 , ~ * 4 , 63 ,57 '' asDirtNotes to: #lead .'.
	result := #( '''65 , ~ * 4 , 63 ,57 ''' 'asDirtNotes' 'to:' '#lead'
	             '.' ).
	
	self
		assert: testString splitRespectingQuotes asArray
		equals: result 
]
