Class {
	#name : #UGen,
	#superclass : #Object,
	#instVars : [
		'uGenName',
		'specialIndex',
		'calculationRate',
		'inputs',
		'outputs',
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
inputs := Dictionary new.
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

{ #category : #accessing }
UGen >> inputsUGen [
	| result |
	result := OrderedCollection new.
	self inputs do: [ :i | i isNumber ifFalse: [ result add: i ]  ifTrue: [ ] ] .
^ result asArray 
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
^ numberOfInputs .
]

{ #category : #accessing }
UGen >> numberOfInputs: anObject [

	numberOfInputs := anObject
]

{ #category : #accessing }
UGen >> outputs [

	^ outputs
]

{ #category : #accessing }
UGen >> specialIndex [

	^ specialIndex
]

{ #category : #accessing }
UGen >> uGenName [

	^ uGenName
]

{ #category : #'as yet unclassified' }
UGen >> uGenSpec [

| result |
	result := OrderedCollection new.
	result addAll: self uGenName asPString .
	result add: calculationRate .
	result addAll: (self numberOfInputs  asByteArrayOfSize: 4).
	result addAll: (self outputs asByteArrayOfSize: 4).
	result addAll: (self specialIndex asByteArrayOfSize: 2) .
	
	self inputs keysAndValuesDo:  [ :k :v | v isNumber ifTrue: [   result addAll: #(-1 -1 -1 -1). result addAll: (k asByteArrayOfSize: 4)  ] ifFalse: [
			"index of unit generator and index of unit generator output"
			 ]   ].
	
	result add: self calculationRate .



 ^ result asArray
]
