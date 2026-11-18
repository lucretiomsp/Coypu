"
I give a lane its rhythm (Strategy). Rhythm comes before pitch: the melody brain only picks pitches for the steps I fire.

My subclasses: world rhythms from the library, random steps with a density, a fixed rhythm, and the blend of the first two (the Rhythm source slider).

Example:
	GenRandomRhythmSource new
		density: 0.4;
		rhythmOfSize: 16 random: Random new.
"
Class {
	#name : 'GenRhythmSource',
	#superclass : 'Object',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'generating' }
GenRhythmSource >> rhythmOfSize: aSize random: aRandom [
	"Answer a GenRhythm of aSize steps."

	^ self subclassResponsibility
]
