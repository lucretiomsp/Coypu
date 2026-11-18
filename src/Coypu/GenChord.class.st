"
I am the chord on one scale degree: a root plus the scale notes that act as its third and fifth.

I also know how stable I am (strength, from 0 to 1): the product of how much my third sounds like a third and my fifth like a fifth. Chords with a weak third or fifth (a diminished triad, a whole-tone triad) are picked less often by the progression.

Pitch classes are absolute semitones from 0 to 12, fractional in microtonal scales. I am a Value Object.
"
Class {
	#name : 'GenChord',
	#superclass : 'Object',
	#instVars : [
		'degree',
		'root',
		'third',
		'fifth',
		'strength'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenChord class >> degree: aDegree root: aPitchClass third: thirdSemitones fifth: fifthSemitones strength: aNumber [

	^ self new
		  setDegree: aDegree
		  root: aPitchClass
		  third: thirdSemitones
		  fifth: fifthSemitones
		  strength: aNumber;
		  yourself
]

{ #category : 'comparing' }
GenChord >> = anObject [

	^ self class = anObject class and: [
		  degree = anObject degree and: [
			  root = anObject root and: [
				  third = anObject third and: [ fifth = anObject fifth ] ] ] ]
]

{ #category : 'accessing' }
GenChord >> degree [
	"The scale degree (1-based) the chord is built on."

	^ degree
]

{ #category : 'accessing' }
GenChord >> fifth [
	"Semitones from the root to the fifth."

	^ fifth
]

{ #category : 'comparing' }
GenChord >> hash [

	^ (degree hash bitXor: root hash) bitXor: third hash
]

{ #category : 'testing' }
GenChord >> includesPitch: aPitch [
	"Is aPitch one of my tones, in any octave?"

	^ self tones anySatisfy: [ :each | self pitchClass: each matches: aPitch ]
]

{ #category : 'private' }
GenChord >> pitchClass: aPitchClass matches: aPitch [

	^ (aPitch midi - aPitchClass * 100) rounded \\ 1200 = 0
]

{ #category : 'printing' }
GenChord >> printOn: aStream [

	aStream
		nextPutAll: 'degree ';
		print: degree;
		nextPutAll: ' ('.
	self tones
		do: [ :each | aStream nextPutAll: (GenPitch nameOfPitchClass: each) ]
		separatedBy: [ aStream space ].
	aStream nextPut: $)
]

{ #category : 'accessing' }
GenChord >> root [
	"Pitch class of the root."

	^ root
]

{ #category : 'testing' }
GenChord >> rootMatches: aPitch [

	^ self pitchClass: root matches: aPitch
]

{ #category : 'initialization' }
GenChord >> setDegree: aDegree root: aPitchClass third: thirdSemitones fifth: fifthSemitones strength: aNumber [

	degree := aDegree.
	root := aPitchClass.
	third := thirdSemitones.
	fifth := fifthSemitones.
	strength := aNumber
]

{ #category : 'accessing' }
GenChord >> strength [

	^ strength
]

{ #category : 'accessing' }
GenChord >> third [
	"Semitones from the root to the third."

	^ third
]

{ #category : 'accessing' }
GenChord >> tones [
	"Root, third and fifth as pitch classes."

	^ {
		  root.
		  (root + third \\ 12).
		  (root + fifth \\ 12) }
]
