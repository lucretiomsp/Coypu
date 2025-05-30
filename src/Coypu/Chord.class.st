"
""Creates a Chord as an array of MIDI note numbers""
"
Class {
	#name : 'Chord',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'list',
		'ChordLists'
	],
	#classInstVars : [
		'ChordLists'
	],
	#category : 'Coypu-ScalesAndChords',
	#package : 'Coypu',
	#tag : 'ScalesAndChords'
}

{ #category : 'accessing' }
Chord class >> list [
	"retrurn the list of all Chords"

	| list |
	list := Dictionary new.
	list
		at: #major put: #( 0 4 7 );
		at: #maj put: #( 0 4 7 );
		"alias for major"at: #minor put: #( 0 3 7 );
		at: #min put: #( 0 3 7 );
		"alias for minor"at: #aug put: #( 0 4 8 );
		at: #six put: #( 0 4 7 9 );
		at: #six9 put: #( 0 4 7 9 14 );
		at: #major7 put: #( 0 4 7 11 );
		at: #maj7 put: #( 0 4 7 11 );
		at: #major9 put: #( 0 4 7 11 14 );
		at: #maj9 put: #( 0 4 7 11 14 );
		at: #add9 put: #( 0 4 7 14 );
		at: #major11 put: #( 0 4 7 11 14 17 );
		at: #maj11 put: #( 0 4 7 11 14 17 );
		at: #add11 put: #( 0 4 7 17 );
		at: #major13 put: #( 0 4 7 11 14 17 21 );
		at: #maj13 put: #( 0 4 7 11 14 17 21 );
		at: #minor7 put: #( 0 3 7 10 );
		at: #min7 put: #( 0 3 7 10 );
		at: #diminished put: #( 0 3 6 );
		at: #minorsharp5 put: #( 0 3 8 );
		at: #minor5 put: #( 0 3 7 9 );
		at: #min5 put: #( 0 3 7 9 );
		at: #minoraixnine put: #( 0 3 7 9 14 );
		at: #minor7flat5 put: #( 0 3 6 10 );
		at: #min7flat5 put: #( 0 3 6 10 );
		at: #minor7sharp5 put: #( 0 3 8 10 );
		at: #min7sharp5 put: #( 0 3 8 10 );
		at: #diminished7 put: #( 0 3 6 9 );
		at: #minor9 put: #( 0 3 7 10 14 );
		at: #minor11 put: #( 0 3 7 10 14 17 );
		at: #min11 put: #( 0 3 7 10 14 17 );
		at: #minor13 put: #( 0 3 7 10 14 17 21 );
		at: #min13 put: #( 0 3 7 10 14 17 21 );
		at: #minorMajor7 put: #( 0 3 7 11 );
		at: #minMaj7 put: #( 0 3 7 11 );
		at: #five put: #( 0 5 );
		at: #sus2 put: #( 0 2 7 );
		at: #sus4 put: #( 0 5 7 );
		at: #sevensus2 put: #( 0 2 7 10 );
		at: #sevensus4 put: #( 0 5 7 10 );
		at: #nineSus2 put: #( 0 2 7 10 14 );
		at: #ninesus4 put: #( 0 5 7 10 14 );
		at: #sevenflat10 put: #( 0 4 7 10 15 );
		at: #ninesharp5 put: #( 0 1 13 );
		at: #minor9sharp5 put: #( 0 1 14 );
		at: #min9sharp5 put: #( 0 1 14 );
		at: #sevensharp5flat9 put: #( 0 4 8 10 13 );
		at: #minor7sharp5flat9 put: #( 0 3 8 10 13 );
		at: #min7sharp5flat9 put: #( 0 3 8 10 13 );
		at: #elevensharp put: #( 0 4 7 10 14 18 );
		at: #minor11sharp put: #( 0 3 7 10 14 18 );
		at: #min11sharp put: #( 0 3 7 10 14 18 );
		at: #dom7 put: #( 0 4 7 10 );
		at: #dom7 put: #( 0 4 7 10 );
		at: #dom9 put: #( 0 4 7 14 );
		at: #dom11 put: #( 0 4 7 17 );
		at: #dom13 put: #( 0 4 7 21 );
		at: #sevenflat5 put: #( 0 4 6 10 );
		at: #sevensharp5 put: #( 0 4 8 10 );
		at: #sevenflat9 put: #( 0 4 7 10 13 );
		at: #nine put: #( 0 4 7 10 14 );
		at: #eleven put: #( 0 4 7 10 14 17 );
		at: #thirteen put: #( 0 4 7 10 14 17 21 ).








	^ list
]

{ #category : 'printing' }
Chord class >> traceList [

"open a Transcript and show a list of all available chords".
Transcript clear.
self list keysDo:  [ :i | i traceCr ].
Transcript open.
]

{ #category : 'generating' }
Chord >> randomize: aNumber [
	
	| r s|
	r := Random new.
	s := (self size) - 1.
	
	^ (1 to: aNumber) collect: [ :i | self at: (( (r next) * s) rounded) + 1 ].
]

{ #category : 'generating' }
Chord >> randomize: aNumber range: aRange [
	
	| r  s|
	r := Random new.
	s := self size.
	
	^ (1 to: aNumber) collect: [ :i | (self at: (r nextInteger: s)) + ((r nextInteger: aRange) * ((r nextInteger: 2) -2) )].
]

{ #category : 'generating' }
Chord >> randomize: aNumber range: aRange root: aRoot [
	
	| r  s|
	r := Random new.
	s := self size.
	^ (1 to: aNumber) collect: [ :i | ((self at: (r nextInteger: s)) + ((r nextInteger: aRange) * ((r nextInteger: 2) -2) )) + aRoot].
]

{ #category : 'generating' }
Chord >> randomize: aNumber range: aRange withRoot: aRoot [
	
	| r  s|
	r := Random new.
	s := self size.

	^ (1 to: aNumber) collect: [ :i | ((self at: (r nextInteger: s)) + ((r nextInteger: aRange) * ((r nextInteger: 2) -2) )) + aRoot].
]

{ #category : 'generating' }
Chord >> randomize: aNumber withRoot: aRoot [
	
	| r s|
	r := Random new.
	s := (self size) - 1.
	
	^ (1 to: aNumber) collect: [ :i | (self at: (( (r next) * s) rounded) + 1) + aRoot ].
]

{ #category : 'accessing' }
Chord >> root: aNumber [
	"return a Chord with aNumber nn as root"

	^ (self + aNumber)
]
