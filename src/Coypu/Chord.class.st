"
""Creates a Chord as an array of MIDI note numbers""
"
Class {
	#name : #Chord,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'list',
		'ChordLists'
	],
	#classInstVars : [
		'ChordLists'
	],
	#category : #'Coypu-ScalesAndChords'
}

{ #category : #'as yet unclassified' }
Chord class >> list [

	"retrurn the list of all Chords"
	| list | 
list := Dictionary new.
list at: #major put: #(0 4 7); at: #minor put: #(0 3 7); at: #aug put: #( 0 4 8); at: #six put: #( 0 4 7 9); at: #six9 put: #( 0 4 7 9 14 ); at: #major7 put: #( 0 4 7 11); at: #major9 put: #( 0 4 7 11 14); at: #add9 put: #( 0 4 7 14); at: #major11 put: #( 0 4 7 11 14 17); at: #add11 put: #( 0 4 7 17); at: #major13 put: #( 0 4 7 11 14 17 21); at: #minor7 put: #( 0 3 7 10) ; at: #diminished put: #( 0 3 6) ; at: #minorsharp5 put: #( 0 3 8) ; at: #minor5 put: #( 0 3 7 9) ; at: #minoraixnine put: #( 0 3 7 9 14) ; at: #minor7flat5 put: #( 0 3 6 10) ; at: #minor7sharp5 put: #( 0 3 8 10); at: #diminished7 put: #( 0 3 6 9); at: #minor9 put: #( 0 3 7 10 14); at: #minor11 put: #( 0 3 7 10 14 17); at: #minor13 put: #( 0 3 7 10 14 17 21); at: #minorMajor7 put: #( 0 3 7 11); at: #five put: #( 0 5); at: #sus2 put: #( 0 2 7 ); at: #sus4 put: #( 0 5 7 );  at: #sevensus2 put: #( 0 2 7 10 );  at: #sevensus4 put: #( 0 5 7 10 );  at: #nineSus2 put: #( 0 2 7 10 14 );   at: #ninesus4 put: #( 0 5 7 10 14 );at: #sevenflat10 put: #( 0 4 7 10 15); at: #ninesharp5 put: #( 0 1 13); at: #minor9sharp5 put: #( 0 1 14) ; at: #sevensharp5flat9 put: #( 0 4 8 10 13) ; at: #minor7sharp5flat9  put: #( 0 3 8 10 13) ; at: #elevensharp put: #( 0 4 7 10 14 18)  ;at: #minor11sharp put: #( 0 3 7 10 14 18); at: #dom7 put: #(0 4 7 10); at: #dom7 put: #(0 4 7 10) ; at: #dom9 put: #(0 4 7 14) ; at: #dom11 put: #(0 4 7 17) ;at: #dom13 put: #(0 4 7 21) ; at: #sevenflat5 put: #(0 4 6 10) ; at: #sevensharp5 put: #(0 4 8 10) ; at: #sevenflat9 put: #(0 4 7 10 13) ; at: #nine put: #(0 4 7 10 14) ; at: #eleven put: #(0 4 7 10 14 17); at: #thirteen put: #(0 4 7 10 14 17 21).








	^ list
]

{ #category : #creating }
Chord class >> major [ 
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5).


]

{ #category : #'as yet unclassified' }
Chord class >> major11 [
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7) with: (notes at: 9) with: (notes at: 10).


]

{ #category : #'as yet unclassified' }
Chord class >> major13 [

	| notes chord|
	notes := Scale major.
	chord := self new: 7.
	chord at: 1 put: (notes at: 1); at: 2 put: (notes at: 3); at: 3 put: (notes at: 5); at: 4 put: (notes at: 7); at: 5 put: (notes at: 9); at: 6 put: (notes at: 10); at: 7 put: (notes at: 11).
^ chord



]

{ #category : #creating }
Chord class >> major7 [
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7).


]

{ #category : #'as yet unclassified' }
Chord class >> major9 [
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7) with: (notes at: 9).


]

{ #category : #creating }
Chord class >> minor [ 
	| notes |
	notes := Scale minor.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5).


]

{ #category : #'as yet unclassified' }
Chord class >> minor11 [

	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7) with: (notes at: 9) with: (notes at: 10).


]

{ #category : #'as yet unclassified' }
Chord class >> minor13 [

	| notes chord|
	notes := Scale minor.
	chord := self new: 7.
	chord at: 1 put: (notes at: 1); at: 2 put: (notes at: 3); at: 3 put: (notes at: 5); at: 4 put: (notes at: 7); at: 5 put: (notes at: 9); at: 6 put: (notes at: 10); at: 7 put: (notes at: 11).
^ chord



]

{ #category : #creating }
Chord class >> minor7 [
	| notes |
	notes := Scale minor.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7)


]

{ #category : #'as yet unclassified' }
Chord class >> minor9 [

	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7) with: (notes at: 9).


]

{ #category : #'as yet unclassified' }
Chord class >> traceList [

"open a Transcript and show a list of all available chords".
Transcript clear.
self list keysDo:  [ :i | i traceCr ].
Transcript open.
]

{ #category : #initialization }
Chord >> initialize [ 
super initialize .


]

{ #category : #generating }
Chord >> randomize: aNumber [
	
	| r s|
	r := Random new.
	s := (self size) - 1.
	
	^ (1 to: aNumber) collect: [ :i | self at: (( (r next) * s) rounded) + 1 ].
]

{ #category : #generating }
Chord >> randomize: aNumber range: aRange [
	
	| r  s|
	r := Random new.
	s := self size.
	

	
	^ (1 to: aNumber) collect: [ :i | (self at: (r nextInt: s)) + ((r nextInt: aRange) * ((r nextInt: 2) -2) )].
]

{ #category : #generating }
Chord >> randomize: aNumber range: aRange root: aRoot [
	
	| r  s|
	r := Random new.
	s := self size.
	

	
	^ (1 to: aNumber) collect: [ :i | ((self at: (r nextInt: s)) + ((r nextInt: aRange) * ((r nextInt: 2) -2) )) + aRoot].
]

{ #category : #generating }
Chord >> randomize: aNumber range: aRange withRoot: aRoot [
	
	| r  s|
	r := Random new.
	s := self size.
	

	
	^ (1 to: aNumber) collect: [ :i | ((self at: (r nextInt: s)) + ((r nextInt: aRange) * ((r nextInt: 2) -2) )) + aRoot].
]

{ #category : #generating }
Chord >> randomize: aNumber withRoot: aRoot [
	
	| r s|
	r := Random new.
	s := (self size) - 1.
	
	^ (1 to: aNumber) collect: [ :i | (self at: (( (r next) * s) rounded) + 1) + aRoot ].
]

{ #category : #accessing }
Chord >> root: aNumber [
" return a Chord with aNumber nn as root"
^ (self + aNumber).
]
