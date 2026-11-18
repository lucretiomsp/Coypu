"
I give a lane a world rhythm from the library, tiled to the lane (Strategy).
"
Class {
	#name : 'GenWorldRhythmSource',
	#superclass : 'GenRhythmSource',
	#instVars : [
		'library'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'initialization' }
GenWorldRhythmSource >> initialize [

	super initialize.
	library := GenRhythmLibrary default
]

{ #category : 'accessing' }
GenWorldRhythmSource >> library: aRhythmLibrary [

	library := aRhythmLibrary
]

{ #category : 'generating' }
GenWorldRhythmSource >> rhythmOfSize: aSize random: aRandom [

	^ library randomRhythmOfSize: aSize random: aRandom
]
