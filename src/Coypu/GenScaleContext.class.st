"
I am a scale placed on a root: the harmonic world of a piece. I know the tonic, the chord on every degree, which scale pitches fall in a register and how to name them.

The root is a pitch class from 0 (C) to 11 (B). The tonic is the root, except in just intonation scales: there it is the most consonant degree, judged by its own triad and by how the rest of the scale sounds above it. In a Partch utonality that is not the root.

Examples:
	| context |
	context := GenScaleContext scaleNamed: #dorian root: 2.
	context tonicChord.
	context pitchesFrom: 50 to: 62.
	GenScaleContext random: Random new.
"
Class {
	#name : 'GenScaleContext',
	#superclass : 'Object',
	#instVars : [
		'scale',
		'root',
		'tonicDegree',
		'consonance',
		'chordBuilder',
		'chords'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenScaleContext class >> random: aRandom [

	^ self random: aRandom consonance: GenConsonance new
]

{ #category : 'instance creation' }
GenScaleContext class >> random: aRandom consonance: aConsonance [
	"A random scale of the library on a random root."

	^ self
		  scale: (GenScaleLibrary default randomScale: aRandom)
		  root: (aRandom nextInteger: 12) - 1
		  consonance: aConsonance
]

{ #category : 'instance creation' }
GenScaleContext class >> scale: aScale root: anInteger [

	^ self scale: aScale root: anInteger consonance: GenConsonance new
]

{ #category : 'instance creation' }
GenScaleContext class >> scale: aScale root: anInteger consonance: aConsonance [

	^ self new
		  setScale: aScale root: anInteger consonance: aConsonance;
		  yourself
]

{ #category : 'instance creation' }
GenScaleContext class >> scaleNamed: aSymbol root: anInteger [

	^ self scale: (GenScaleLibrary default at: aSymbol) root: anInteger
]

{ #category : 'private' }
GenScaleContext >> addPitchesAtStep: aStep to: aCollection [

	| up down |
	up := root + (scale semitonesAtStep: aStep).
	down := root + (scale descendingSemitonesAtStep: aStep).
	up = down ifTrue: [ ^ aCollection add: (GenPitch midi: up step: aStep) ].
	aCollection
		add: (GenPitch midi: up step: aStep ascending: true descending: false);
		add: (GenPitch midi: down step: aStep ascending: false descending: true)
]

{ #category : 'accessing' }
GenScaleContext >> chordBuilder [

	^ chordBuilder
]

{ #category : 'harmony' }
GenScaleContext >> chordOnDegree: aDegree [

	^ self chords at: aDegree
]

{ #category : 'harmony' }
GenScaleContext >> chords [
	"One chord per scale degree, built once."

	^ chords ifNil: [
		  chords := (1 to: scale size) collect: [ :degree |
			            chordBuilder buildOnDegree: degree in: self ] ]
]

{ #category : 'accessing' }
GenScaleContext >> consonance [

	^ consonance
]

{ #category : 'harmony' }
GenScaleContext >> findTonicDegree [

	scale isJustIntonation ifFalse: [ ^ 1 ].
	^ (1 to: scale size) detectMax: [ :degree |
		  (self chordOnDegree: degree) strength * (scale consonanceOfDegree: degree using: consonance) ]
]

{ #category : 'naming' }
GenScaleContext >> nameOf: aMidi [

	^ GenPitch nameOfMidi: aMidi
]

{ #category : 'harmony' }
GenScaleContext >> pitchClassOfDegree: aDegree [
	"Absolute pitch class of a 1-based degree, in semitones from 0 to 12."

	^ root + (scale semitonesAtStep: aDegree - 1) \\ 12
]

{ #category : 'pitches' }
GenScaleContext >> pitchesFrom: lowMidi to: highMidi [
	"Every scale pitch between lowMidi and highMidi, sorted. A scale with a descending form gives both forms; each pitch knows the direction it may be used in."

	| pitches firstStep lastStep |
	pitches := OrderedCollection new.
	firstStep := (lowMidi - root / 12) floor - 1 * scale size.
	lastStep := (highMidi - root / 12) ceiling + 1 * scale size.
	firstStep to: lastStep do: [ :step | self addPitchesAtStep: step to: pitches ].
	^ (pitches select: [ :each | each midi between: lowMidi and: highMidi ]) asArray
		  sort: [ :a :b | a midi <= b midi ]
]

{ #category : 'printing' }
GenScaleContext >> printOn: aStream [

	aStream
		nextPutAll: self rootName;
		space;
		nextPutAll: scale name
]

{ #category : 'accessing' }
GenScaleContext >> root [

	^ root
]

{ #category : 'naming' }
GenScaleContext >> rootName [

	^ GenPitch nameOfPitchClass: root
]

{ #category : 'accessing' }
GenScaleContext >> scale [

	^ scale
]

{ #category : 'initialization' }
GenScaleContext >> setScale: aScale root: anInteger consonance: aConsonance [

	scale := aScale.
	root := anInteger.
	consonance := aConsonance.
	chordBuilder := GenChordBuilder forScale: aScale.
	tonicDegree := self findTonicDegree
]

{ #category : 'harmony' }
GenScaleContext >> tonicChord [

	^ self chordOnDegree: tonicDegree
]

{ #category : 'accessing' }
GenScaleContext >> tonicDegree [

	^ tonicDegree
]
