Class {
	#name : #UGen,
	#superclass : #Object,
	#instVars : [
		'inputs',
		'numberOfInputs',
		'numberOfConstants',
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
UGen >> initialize [ 
super initialize.
inputs := OrderedCollection new.
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
UGen >> isInputOf: anUGen [

	^ anUGen inputs includes: self
]

{ #category : #testing }
UGen >> isUGen [ 
^ true
]

{ #category : #accessing }
UGen >> numberOfConstsants [

	^ numberOfConstants 
]

{ #category : #accessing }
UGen >> numberOfConstsnts [

	^ numberOfConstants
]

{ #category : #accessing }
UGen >> numberOfContsants: anInteger [

	numberOfConstants  := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGen >> numberOfInputs [
^ inputs size.
]
