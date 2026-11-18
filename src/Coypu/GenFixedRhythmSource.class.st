"
I always give the same rhythm, tiled to the lane (Strategy). Handy to pin a lane to a groove, such as four on the floor for the bass.
"
Class {
	#name : 'GenFixedRhythmSource',
	#superclass : 'GenRhythmSource',
	#instVars : [
		'rhythm'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenFixedRhythmSource class >> rhythm: aRhythm [

	^ self new
		  setRhythm: aRhythm;
		  yourself
]

{ #category : 'generating' }
GenFixedRhythmSource >> rhythmOfSize: aSize random: aRandom [

	^ rhythm fittedTo: aSize
]

{ #category : 'initialization' }
GenFixedRhythmSource >> setRhythm: aRhythm [

	rhythm := aRhythm
]
