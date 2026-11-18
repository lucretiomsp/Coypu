"
I am the front door of the engine (Facade with a fluent, Builder-like configuration).

compose runs the pipeline in the order of the theory: scale and root, harmony (one chord per bar), a rhythm for every lane, then pitches lane by lane from the bass up, each voice scored against the lanes below it, and finally durations.

Every random choice comes from one generator: the same seed gives the same piece.

Examples:
	GenComposer new compose.
	GenComposer new
		seed: 42;
		scale: #dorian root: 2;
		bars: 8;
		length: 13 for: #lead;
		worldRhythmAmount: 0.7;
		compose.
"
Class {
	#name : 'GenComposer',
	#superclass : 'Object',
	#instVars : [
		'random',
		'scaleContext',
		'bars',
		'stepsPerBar',
		'voices',
		'laneLengths',
		'rhythmSources',
		'rhythmSource',
		'durationPolicy',
		'consonance',
		'sharpness'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'configuring' }
GenComposer >> bars: anInteger [

	bars := anInteger
]

{ #category : 'composing' }
GenComposer >> chooseScaleContext [

	^ scaleContext ifNil: [ GenScaleContext random: random consonance: consonance ]
]

{ #category : 'composing' }
GenComposer >> compose [
	"Harmony first, then rhythm, then the bass, then the voices above it."

	| context meter progression rhythms lanes |
	context := self chooseScaleContext.
	meter := GenMeter stepsPerBar: stepsPerBar.
	progression := (GenProgressionGenerator context: context random: random) generate: bars.
	rhythms := voices collect: [ :each |
		           (self rhythmSourceFor: each) rhythmOfSize: (self lengthFor: each) random: random ].
	lanes := OrderedCollection new.
	voices with: rhythms do: [ :voice :rhythm |
		lanes add: ((self generatorFor: voice context: context meter: meter progression: progression)
				 lowerLanes: lanes;
				 laneFor: rhythm) ].
	^ GenPiece
		  context: context
		  meter: meter
		  progression: progression
		  lanes: lanes
]

{ #category : 'configuring' }
GenComposer >> context: aScaleContext [

	scaleContext := aScaleContext
]

{ #category : 'configuring' }
GenComposer >> durationPolicy: aDurationPolicy [

	durationPolicy := aDurationPolicy
]

{ #category : 'configuring' }
GenComposer >> gate: aNumber [

	durationPolicy gate: aNumber
]

{ #category : 'composing' }
GenComposer >> generatorFor: aVoice context: aScaleContext meter: aMeter progression: aProgression [

	^ GenMelodyGenerator new
		  voice: aVoice;
		  candidates: (aScaleContext pitchesFrom: aVoice lowestMidi to: aVoice highestMidi);
		  progression: aProgression;
		  meter: aMeter;
		  random: random;
		  sharpness: sharpness;
		  consonance: consonance;
		  durationPolicy: durationPolicy;
		  yourself
]

{ #category : 'initialization' }
GenComposer >> initialize [

	super initialize.
	random := Random new.
	bars := 4.
	stepsPerBar := 16.
	voices := {
		          GenVoice bass.
		          GenVoice mid.
		          GenVoice lead }.
	laneLengths := Dictionary new.
	rhythmSources := Dictionary new.
	rhythmSource := GenBlendedRhythmSource new.
	durationPolicy := GenDurationPolicy new.
	consonance := GenConsonance new.
	sharpness := 2
]

{ #category : 'configuring' }
GenComposer >> length: aNumberOfSteps for: aRole [
	"Lanes are as long as the whole progression unless told otherwise; odd lengths drift against the harmony."

	laneLengths at: aRole put: aNumberOfSteps
]

{ #category : 'composing' }
GenComposer >> lengthFor: aVoice [

	^ laneLengths at: aVoice role ifAbsent: [ bars * stepsPerBar ]
]

{ #category : 'configuring' }
GenComposer >> random: aRandom [

	random := aRandom
]

{ #category : 'configuring' }
GenComposer >> rhythm: aRhythm for: aRole [
	"Pin one lane to a fixed rhythm, e.g. (GenRhythmLibrary default at: #fourOnTheFloor) for the bass."

	self rhythmSource: (GenFixedRhythmSource rhythm: aRhythm) for: aRole
]

{ #category : 'configuring' }
GenComposer >> rhythmSource: aRhythmSource [
	"The source used by every lane without its own."

	rhythmSource := aRhythmSource
]

{ #category : 'configuring' }
GenComposer >> rhythmSource: aRhythmSource for: aRole [

	rhythmSources at: aRole put: aRhythmSource
]

{ #category : 'composing' }
GenComposer >> rhythmSourceFor: aVoice [

	^ rhythmSources at: aVoice role ifAbsent: [ rhythmSource ]
]

{ #category : 'configuring' }
GenComposer >> scale: aSymbol root: aPitchClass [
	"Fix the scale and root (0 is C) instead of rolling the dice."

	scaleContext := GenScaleContext
		                scale: (GenScaleLibrary default at: aSymbol)
		                root: aPitchClass
		                consonance: consonance
]

{ #category : 'configuring' }
GenComposer >> seed: anInteger [

	random := Random seed: anInteger
]

{ #category : 'configuring' }
GenComposer >> sharpness: aNumber [
	"Power the note scores are raised to before the draw: higher is safer, lower is wilder."

	sharpness := aNumber
]

{ #category : 'configuring' }
GenComposer >> stepsPerBar: anInteger [

	stepsPerBar := anInteger
]

{ #category : 'configuring' }
GenComposer >> voices: aCollectionOfVoices [
	"Bottom voice first: each voice is scored against the ones before it."

	voices := aCollectionOfVoices asArray
]

{ #category : 'configuring' }
GenComposer >> worldRhythmAmount: aProbability [
	"The Rhythm source slider: 0 gives random rhythms, 1 world rhythms."

	rhythmSource := GenBlendedRhythmSource new
		                worldAmount: aProbability;
		                yourself
]
