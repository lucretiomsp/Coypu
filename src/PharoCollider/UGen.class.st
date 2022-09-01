Class {
	#name : #UGen,
	#superclass : #Object,
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
UGen >> => anUGen [

	^ UGenGraph new numberOfUGens: 2
]

{ #category : #testing }
UGen >> isUGen [
^ true
]
