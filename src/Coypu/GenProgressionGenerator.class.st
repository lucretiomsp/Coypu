"
I write the harmony, one chord per bar.

The progression starts on the tonic. Each next chord is drawn with a weight: the root movement (up a fourth or a fifth is most likely, then bVII, bVI, vi, bIII and so on) times the chord's strength, so chords with a weak third or fifth are rarer.

A four-bar phrase repeats to fill longer patterns and, half of the time, the very last bar changes into a turnaround that leads back to the top.

Example:
	(GenProgressionGenerator
		context: (GenScaleContext scaleNamed: #major root: 0)
		random: Random new) generate: 8.
"
Class {
	#name : 'GenProgressionGenerator',
	#superclass : 'Object',
	#instVars : [
		'context',
		'random',
		'phraseLength',
		'turnaroundProbability',
		'movementWeights'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenProgressionGenerator class >> context: aScaleContext random: aRandom [

	^ self new
		  setContext: aScaleContext random: aRandom;
		  yourself
]

{ #category : 'defaults' }
GenProgressionGenerator class >> defaultMovementWeights [
	"Weight of a root movement, by interval above the current root:
	unison, b2, 2, b3, 3, 4, tritone, 5, b6, 6, b7, 7."

	^ #( 0.05 0.15 0.3 0.4 0.25 1.0 0.1 0.9 0.5 0.45 0.6 0.15 )
]

{ #category : 'private' }
GenProgressionGenerator >> chooser [

	^ GenWeightedChooser random: random
]

{ #category : 'generating' }
GenProgressionGenerator >> generate: aNumberOfBars [

	| phrase bars |
	aNumberOfBars < 1 ifTrue: [ ^ self error: 'A progression needs at least one bar' ].
	phrase := self phraseOfLength: (aNumberOfBars min: phraseLength).
	bars := (1 to: aNumberOfBars) collect: [ :bar | phrase at: bar - 1 \\ phrase size + 1 ].
	(aNumberOfBars > phraseLength and: [ random next < turnaroundProbability ]) ifTrue: [
		bars at: aNumberOfBars put: (self turnaroundAfter: (bars at: aNumberOfBars - 1) replacing: bars last) ].
	^ GenProgression withAll: bars
]

{ #category : 'initialization' }
GenProgressionGenerator >> initialize [

	super initialize.
	phraseLength := 4.
	turnaroundProbability := 0.5.
	movementWeights := self class defaultMovementWeights
]

{ #category : 'weights' }
GenProgressionGenerator >> movementWeightAt: aSemitone [

	^ movementWeights at: aSemitone \\ 12 + 1
]

{ #category : 'weights' }
GenProgressionGenerator >> movementWeightFrom: aChord to: anotherChord [
	"Interpolates between semitones, so quarter tones and just intervals get sensible weights."

	| interval lower fraction |
	interval := anotherChord root - aChord root \\ 12.
	lower := interval floor.
	fraction := interval - lower.
	^ (self movementWeightAt: lower) * (1 - fraction) + ((self movementWeightAt: lower + 1) * fraction)
]

{ #category : 'generating' }
GenProgressionGenerator >> nextChordAfter: aChord [

	| candidates |
	candidates := context chords.
	^ self chooser
		  choose: candidates
		  weights: (candidates collect: [ :each | self weightFrom: aChord to: each ])
]

{ #category : 'accessing' }
GenProgressionGenerator >> phraseLength: anInteger [

	phraseLength := anInteger
]

{ #category : 'generating' }
GenProgressionGenerator >> phraseOfLength: anInteger [

	| phrase |
	phrase := OrderedCollection with: context tonicChord.
	[ phrase size < anInteger ] whileTrue: [ phrase add: (self nextChordAfter: phrase last) ].
	^ phrase asArray
]

{ #category : 'initialization' }
GenProgressionGenerator >> setContext: aScaleContext random: aRandom [

	context := aScaleContext.
	random := aRandom
]

{ #category : 'generating' }
GenProgressionGenerator >> turnaroundAfter: aChord replacing: aLastChord [
	"A new last bar, weighted by the move into it and by its move back to the tonic at the top of the loop."

	| tonic candidates |
	tonic := context tonicChord.
	candidates := context chords copyWithout: aLastChord.
	candidates isEmpty ifTrue: [ ^ aLastChord ].
	^ self chooser
		  choose: candidates
		  weights: (candidates collect: [ :each |
				   (self weightFrom: aChord to: each) * (self movementWeightFrom: each to: tonic) ])
]

{ #category : 'accessing' }
GenProgressionGenerator >> turnaroundProbability: aProbability [

	turnaroundProbability := aProbability
]

{ #category : 'weights' }
GenProgressionGenerator >> weightFrom: aChord to: aCandidate [

	^ (self movementWeightFrom: aChord to: aCandidate) * aCandidate strength
]
