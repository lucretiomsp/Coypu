Class {
	#name : #UGen,
	#superclass : #Object,
	#instVars : [
		'inputs',
		'numberOfContsants',
		'constantValues'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
UGen >> => anUGen [

	^ UGenGraph new numberOfUGens: 2
]

{ #category : #accessing }
UGen >> constantValues [

	^ constantValues
]

{ #category : #accessing }
UGen >> constantValues: anArray [

	constantValues := anArray
]

{ #category : #accessing }
UGen >> inputs [

	^ inputs
]

{ #category : #accessing }
UGen >> inputs: anObject [

	inputs := anObject
]

{ #category : #testing }
UGen >> isUGen [
^ true
]

{ #category : #accessing }
UGen >> numberOfContsants [

	^ numberOfContsants
]

{ #category : #accessing }
UGen >> numberOfContsants: anInteger [

	numberOfContsants := anInteger asByteArrayOfSize: 4
]
