"
I give a lane random steps: each step fires with probability density (Strategy). The first step always fires, so every lane has an anchor.
"
Class {
	#name : 'GenRandomRhythmSource',
	#superclass : 'GenRhythmSource',
	#instVars : [
		'density'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenRandomRhythmSource >> density [

	^ density
]

{ #category : 'accessing' }
GenRandomRhythmSource >> density: aProbability [

	density := aProbability
]

{ #category : 'initialization' }
GenRandomRhythmSource >> initialize [

	super initialize.
	density := 0.5
]

{ #category : 'generating' }
GenRandomRhythmSource >> rhythmOfSize: aSize random: aRandom [

	^ GenRhythm
		  named: #random
		  steps: ((1 to: aSize) collect: [ :each | each = 1 or: [ aRandom next < density ] ])
]
