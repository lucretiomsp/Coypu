Class {
	#name : #SynthDef,
	#superclass : #Object,
	#instVars : [
		'defname',
		'numberOfConstants',
		'numberOfParameters',
		'numberOfParameterNames',
		'numberOfVariants',
		'constantValues',
		'numberOfUGens',
		'graph'
	],
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'instance creation' }
SynthDef class >> with: aCollection [ 
	^ self new numberOfUGens: aCollection size
]

{ #category : #'as yet unclassified' }
SynthDef class >> withName: aString graph: anUGenGraph [ 
	^ self new name: aString; graph: anUGenGraph
]

{ #category : #converting }
SynthDef >> asBytes [

	| int8Array SCgf version def |
	int8Array := OrderedCollection new.
	"int32 - four byte file type id containing the ASCII characters: 'SCgf' "
	SCgf := 'SCgf' asByteArray.
	SCgf do: [ :i | int8Array add: i ].
	"int32 - file version, currently 2."
	version := #( 0 0 0 2 ).
	1 to: version size do: [ :i | int8Array add: (version at: i) ].
	"int16 - number of synth definitions in this file (D)."
	def := #( 0 1 ). "for one definition"
	1 to: def size do: [ :i | int8Array add: (def at: i) ].
	"pstring - the name of the synth definition"

	int8Array addLast: defname size.
	1 to: defname size do: [ :i | 
	int8Array add: (defname asByteArray at: i) ].
	"int32 - number of constants (K)"

	1 to: numberOfConstants size do: [ :i | 
	int8Array add: (numberOfConstants at: i) ].

	"[float32] * K - constant values"

	"int32 - number of parameters (P)"

	1 to: numberOfParameters size do: [ :i | 
	int8Array add: (numberOfParameters at: i) ].

	"[float32] * P - initial parameter values"

	"int32 - number of parameter names (N)"

	(1 to: numberOfParameterNames size) do: [ :i | 
		int8Array add: (numberOfParameterNames at: i) ].

	"int32 - number of unit generators (U)"

	1 to: numberOfUGens size do: [ :i | 
	int8Array add: (numberOfUGens at: i) ].

	"int16 - number of variants (V)"

	1 to: numberOfVariants size do: [ :i | 
	int8Array add: (numberOfVariants at: i) ].



	^ int8Array
]

{ #category : #accessing }
SynthDef >> graph: anUGenGraph [ 
	graph := anUGenGraph 
]

{ #category : #initialization }
SynthDef >> initialize [

	super initialize.
	defname := 'a'.
	numberOfConstants := 0 asByteArrayOfSize: 4.
	numberOfParameters := 0 asByteArrayOfSize: 4.
	numberOfParameterNames := 0 asByteArrayOfSize: 4.
	numberOfUGens := 0 asByteArrayOfSize: 4.
	numberOfVariants := 0 asByteArrayOfSize: 2
]

{ #category : #accessing }
SynthDef >> name: aString [ 
	defname := aString
]

{ #category : #accessing }
SynthDef >> numberOfUGens [
^ numberOfUGens 
]

{ #category : #accessing }
SynthDef >> numberOfUGens: anInteger [
numberOfUGens := anInteger asByteArrayOfSize: 4
]
