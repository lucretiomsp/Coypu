"
I decide how long notes last. A note is held until the next onset, up to the voice's limit (maxHold). Now and then, more often on strong beats, a note is held for the whole gap instead. The gate decides how much of each length actually sounds.
"
Class {
	#name : 'GenDurationPolicy',
	#superclass : 'Object',
	#instVars : [
		'longNoteProbability',
		'gate'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'durations' }
GenDurationPolicy >> durationsFor: aRhythm voice: aVoice meter: aMeter random: aRandom [
	"One duration in steps per onset of aRhythm."

	| onsets |
	onsets := aRhythm onsets.
	^ onsets withIndexCollect: [ :onset :index |
		  | gap |
		  gap := self gapAfter: index in: onsets length: aRhythm size.
		  aRandom next < (longNoteProbability * (aMeter strengthAt: onset))
			  ifTrue: [ gap ]
			  ifFalse: [ gap min: aVoice maxHold ] ]
]

{ #category : 'durations' }
GenDurationPolicy >> gapAfter: anIndex in: onsets length: aLength [
	"Steps until the next onset, wrapping around the loop."

	^ anIndex = onsets size
		  ifTrue: [ onsets first + aLength - onsets last ]
		  ifFalse: [ (onsets at: anIndex + 1) - (onsets at: anIndex) ]
]

{ #category : 'accessing' }
GenDurationPolicy >> gate [
	"How much of each length sounds, from 0 to 1."

	^ gate
]

{ #category : 'accessing' }
GenDurationPolicy >> gate: aNumber [

	gate := aNumber
]

{ #category : 'initialization' }
GenDurationPolicy >> initialize [

	super initialize.
	longNoteProbability := 0.2.
	gate := 0.9
]

{ #category : 'accessing' }
GenDurationPolicy >> longNoteProbability: aProbability [
	"Chance of a long note on a downbeat; weaker beats get proportionally less."

	longNoteProbability := aProbability
]
