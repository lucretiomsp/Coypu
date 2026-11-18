"
I am a scale: a key, a name, degrees (0-based steps of a tuning) and, for scales such as melodic minor or maqam Sikah, other degrees used when the melody goes down.

I am a Value Object. GenScaleLibrary holds the 108 scales of SuperCollider.

A degree is 1-based (degree 1 is the root). A step is 0-based and absolute: step 0 is the root, step 7 of a seven-note scale is the root an octave up, step -1 is the note just below the root.
"
Class {
	#name : 'GenScale',
	#superclass : 'Object',
	#instVars : [
		'key',
		'name',
		'degrees',
		'descendingDegrees',
		'tuning'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenScale class >> key: aSymbol name: aString degrees: anArray descending: anArrayOrNil tuning: aTuning [

	^ self new
		  setKey: aSymbol
		  name: aString
		  degrees: anArray asArray
		  descending: anArrayOrNil
		  tuning: aTuning;
		  yourself
]

{ #category : 'instance creation' }
GenScale class >> key: aSymbol name: aString degrees: anArray tuning: aTuning [

	^ self
		  key: aSymbol
		  name: aString
		  degrees: anArray
		  descending: nil
		  tuning: aTuning
]

{ #category : 'comparing' }
GenScale >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class and: [
		  key = anObject key and: [
			  degrees = anObject degrees and: [ tuning = anObject tuning ] ] ]
]

{ #category : 'harmony' }
GenScale >> consonanceOfDegree: aDegree using: aConsonance [
	"Sum of the consonances of every other degree heard above aDegree."

	| base |
	base := self semitonesAtStep: aDegree - 1.
	^ (1 to: self size) inject: 0 into: [ :sum :other |
		  other = aDegree
			  ifTrue: [ sum ]
			  ifFalse: [ sum + (aConsonance ofInterval: (self semitonesAtStep: other - 1) - base) ] ]
]

{ #category : 'accessing' }
GenScale >> degrees [

	^ degrees
]

{ #category : 'accessing' }
GenScale >> descendingDegrees [

	^ descendingDegrees
]

{ #category : 'accessing' }
GenScale >> descendingSemitonesAtStep: aStep [
	"Like semitonesAtStep:, on the descending form when there is one."

	^ self semitonesAtStep: aStep of: (descendingDegrees ifNil: [ degrees ])
]

{ #category : 'testing' }
GenScale >> hasDescendingForm [

	^ descendingDegrees notNil
]

{ #category : 'comparing' }
GenScale >> hash [

	^ key hash bitXor: degrees hash
]

{ #category : 'testing' }
GenScale >> isHeptatonic [

	^ self size = 7
]

{ #category : 'testing' }
GenScale >> isJustIntonation [

	^ tuning isJustIntonation
]

{ #category : 'accessing' }
GenScale >> key [

	^ key
]

{ #category : 'accessing' }
GenScale >> name [

	^ name
]

{ #category : 'printing' }
GenScale >> printOn: aStream [

	aStream nextPutAll: name
]

{ #category : 'accessing' }
GenScale >> semitones [
	"Semitones of every degree above the root."

	^ (0 to: self size - 1) collect: [ :step | self semitonesAtStep: step ]
]

{ #category : 'accessing' }
GenScale >> semitonesAtStep: aStep [
	"Semitones above the root of the absolute, 0-based scale step aStep."

	^ self semitonesAtStep: aStep of: degrees
]

{ #category : 'private' }
GenScale >> semitonesAtStep: aStep of: someDegrees [

	^ aStep // self size * 12 + (tuning semitonesAt: (someDegrees at: aStep \\ self size + 1))
]

{ #category : 'initialization' }
GenScale >> setKey: aSymbol name: aString degrees: anArray descending: anArrayOrNil tuning: aTuning [

	key := aSymbol.
	name := aString.
	degrees := anArray.
	descendingDegrees := anArrayOrNil ifNotNil: [ anArrayOrNil asArray ].
	tuning := aTuning
]

{ #category : 'accessing' }
GenScale >> size [

	^ degrees size
]

{ #category : 'accessing' }
GenScale >> tuning [

	^ tuning
]
