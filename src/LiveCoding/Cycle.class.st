"
Cycle represents a convenience class to hold information about cyclep playing, inspired by Tidal Cycles
"
Class {
	#name : #Cycle,
	#superclass : #Object,
	#classVars : [
		'duration'
	],
	#category : #'LiveCoding-Sequencers'
}

{ #category : #accessing }
Cycle class >> duration [

	^ duration 
]

{ #category : #initialization }
Cycle class >> initialize [


	"default speed for a Cycle inside the LiveCoding Package for Pharo is 132 bpm"
	self setDuration: 60 / 132 * 4
]

{ #category : #accessing }
Cycle class >> setDuration: aDurationInseconds [

duration := aDurationInseconds 
]

{ #category : #initialization }
Cycle >> initialize [

	super initialize.
	self setDuration: 60 / 132 * 4
]

{ #category : #initialization }
Cycle >> setDuration: aDurationInSeconds [

duration := aDurationInSeconds 
]
