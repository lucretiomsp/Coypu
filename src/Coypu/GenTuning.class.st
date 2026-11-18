"
I describe how an octave is divided: one semitone offset per tuning step.

Equal temperaments (12 and 24 steps) are evenly spaced; just intonation tunings such as Harry Partch's 43-tone scale come from frequency ratios. Scales index into me with 0-based tuning steps, exactly like SuperCollider's Scale and Tuning.

I am a Value Object.

Examples:
	GenTuning et12 semitonesAt: 7.
	GenTuning et24 semitonesAt: 3.
	GenTuning partch semitonesAt: 25.
The last one is the pure fifth 3/2, a little above 7 semitones.
"
Class {
	#name : 'GenTuning',
	#superclass : 'Object',
	#instVars : [
		'name',
		'semitones',
		'ratios'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenTuning class >> et12 [
	"Twelve-tone equal temperament."

	^ self named: 'ET12' semitones: (0 to: 11)
]

{ #category : 'instance creation' }
GenTuning class >> et24 [
	"Quarter tones: 24 equal steps per octave. Whole semitones stay integers, so quarter-tone scales still give plain MIDI numbers where they can."

	^ self named: 'ET24' semitones: ((0 to: 23) collect: [ :step |
			   step even
				   ifTrue: [ step // 2 ]
				   ifFalse: [ step / 2.0 ] ])
]

{ #category : 'instance creation' }
GenTuning class >> named: aString ratios: aCollection [
	"A just intonation tuning: one frequency ratio per step, starting with 1."

	^ self new
		  setName: aString
		  semitones: (aCollection collect: [ :ratio | self semitonesOfRatio: ratio ]) asArray
		  ratios: aCollection asArray;
		  yourself
]

{ #category : 'instance creation' }
GenTuning class >> named: aString semitones: aCollection [

	^ self new
		  setName: aString semitones: aCollection asArray ratios: nil;
		  yourself
]

{ #category : 'instance creation' }
GenTuning class >> partch [
	"Harry Partch's 43-tone just intonation scale, as SuperCollider's Tuning.partch."

	^ self named: 'Partch 43' ratios: {
			  1. 81 / 80. 33 / 32. 21 / 20. 16 / 15. 12 / 11. 11 / 10. 10 / 9. 9 / 8.
			  8 / 7. 7 / 6. 32 / 27. 6 / 5. 11 / 9. 5 / 4. 14 / 11. 9 / 7. 21 / 16.
			  4 / 3. 27 / 20. 11 / 8. 7 / 5. 10 / 7. 16 / 11. 40 / 27. 3 / 2. 32 / 21.
			  14 / 9. 11 / 7. 8 / 5. 18 / 11. 5 / 3. 27 / 16. 12 / 7. 7 / 4. 16 / 9.
			  9 / 5. 20 / 11. 11 / 6. 15 / 8. 40 / 21. 64 / 33. 160 / 81 }
]

{ #category : 'converting' }
GenTuning class >> semitonesOfRatio: aNumber [
	"12 * log2(ratio): 2 is 12 semitones, 3/2 is 7.02."

	^ 12 * (aNumber asFloat log: 2)
]

{ #category : 'comparing' }
GenTuning >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class and: [ semitones = anObject semitones ]
]

{ #category : 'comparing' }
GenTuning >> hash [

	^ semitones hash
]

{ #category : 'testing' }
GenTuning >> isJustIntonation [
	"Just intonation tunings know their ratios; equal temperaments do not."

	^ ratios notNil
]

{ #category : 'accessing' }
GenTuning >> name [

	^ name
]

{ #category : 'printing' }
GenTuning >> printOn: aStream [

	aStream nextPutAll: name
]

{ #category : 'accessing' }
GenTuning >> ratios [

	^ ratios
]

{ #category : 'accessing' }
GenTuning >> semitones [

	^ semitones
]

{ #category : 'accessing' }
GenTuning >> semitonesAt: aStep [
	"Semitones of a 0-based tuning step. Steps outside the octave wrap with an octave shift: -1 is the top step one octave down."

	^ aStep // self size * 12 + (semitones at: aStep \\ self size + 1)
]

{ #category : 'initialization' }
GenTuning >> setName: aString semitones: anArray ratios: anArrayOrNil [

	name := aString.
	semitones := anArray.
	ratios := anArrayOrNil
]

{ #category : 'accessing' }
GenTuning >> size [
	"Steps per octave."

	^ semitones size
]
