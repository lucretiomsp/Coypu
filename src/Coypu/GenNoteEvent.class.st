"
I am one note of a lane: where it starts (1-based step), its pitch, how many steps it lasts and its gate, the part of the length that actually sounds (Value Object).
"
Class {
	#name : 'GenNoteEvent',
	#superclass : 'Object',
	#instVars : [
		'step',
		'pitch',
		'duration',
		'gate'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenNoteEvent class >> step: aStep pitch: aPitch duration: aNumberOfSteps gate: aNumber [

	^ self new
		  setStep: aStep
		  pitch: aPitch
		  duration: aNumberOfSteps
		  gate: aNumber;
		  yourself
]

{ #category : 'accessing' }
GenNoteEvent >> duration [

	^ duration
]

{ #category : 'accessing' }
GenNoteEvent >> gate [

	^ gate
]

{ #category : 'accessing' }
GenNoteEvent >> midi [

	^ pitch midi
]

{ #category : 'accessing' }
GenNoteEvent >> name [

	^ pitch name
]

{ #category : 'accessing' }
GenNoteEvent >> pitch [

	^ pitch
]

{ #category : 'printing' }
GenNoteEvent >> printOn: aStream [

	aStream
		print: step;
		nextPutAll: ': ';
		nextPutAll: self name;
		nextPutAll: ' x';
		print: duration
]

{ #category : 'initialization' }
GenNoteEvent >> setStep: aStep pitch: aPitch duration: aNumberOfSteps gate: aNumber [

	step := aStep.
	pitch := aPitch.
	duration := aNumberOfSteps.
	gate := aNumber
]

{ #category : 'accessing' }
GenNoteEvent >> soundingDuration [
	"Steps that actually sound."

	^ duration * gate
]

{ #category : 'accessing' }
GenNoteEvent >> step [

	^ step
]
