"
UGenGraphFunc is a Sorted Collection of UGens used to send the bytes necessry to construct the SynthDefinitio on the server side of Super Collider
"
Class {
	#name : #UGenGraphFunc,
	#superclass : #SortedCollection,
	#instVars : [
		'numberOfConstants',
		'numberOfParameters',
		'numberOfParameterNames',
		'numberOfUGens',
		'numberOfVariants'
	],
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'instance creation' }
UGenGraphFunc class >> with: aCollectionOfUGens [

 | uGensSet |
	"first collect all the inputs of all the UGens in the collection as a Set to avoid duplicate"
	uGensSet := Set new.
	aCollectionOfUGens do: [ :i | uGensSet addAll: i inputs ].
	uGensSet addAll: aCollectionOfUGens.
	"sort UGens "
	
	uGensSet do: [ :i | self add: i ].
]

{ #category : #initialization }
UGenGraphFunc >> initialize [


	super initialize.
	
	
	self sortBlock: [ :a :b | a isInputOf: b ].
	numberOfConstants := 0 asByteArrayOfSize: 4.
	numberOfParameters := 0 asByteArrayOfSize: 4.
	numberOfParameterNames := 0 asByteArrayOfSize: 4.
	numberOfUGens := 0 asByteArrayOfSize: 4.
	numberOfVariants := 0 asByteArrayOfSize: 2
]

{ #category : #accessing }
UGenGraphFunc >> numberOfConstants [

	^ numberOfConstants
]

{ #category : #accessing }
UGenGraphFunc >> numberOfConstants: anInteger [

	numberOfConstants := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraphFunc >> numberOfParameterNames [

	^ numberOfParameterNames
]

{ #category : #accessing }
UGenGraphFunc >> numberOfParameterNames: anObject [

	numberOfParameterNames := anObject
]

{ #category : #accessing }
UGenGraphFunc >> numberOfParameters [

	^ numberOfParameters
]

{ #category : #accessing }
UGenGraphFunc >> numberOfParameters: anInteger [

	numberOfParameters := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraphFunc >> numberOfUGens [

	^ numberOfUGens
]

{ #category : #accessing }
UGenGraphFunc >> numberOfUGens: anInteger [

	numberOfUGens := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGenGraphFunc >> numberOfVariants [

	^ numberOfVariants
]

{ #category : #accessing }
UGenGraphFunc >> numberOfVariants: anInteger [

	numberOfVariants := anInteger asByteArrayOfSize: 2
]
