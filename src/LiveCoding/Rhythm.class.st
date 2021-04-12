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

{ #category : #'as yet unclassified' }
Rhythm class >> downbeat: aNumber [
"creates an Array of aNumber of values (0,1) with 1 to the position corresponding to a 4/4 beat"
	^ (1 to: aNumber) collect: [ :i | (((i rem: 4) = 1)) asBit ].
]

{ #category : #'as yet unclassified' }
Rhythm class >> quavers: aNumber [
"creates an Array of aNumber of values (0,1) with 1 to the position corresponding to a rhtyhm of quavers (downbeat + upbeat)"
	^ (1 to: aNumber) collect: [ :i | ((((i rem: 4) = 1)) | (((i rem: 4) = 3)) ) asBit ].
]

{ #category : #responses }
Rhythm class >> random: aNumber [
"generates an Array of random values in the range (0,1) of size: aNumber, whith only 2 decimal places"
	| r |
	r := Random new.
	^ (1 to: aNumber) collect: [ :i | (r next ) printShowingDecimalPlaces: 2].
]

{ #category : #'as yet unclassified' }
Rhythm class >> random: aNumber div: aDivision [
"return an array of aNumber random values in the range of 0,1 , with a subdivision of 1/aDivision steps with 2 decimal places"
	| r array|
	r := Random new.
	array := ( 0 to: 1 by: (( 1/ aDivision) asFloat)  ) asArray.
	^ (1 to: aNumber) collect: [ :i | (array at: (r nextInt: (array size))) printShowingDecimalPlaces: 2 ].
]

{ #category : #'as yet unclassified' }
Rhythm class >> semiquavers: aNumber [
"answer an Array of 1 with aNumber size"
^ Array new: aNumber withAll: 1.
]

{ #category : #'as yet unclassified' }
Rhythm class >> upbeat: aNumber [
"creates an Array of aNumber of values (0,1) with 1 to the position corresponding to a 4/4 upbeat rhythm"
	^ (1 to: aNumber) collect: [ :i | (((i rem: 4) = 3)) asBit ].
]
