Class {
	#name : #UGenGraph,
	#superclass : #Object,
	#instVars : [
		'numberOfConstants',
		'numberOfParameters',
		'numberOfParameterNames',
		'numberOfUGens',
		'numberOfVariants'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #initialization }
UGenGraph >> initialize [

	super initialize.
	numberOfConstants := 0 asByteArrayOfSize: 4.
	numberOfParameters := 0 asByteArrayOfSize: 4.
	numberOfParameterNames := 0 asByteArrayOfSize: 4.
	numberOfUGens := 0 asByteArrayOfSize: 4.
	numberOfVariants := 0 asByteArrayOfSize: 2
]

{ #category : #accessing }
UGenGraph >> numberOfConstants [

	^ numberOfConstants
]

{ #category : #accessing }
UGenGraph >> numberOfConstants: anInteger [

	numberOfConstants := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraph >> numberOfParameterNames [

	^ numberOfParameterNames
]

{ #category : #accessing }
UGenGraph >> numberOfParameterNames: anObject [

	numberOfParameterNames := anObject
]

{ #category : #accessing }
UGenGraph >> numberOfParameters [

	^ numberOfParameters
]

{ #category : #accessing }
UGenGraph >> numberOfParameters: anInteger [

	numberOfParameters := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraph >> numberOfUGens [

	^ numberOfUGens
]

{ #category : #accessing }
UGenGraph >> numberOfUGens: anInteger [

	numberOfUGens := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraph >> numberOfVariants [

	^ numberOfVariants
]

{ #category : #accessing }
UGenGraph >> numberOfVariants: anInteger [

	numberOfVariants := anInteger asByteArrayOfSize: 2
]
