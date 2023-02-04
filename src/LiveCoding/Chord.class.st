"
""Creates a Chord as an array of MIDI note numbers""
"
Class {
	#name : #Chord,
	#superclass : #Array,
	#type : #variable,
	#category : #'LiveCoding-ScalesAndChords'
}

{ #category : #'as yet unclassified' }
Chord class >> chordLists [

	"retrurn the list of all Chords"

	"ChordLists ifNil: [ "

	ChordLists := Dictionary new.
	ChordLists
		at: #maj put: #( 0 4 7 );
		at: #maj7 put: #( 0 4 7 11 );
		at: #min put: #( 0 3 7 );
		at: #min7 put: #( 0 3 7 10 ).

	^ ChordLists
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
