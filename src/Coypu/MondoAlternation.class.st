Class {
	#name : 'MondoAlternation',
	#superclass : 'Object',
	#instVars : [
		'choices',
		'speed'
	],
	#category : 'Coypu-Cyclic',
	#package : 'Coypu',
	#tag : 'Cyclic'
}

{ #category : 'as yet unclassified' }
MondoAlternation class >> choices: anArray [
	^ self new choices: anArray; speed: 1; yourself
]

{ #category : 'as yet unclassified' }
MondoAlternation class >> choices: anArray speed: anInteger [
	^ self new choices: anArray; speed: anInteger; yourself

]

{ #category : 'accessing' }
MondoAlternation >> choices [
	^ choices
]

{ #category : 'accessing' }
MondoAlternation >> choices: anArray [
	choices := anArray
]

{ #category : 'as yet unclassified' }
MondoAlternation >> chooseForCycle: cycleIndex slot: slotIndex [
	"Pick the choice for a given cycle. slotIndex is which sub-step within the cycle (1-based)."
	| effectiveIndex |
	effectiveIndex := ((cycleIndex - 1) * speed + (slotIndex - 1)) \\ choices size + 1.
	^ choices at: effectiveIndex
]

{ #category : 'accessing' }
MondoAlternation >> speed [ 
^ speed
]

{ #category : 'accessing' }
MondoAlternation >> speed: anInteger [

speed := anInteger
]
