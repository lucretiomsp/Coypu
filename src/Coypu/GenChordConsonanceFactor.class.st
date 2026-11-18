"
Consonance with the chord, shaped by beat strength.

A pitch is scored against every tone of the chord with the consonance curve (peaks at pure intervals, so quarter tones and just intonation work too) and chord tones get a bonus. The result is raised to a power that grows with the beat strength: on strong beats consonance counts more, off-beats let passing notes through.

Lanes of different lengths: when a step is heard over several chords, it is scored on each and the geometric mean is kept, so one bad clash pulls the score down.
"
Class {
	#name : 'GenChordConsonanceFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'chordToneBonus',
		'weakBeatExponent',
		'strongBeatExponent'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenChordConsonanceFactor >> chordToneBonus: aNumber [

	chordToneBonus := aNumber
]

{ #category : 'scoring' }
GenChordConsonanceFactor >> exponentFor: aBeatStrength [

	^ weakBeatExponent + (strongBeatExponent - weakBeatExponent * aBeatStrength)
]

{ #category : 'scoring' }
GenChordConsonanceFactor >> fitOf: aPitch on: aChord using: aConsonance [

	| fit |
	fit := self geometricMeanOf: (aChord tones collect: [ :each |
			        aConsonance ofInterval: aPitch midi - each ]).
	^ (aChord includesPitch: aPitch)
		  ifTrue: [ fit * chordToneBonus ]
		  ifFalse: [ fit ]
]

{ #category : 'initialization' }
GenChordConsonanceFactor >> initialize [

	super initialize.
	chordToneBonus := 1.5.
	weakBeatExponent := 0.75.
	strongBeatExponent := 3.0
]

{ #category : 'accessing' }
GenChordConsonanceFactor >> strongBeatExponent: aNumber [

	strongBeatExponent := aNumber
]

{ #category : 'accessing' }
GenChordConsonanceFactor >> weakBeatExponent: aNumber [

	weakBeatExponent := aNumber
]

{ #category : 'scoring' }
GenChordConsonanceFactor >> weightOf: aPitch in: aContext [

	| fits |
	aContext chords isEmpty ifTrue: [ ^ 1 ].
	fits := aContext chords collect: [ :each |
		        self fitOf: aPitch on: each using: aContext consonance ].
	^ (self geometricMeanOf: fits) raisedTo: (self exponentFor: aContext beatStrength)
]
