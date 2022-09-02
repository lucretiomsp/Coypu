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
input := aUGen

	
]
