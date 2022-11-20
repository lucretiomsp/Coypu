"
UGenGraphFunc is an object that contains information about the UGenGraphFunc which builds the SynthDef in SuperCollider.
My implementation in Pharo is different.
A memeber of the class is sortedUGens which is a SorteCollection of the UGens in the SynthDef
"
Class {
	#name : #UGensGraphFunc,
	#superclass : #Object,
	#instVars : [
		'sortedUGens',
		'numberOfConstants',
		'numberOfParameters',
		'numberOfParameterNames',
		'numberOfUGens',
		'numberOfVariants'
	],
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'instance creation' }
UGensGraphFunc class >> new [

^ super new

	numberOfConstants: ( 0 asByteArrayOfSize: 4);
	numberOfParameters: (0 asByteArrayOfSize: 4);
	numberOfParameterNames: (0 asByteArrayOfSize: 4);
	numberOfUGens: (0 asByteArrayOfSize: 4);
	numberOfVariants: (0 asByteArrayOfSize: 2).
]

{ #category : #'instance creation' }
UGensGraphFunc class >> with: aCollectionOfUGens [

 | uGensSet instance |
	"first collect all the inputs of all the UGens in the collection as a Set to avoid duplicate"
	instance := self new sortBlock: [ :a :b | a isInputOf: b ].
	uGensSet := Set new.
	uGensSet addAll: aCollectionOfUGens.
	aCollectionOfUGens do: [ :i | uGensSet addAll: i inputs ].
	
	"sort UGens "
	
	uGensSet do: [ :i | instance add: i ].
	^ instance
	

]

{ #category : #initialization }
UGensGraphFunc >> initialize [

	super initialize.
   sortedUGens := SortedCollection new.
	sortedUGens sortBlock: [ :a :b | a isInputOf: b ]
]

{ #category : #accessing }
UGensGraphFunc >> numberOfConstants [

	^ numberOfConstants
]

{ #category : #accessing }
UGensGraphFunc >> numberOfConstants: anInteger [

	numberOfConstants := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGensGraphFunc >> numberOfParameterNames [

	^ numberOfParameterNames
]

{ #category : #accessing }
UGensGraphFunc >> numberOfParameterNames: anObject [

	numberOfParameterNames := anObject
]

{ #category : #accessing }
UGensGraphFunc >> numberOfParameters [

	^ numberOfParameters
]

{ #category : #accessing }
UGensGraphFunc >> numberOfParameters: anInteger [

	numberOfParameters := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGensGraphFunc >> numberOfUGens [

	^ numberOfUGens
]

{ #category : #accessing }
UGensGraphFunc >> numberOfUGens: anInteger [

	numberOfUGens := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
UGensGraphFunc >> numberOfVariants [

	^ numberOfVariants
]

{ #category : #accessing }
UGensGraphFunc >> numberOfVariants: anInteger [

	numberOfVariants := anInteger asByteArrayOfSize: 2
]

{ #category : #accessing }
UGensGraphFunc >> sortedUGens [
^ sortedUGens 
]
