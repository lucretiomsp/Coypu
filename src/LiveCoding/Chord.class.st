Class {
	#name : #Chord,
	#superclass : #Scale,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #creating }
Chord class >> major [ 
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5).


]

{ #category : #creating }
Chord class >> major7 [
	| notes |
	notes := Scale major.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7).


]

{ #category : #creating }
Chord class >> minor [ 
	| notes |
	notes := Scale minor.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5).


]

{ #category : #creating }
Chord class >> minor7 [
	| notes |
	notes := Scale minor.
^ self with: (notes at: 1) with: (notes at: 3) with: (notes at: 5) with: (notes at: 7)


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
