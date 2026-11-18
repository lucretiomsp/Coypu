"
I am a rhythm: a loop of steps that fire or rest (Value Object). Steps are 1-based and wrap around.

Examples:
	(GenRhythm named: #tresillo pattern: 'x..x..x.') onsets.
	((GenRhythm pattern: 'x..') fittedTo: 8) asString.
"
Class {
	#name : 'GenRhythm',
	#superclass : 'Object',
	#instVars : [
		'name',
		'steps'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenRhythm class >> named: aName pattern: aString [
	"x or X fires, any other character rests."

	^ self named: aName steps: (aString asArray collect: [ :each | each = $x or: [ each = $X ] ])
]

{ #category : 'instance creation' }
GenRhythm class >> named: aName steps: aCollection [

	^ self new
		  setName: aName steps: aCollection asArray;
		  yourself
]

{ #category : 'instance creation' }
GenRhythm class >> pattern: aString [

	^ self named: aString pattern: aString
]

{ #category : 'comparing' }
GenRhythm >> = anObject [
	"Two rhythms are equal when they fire on the same steps, whatever their names."

	^ self class = anObject class and: [ steps = anObject steps ]
]

{ #category : 'converting' }
GenRhythm >> asString [

	^ String streamContents: [ :stream |
		  steps do: [ :each |
			  stream nextPut: (each
					   ifTrue: [ $x ]
					   ifFalse: [ $. ]) ] ]
]

{ #category : 'converting' }
GenRhythm >> fittedTo: aSize [
	"Tile or cut the loop to aSize steps."

	^ self class
		  named: name
		  steps: ((1 to: aSize) collect: [ :each | self isOnsetAt: each ])
]

{ #category : 'comparing' }
GenRhythm >> hash [

	^ steps hash
]

{ #category : 'testing' }
GenRhythm >> isOnsetAt: aStep [

	^ steps at: aStep - 1 \\ steps size + 1
]

{ #category : 'accessing' }
GenRhythm >> name [

	^ name
]

{ #category : 'accessing' }
GenRhythm >> onsetCount [

	^ steps count: [ :each | each ]
]

{ #category : 'accessing' }
GenRhythm >> onsets [
	"The 1-based steps that fire."

	^ (1 to: steps size) select: [ :each | steps at: each ]
]

{ #category : 'printing' }
GenRhythm >> printOn: aStream [

	aStream
		nextPutAll: name asString;
		space;
		nextPutAll: self asString
]

{ #category : 'converting' }
GenRhythm >> rotatedBy: anInteger [
	"Shift the loop left by anInteger steps."

	^ self class
		  named: name
		  steps: ((1 to: self size) collect: [ :each | self isOnsetAt: each + anInteger ])
]

{ #category : 'initialization' }
GenRhythm >> setName: aName steps: anArray [

	name := aName.
	steps := anArray
]

{ #category : 'accessing' }
GenRhythm >> size [

	^ steps size
]

{ #category : 'accessing' }
GenRhythm >> steps [

	^ steps
]
