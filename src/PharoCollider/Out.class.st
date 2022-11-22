"
corresponding to SuperColllider ""Out"" UGen
"
Class {
	#name : #Out,
	#superclass : #AbstractOut,
	#instVars : [
		'bus',
		'input'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'instance creation' }
Out class >> bus: anInteger input: aUGen [

	| result |
	result := self new
		          bus: anInteger;
		          input: aUGen.
		
	aUGen isUGen ifTrue: [ ^ result ] ifFalse: [ . Transcript show: 'INPUT MUST BE A UGEN !!!!!'; cr; open. ^ nil]
]

{ #category : #accessing }
Out >> bus [
"The index of the bus to write out to. The lowest numbers are written to the audio hardware"

	^ bus
]

{ #category : #accessing }
Out >> bus: anInteger [
bus := anInteger 

	
]

{ #category : #initialization }
Out >> initialize [

 super initialize.
	bus := 0.
	numberOfConstants := 1.
	input := UGen new
]

{ #category : #accessing }
Out >> input [ 
^ input
]

{ #category : #accessing }
Out >> input: aUGen [
"An Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

"
	input := aUGen.
	self inputs at: 2 put: aUGen
]
