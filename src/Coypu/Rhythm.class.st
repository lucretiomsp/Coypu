"
The Rhythm class contains an Array with allRhythmNames and convenience methods
"
Class {
	#name : 'Rhythm',
	#superclass : 'Object',
	#type : 'variable',
	#classInstVars : [
		'allRhythmNames'
	],
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'accessing' }
Rhythm class >> allRhythmNames [

	"return all the possible Rhythms obtainable sending messages to integers"

	| rhythmList |
	rhythmList := #( #adowa '#aksak #banda #bomba #bossa #breves  #semibreves #claveSon #downbeats #gahu #quavers' #semiquavers #rumba #shiko #sikyi #soukous #tresillo #trueAksak #tumbao #upbeats ).
	
^ rhythmList 
]

{ #category : 'accessing' }
Rhythm class >> list [

	"return all the possible Rhythms obtainable sending messages to integers"

	| rhythmList |
	rhythmList := #( 'adowa' 'aksak' 'banda' 'bomba' 'bossa' 'breves'
	                 'semibreves' 'claveSon' 'downbeats' 'gahu' 'ones'
	                 'quavers' 'semiquavers' 'rumba' 'shiko' 'sikyi'
	                 'soukous' 'tresillo' 'trueAksak' 'tumbao' 'upbeats' ).
	
Transcript clear. rhythmList do: [ :i | i traceCr  ]. Transcript open.
]

{ #category : 'responses' }
Rhythm class >> random: aNumber [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r |
	r := Random new.
	^ (1 to: aNumber) collect: [ :i | (r next ) printShowingDecimalPlaces: 2].
]

{ #category : 'compose' }
Rhythm >> and: anArray [
	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"
	^ (Sequencer with: self with: anArray with: #(0.125) with: 0 )
]

{ #category : 'compose' }
Rhythm >> and: anArrayOfNotes and: anArrayOfDurations [
	"returns Sequencer with default note 60nn and default durations 1/16th"

	^ Sequencer new gates: self ; notes: anArrayOfNotes; durations: anArrayOfDurations
]

{ #category : 'converting' }
Rhythm >> asDirtArray [ 
	"convert Rhythm into an Array"
	
	| array |
	array := Array new: self size.
	( 1 to: self size) do: [ :i | array at: i put: (self at: i)].
	^ array
]

{ #category : 'sequencer creation' }
Rhythm >> notes: anArray [

	^ Sequencer new
		  gates: self;
		  notes: anArray
]

{ #category : 'printing' }
Rhythm >> printOn: aStream [

	aStream print: self asDirtArray 
]

{ #category : 'random' }
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
