"
I am a chord progression, one chord per bar (Value Object). Bars and steps are 1-based and wrap around, so a looping lane can ask for any step.
"
Class {
	#name : 'GenProgression',
	#superclass : 'Object',
	#instVars : [
		'chords'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenProgression class >> withAll: aCollection [

	^ self new
		  setChords: aCollection asArray;
		  yourself
]

{ #category : 'comparing' }
GenProgression >> = anObject [

	^ self class = anObject class and: [ chords = anObject chords ]
]

{ #category : 'accessing' }
GenProgression >> chordAtBar: aBar [

	^ chords at: aBar - 1 \\ chords size + 1
]

{ #category : 'accessing' }
GenProgression >> chordAtStep: aStep meter: aMeter [

	^ self chordAtBar: (aMeter barOfStep: aStep)
]

{ #category : 'accessing' }
GenProgression >> chords [

	^ chords
]

{ #category : 'accessing' }
GenProgression >> degrees [

	^ chords collect: [ :each | each degree ]
]

{ #category : 'enumerating' }
GenProgression >> do: aBlock [

	chords do: aBlock
]

{ #category : 'accessing' }
GenProgression >> first [

	^ chords first
]

{ #category : 'comparing' }
GenProgression >> hash [

	^ chords hash
]

{ #category : 'accessing' }
GenProgression >> last [

	^ chords last
]

{ #category : 'accessing' }
GenProgression >> lengthInSteps: aMeter [

	^ chords size * aMeter stepsPerBar
]

{ #category : 'printing' }
GenProgression >> printOn: aStream [

	self degrees
		do: [ :each | aStream print: each ]
		separatedBy: [ aStream nextPutAll: ' - ' ]
]

{ #category : 'initialization' }
GenProgression >> setChords: anArray [

	chords := anArray
]

{ #category : 'accessing' }
GenProgression >> size [
	"Number of bars."

	^ chords size
]
