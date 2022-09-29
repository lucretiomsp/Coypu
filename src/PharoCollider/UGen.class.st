Class {
	#name : #UGen,
	#superclass : #Object,
	#instVars : [
		'uGenName',
		'specialIndex',
		'calculationRate',
		'inputs',
		'numberOfInputs',
		'numberOfConstants',
		'constantValues',
		'constants'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
UGen >> => anUGen [

	^ UGensGraphFunc new numberOfUGens: 2
]

{ #category : #'as yet unclassified' }
UGen >> ar [ 
"set calculation rate to audio rate"
calculationRate := 2.
]

{ #category : #accessing }
UGen >> calculationRate [

	^ calculationRate
]

{ #category : #accessing }
UGen >> calculationRate: anObject [

	calculationRate := anObject
]

{ #category : #accessing }
UGen >> constantValues [

	^ constants values collect: [ :i | i] 
]

{ #category : #accessing }
UGen >> constantValues: anArray [

	constantValues := anArray
]

{ #category : #accessing }
UGen >> constants [

	^ constants
]

{ #category : #accessing }
UGen >> constants: aDictionary [

	constants := aDictionary
]

{ #category : #initialization }
UGen >> initialize [ 
super initialize .
inputs := OrderedCollection new.
constants := Dictionary new.
specialIndex := 0.
]

{ #category : #accessing }
UGen >> inputs [

	^ inputs
]

{ #category : #accessing }
UGen >> inputs: aConstantOrAUGen [

	inputs := aConstantOrAUGen
]

{ #category : #testing }
UGen >> isInputOf: anUGen [

	^ anUGen inputs includes: self
]

{ #category : #testing }
UGen >> isUGen [ 
^ true
]

{ #category : #'as yet unclassified' }
UGen >> kr [ 
"set calculation rate to control rate"
calculationRate := 1.
]

{ #category : #accessing }
UGen >> numberOfConstants [

	^ constants size
]

{ #category : #accessing }
UGen >> numberOfConstants: anInteger [

	numberOfConstants  := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGen >> numberOfInputs [
^ inputs size.
]

{ #category : #accessing }
UGen >> numberOfInputs: anObject [

	numberOfInputs := anObject
]

{ #category : #accessing }
UGen >> specialIndex [

	^ specialIndex
]

{ #category : #accessing }
UGen >> uGenName [

	^ uGenName
]
