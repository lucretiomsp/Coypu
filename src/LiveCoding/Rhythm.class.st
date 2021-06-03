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
	#category : #LiveCoding
}

{ #category : #responses }
Rhythm class >> random: aNumber [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r |
	r := Random new.
	^ (1 to: aNumber) collect: [ :i | (r next ) printShowingDecimalPlaces: 2].
]

{ #category : #'as yet unclassified' }
Rhythm >> randomInts: aNumber [
"return an array of self size with random integers with range [0, aNumber]"
| floatsArray result numberOfGates|
numberOfGates  := self gates.
floatsArray := (numberOfGates  randoms) * aNumber.
result := floatsArray collect: [ :i | i rounded ].
^ Sequencer with: self with: result
]

{ #category : #'as yet unclassified' }
Rhythm >> randomNotesFrom: anArray [
"return an array of self size of random notes from anArray"
| numberOfGates result |
numberOfGates := self gates.
result := (1 to: numberOfGates ) collect: [ :i | anArray at: (Random new nextInt: (anArray size)) ].
^ Sequencer with: self with: result
]

{ #category : #'as yet unclassified' }
Rhythm >> randomNotesFrom: anArray octaves: aNumber [
"return an array of self size of a random note from anArray + a random octave between 0 and aNumber"
| numberOfGates result |
numberOfGates := self gates.
result := (1 to: numberOfGates) collect: [ :i | (anArray at: (Random new nextInt: (anArray size))) + (((Random new nextInt: (aNumber + 1)) -1) * 12).].
^ Sequencer with: self with: result
]

{ #category : #'as yet unclassified' }
Rhythm >> randoms [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r numberOfGates values |
	numberOfGates := self gates.
	r := Random new.
	values := (1 to: numberOfGates) collect: [ :i | ((r next ) printShowingDecimalPlaces: 2) asNumber].
	^ Sequencer  with: self with: values.
	
	
]
