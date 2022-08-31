Class {
	#name : #UGen,
	#superclass : #Object,
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
UGen >> => anUGen [ 
	^ SynthDef new
]

{ #category : #testing }
UGen >> isUGen [
^ true
]
