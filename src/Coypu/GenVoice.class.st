"
I am a voice (the role of a lane): bass, mid or lead. I know my register (center and range), how long I may hold a note, and my rules: a composite of weight factors multiplied for every candidate pitch.

The presets are Factory Methods:
	GenVoice bass.
	GenVoice mid.
	GenVoice lead.
To tweak one rule:
	(GenVoice lead scorer factorOfClass: GenMelodicMotionFactor) repeatWeight: 0.1.
"
Class {
	#name : 'GenVoice',
	#superclass : 'Object',
	#instVars : [
		'role',
		'center',
		'range',
		'maxHold',
		'scorer'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'presets' }
GenVoice class >> bass [
	"Low, on chord roots at bar starts, moving by repeats, fourths, fifths and octaves."

	^ self
		  role: #bass
		  center: 40
		  range: 12
		  maxHold: 4
		  scorer: (GenCompositeFactor withAll: {
					   GenChordConsonanceFactor new.
					   GenBassMotionFactor new.
					   GenRootLandingFactor new.
					   GenDirectionalFormFactor new.
					   (GenRegisterFactor center: 40 width: 6).
					   GenLoopClosureFactor new })
]

{ #category : 'presets' }
GenVoice class >> lead [
	"Around C#5, scored against the bass and the mid, never doubling the mid."

	^ self
		  role: #lead
		  center: 73
		  range: 12
		  maxHold: 6
		  scorer: (GenCompositeFactor withAll: {
					   GenChordConsonanceFactor new.
					   (GenVoiceInteractionFactor new
						    avoidDoublingWith: #( #mid );
						    yourself).
					   GenMelodicMotionFactor new.
					   GenDirectionalFormFactor new.
					   (GenRegisterFactor center: 73 width: 6).
					   GenLoopClosureFactor new })
]

{ #category : 'presets' }
GenVoice class >> mid [
	"Around B3, scored against the bass."

	^ self
		  role: #mid
		  center: 59
		  range: 10
		  maxHold: 8
		  scorer: (GenCompositeFactor withAll: {
					   GenChordConsonanceFactor new.
					   GenVoiceInteractionFactor new.
					   GenMelodicMotionFactor new.
					   GenDirectionalFormFactor new.
					   (GenRegisterFactor center: 59 width: 5).
					   GenLoopClosureFactor new })
]

{ #category : 'instance creation' }
GenVoice class >> role: aSymbol center: aMidi range: aNumberOfSemitones maxHold: aNumberOfSteps scorer: aFactor [

	^ self new
		  setRole: aSymbol
		  center: aMidi
		  range: aNumberOfSemitones
		  maxHold: aNumberOfSteps
		  scorer: aFactor;
		  yourself
]

{ #category : 'accessing' }
GenVoice >> center [

	^ center
]

{ #category : 'accessing' }
GenVoice >> highestMidi [

	^ center + range
]

{ #category : 'accessing' }
GenVoice >> lowestMidi [

	^ center - range
]

{ #category : 'accessing' }
GenVoice >> maxHold [
	"The longest a note is usually held, in steps."

	^ maxHold
]

{ #category : 'printing' }
GenVoice >> printOn: aStream [

	aStream nextPutAll: role
]

{ #category : 'accessing' }
GenVoice >> range [
	"Semitones above and below the center."

	^ range
]

{ #category : 'accessing' }
GenVoice >> role [

	^ role
]

{ #category : 'accessing' }
GenVoice >> scorer [

	^ scorer
]

{ #category : 'initialization' }
GenVoice >> setRole: aSymbol center: aMidi range: aNumberOfSemitones maxHold: aNumberOfSteps scorer: aFactor [

	role := aSymbol.
	center := aMidi.
	range := aNumberOfSemitones.
	maxHold := aNumberOfSteps.
	scorer := aFactor
]

{ #category : 'scoring' }
GenVoice >> weightOf: aPitch in: aContext [

	^ scorer weightOf: aPitch in: aContext
]
