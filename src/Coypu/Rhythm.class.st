"
Rhythm class is to be used to generate Arrays of values in the range 0,1 to be used mainly to feed sequencers.
Deprecated at the moment, send message to Integers to create sequencer-like patterns.


about OSC package in use: 
Versions Stable	1.0
###################	
Repository
Metacello script
Metacello new
	smalltalkhubUser: 'Pharo' project: 'MetaRepoForPharo50';
	configuration: 'OSC';
	version: #stable;
	load. during: 
"
Class {
	#name : #Rhythm,
	#superclass : #Array,
	#type : #variable,
	#category : #'Coypu-Sequencers'
}

{ #category : #accessing }
Rhythm class >> list [

	"return all the possible Rhythms obtainable sending messages to integers"

	| rhythmList |
	rhythmList := #( 'adowa' 'aksak' 'banda' 'bomba' 'bossa' 'breves'
	                 'semibreves' 'claveSon' 'downbeats' 'gahu' 'ones'
	                 'quavers' 'semiquavers' 'rumba' 'shiko' 'sikyi'
	                 'soukous' 'tresillo' 'trueAksak' 'tumbao' 'upbeats' ).
	
Transcript clear. rhythmList do: [ :i | i traceCr  ]. Transcript open.
]

{ #category : #responses }
Rhythm class >> random: aNumber [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r |
	r := Random new.
	^ (1 to: aNumber) collect: [ :i | (r next ) printShowingDecimalPlaces: 2].
]

{ #category : #compose }
Rhythm >> >> anArray [
	" same as and: anArray, but rewritten to test precedence improvement"
	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"
	
	^ (Sequencer with: self with: anArray with: #(0.125) with: 0 )
]

{ #category : #compose }
Rhythm >> and: anArray [
	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"
	^ (Sequencer with: self with: anArray with: #(0.125) with: 0 )
]

{ #category : #compose }
Rhythm >> and: anArrayOfNotes and: anArrayOfDurations [
	"returns Sequencer with default note 60nn and default durations 1/16th"

	^ Sequencer new gates: self ; notes: anArrayOfNotes; durations: anArrayOfDurations
]

{ #category : #converting }
Rhythm >> asDirtArray [ 
	"convert Rhythm into an Array"
	
	| array |
	array := Array new: self size.
	( 1 to: self size) do: [ :i | array at: i put: (self at: i)].
	^ array
]

{ #category : #'sequencer creation' }
Rhythm >> notes: anArray [

	^ Sequencer new gates: self; notes: anArray
]

{ #category : #accessing }
Rhythm >> offset: aNumber [
	"offset the rhythm by aNumber of 'steps' wrapping it around its size"
	| newRhythm |
	newRhythm := Rhythm new: self size.
	0 to: ((self size) - 1) do: [ :i | 
			newRhythm 
				at: ((i + aNumber) modulo: self size) 
				put: (self at: i + 1)].
	^ newRhythm

]

{ #category : #printing }
Rhythm >> printOn: aStream [

	aStream print: self asDirtArray 
]

{ #category : #random }
Rhythm >> randomInts: anArrayWithRangeAndMin [

	"return an array of self size with random integers with range [anArrayWithRangeAndMin at: 1 +  anArrayWithRangeAndMin at: 2]"

	| floatsArray result numberOfGates range min |
	range := anArrayWithRangeAndMin at: 1.
	min := anArrayWithRangeAndMin at: 2.
	numberOfGates := self gates.
	floatsArray := numberOfGates randoms * range + min.
	result := floatsArray collect: [ :i | i rounded ].
	^ Sequencer new gates: self; notes: result
]

{ #category : #random }
Rhythm >> randomNotesFrom: anArray [

	"return an array of self size of random notes from anArray"

	| numberOfGates result |
	numberOfGates := self gates.
	result := (1 to: numberOfGates) collect: [ :i | 
		          anArray at: (Random new nextInt: anArray size) ].
	^ Sequencer new notes: self; gates: result
]

{ #category : #random }
Rhythm >> randomNotesFrom: anArray octaves: aNumber [

	"return an array of self size of a random note from anArray + a random octave between 0 and aNumber"

	| numberOfGates result |
	numberOfGates := self gates.
	result := (1 to: numberOfGates) collect: [ :i | 
		          (anArray at: (Random new nextInteger: anArray size))
		          + ((Random new nextInteger: aNumber + 1) - 1 * 12) ].
	^ Sequencer new
		  notes: self;
		  gates: result
]
