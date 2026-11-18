"
I know how strong every step of a bar is.

A bar is split into metric levels, halving while it can and then splitting by threes or by its smallest factor: 16 steps give the levels 16 8 4 2 1, 12 steps give 12 6 3 1, 13 steps give 13 1. The downbeat is 1.0 and every level down is weaker.

Steps are 1-based and wrap around the bar.

Example:
	(GenMeter stepsPerBar: 16) strengthAt: 9.
The half bar answers 0.8.
"
Class {
	#name : 'GenMeter',
	#superclass : 'Object',
	#instVars : [
		'stepsPerBar',
		'levels'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenMeter class >> stepsPerBar: anInteger [

	anInteger < 1 ifTrue: [ ^ self error: 'A bar needs at least one step' ].
	^ self new
		  setStepsPerBar: anInteger;
		  yourself
]

{ #category : 'accessing' }
GenMeter >> barOfStep: aStep [
	"1-based bar of a 1-based step."

	^ aStep - 1 // stepsPerBar + 1
]

{ #category : 'testing' }
GenMeter >> isDownbeat: aStep [

	^ (self positionOf: aStep) = 0
]

{ #category : 'accessing' }
GenMeter >> levels [

	^ levels
]

{ #category : 'private' }
GenMeter >> levelsFor: anInteger [

	| size result |
	result := OrderedCollection with: anInteger.
	size := anInteger.
	[ size > 1 ] whileTrue: [
		size := size // (self smallestDivisorOf: size).
		result add: size ].
	^ result asArray
]

{ #category : 'private' }
GenMeter >> positionOf: aStep [
	"0-based position inside the bar."

	^ aStep - 1 \\ stepsPerBar
]

{ #category : 'initialization' }
GenMeter >> setStepsPerBar: anInteger [

	stepsPerBar := anInteger.
	levels := self levelsFor: anInteger
]

{ #category : 'private' }
GenMeter >> smallestDivisorOf: anInteger [

	^ (2 to: anInteger) detect: [ :each | anInteger \\ each = 0 ]
]

{ #category : 'accessing' }
GenMeter >> stepsPerBar [

	^ stepsPerBar
]

{ #category : 'accessing' }
GenMeter >> strengthAt: aStep [
	"1.0 on the downbeat, then one notch weaker for every metric level."

	| position level |
	position := self positionOf: aStep.
	level := levels findFirst: [ :each | position \\ each = 0 ].
	^ levels size - level + 1 / levels size asFloat
]
