"
I am one playable pitch: a MIDI note number (fractional for quarter tones and just intonation) and the absolute scale step it comes from, so the melody brain can tell a step from a leap in any scale.

When a scale has a different descending form, a pitch belongs to the ascending form, to the descending form, or to both.

I am a Value Object.

Examples:
	(GenPitch midi: 61 step: 1) name.
	GenPitch nameOfMidi: 63.86.
They answer 'C#4' and 'E4-14c'.
"
Class {
	#name : 'GenPitch',
	#superclass : 'Object',
	#instVars : [
		'midi',
		'step',
		'ascending',
		'descending'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'naming' }
GenPitch class >> centsSuffixOf: aNumber [
	"Empty on the twelve-tone grid, otherwise the deviation such as +50c or -14c."

	| cents |
	cents := (aNumber * 100) rounded.
	cents = 0 ifTrue: [ ^ '' ].
	^ (cents > 0
		   ifTrue: [ '+' ]
		   ifFalse: [ '' ]) , cents printString , 'c'
]

{ #category : 'instance creation' }
GenPitch class >> midi: aNumber step: anInteger [

	^ self
		  midi: aNumber
		  step: anInteger
		  ascending: true
		  descending: true
]

{ #category : 'instance creation' }
GenPitch class >> midi: aNumber step: anInteger ascending: aBoolean descending: anotherBoolean [

	^ self new
		  setMidi: aNumber
		  step: anInteger
		  ascending: aBoolean
		  descending: anotherBoolean;
		  yourself
]

{ #category : 'naming' }
GenPitch class >> nameOfMidi: aNumber [
	"Nearest twelve-tone name with its octave (60 is C4), plus the deviation in cents."

	| nearest |
	nearest := aNumber rounded.
	^ (self pitchClassNames at: nearest \\ 12 + 1) , (nearest // 12 - 1) printString
	  , (self centsSuffixOf: aNumber - nearest)
]

{ #category : 'naming' }
GenPitch class >> nameOfPitchClass: aNumber [
	"Like nameOfMidi: without the octave."

	| nearest |
	nearest := aNumber rounded.
	^ (self pitchClassNames at: nearest \\ 12 + 1) , (self centsSuffixOf: aNumber - nearest)
]

{ #category : 'naming' }
GenPitch class >> pitchClassNames [

	^ #( 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' )
]

{ #category : 'comparing' }
GenPitch >> = anObject [

	^ self class = anObject class and: [
		  midi = anObject midi and: [ step = anObject step ] ]
]

{ #category : 'comparing' }
GenPitch >> hash [

	^ midi hash bitXor: step hash
]

{ #category : 'testing' }
GenPitch >> isAscendingForm [

	^ ascending
]

{ #category : 'testing' }
GenPitch >> isDescendingForm [

	^ descending
]

{ #category : 'testing' }
GenPitch >> isSamePitchClassAs: aPitch [

	^ self pitchClassCents = aPitch pitchClassCents
]

{ #category : 'accessing' }
GenPitch >> midi [

	^ midi
]

{ #category : 'accessing' }
GenPitch >> name [

	^ self class nameOfMidi: midi
]

{ #category : 'accessing' }
GenPitch >> pitchClassCents [
	"Pitch class in whole cents, 0 to 1199."

	^ (midi * 100) rounded \\ 1200
]

{ #category : 'printing' }
GenPitch >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : 'initialization' }
GenPitch >> setMidi: aNumber step: anInteger ascending: aBoolean descending: anotherBoolean [

	midi := aNumber.
	step := anInteger.
	ascending := aBoolean.
	descending := anotherBoolean
]

{ #category : 'accessing' }
GenPitch >> step [
	"Absolute, 0-based scale step."

	^ step
]
