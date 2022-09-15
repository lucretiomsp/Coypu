"
corresponding to SuperColllider ""Out"" UGen
"
Class {
	#name : #Dac,
	#superclass : #UGen,
	#instVars : [
		'bus',
		'input'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'instance creation' }
Dac class >> bus: anInteger input: aUGen [

	| result |
	result := self new
		          bus: anInteger;
		          input: aUGen.
		
	aUGen isUGen ifTrue: [ ^ result ] ifFalse: [ . Transcript show: 'INPUT MUST BE A UGEN !!!!!'; cr; open. ^ nil]
]

{ #category : #accessing }
Dac >> bus [
"The index of the bus to write out to. The lowest numbers are written to the audio hardware"

	^ bus
]

{ #category : #accessing }
Dac >> bus: anInteger [
bus := anInteger 

	
]

{ #category : #initialization }
Dac >> initialize [

	bus := 0.
	numberOfContsants := 1.
	input := UGen new.
]

{ #category : #accessing }
Dac >> input [ 
^ input
]

{ #category : #accessing }
Dac >> input: aUGen [
"An Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

"
	input := aUGen.
	self inputs add: aUGen
]
