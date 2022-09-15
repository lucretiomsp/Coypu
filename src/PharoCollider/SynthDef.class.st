"
Corresponds to SuperCollider client-side definition of a synth definition.
The core of a synthdef is its unit generator graph function (, here represented by an instance variable called uGensGraphFunc that is a Sorted Collection.

SynthDef tries to arrange the UGens in the uGensGraphFunc in  depth-first. It begins with the first UGen in the list of children that is taking no input from any other UGen. (If it isn’t taking input from another UGen, then there is no UGen that needs to be calculated before this one. Thus this UGen is eligible to go into the final ordering – “available,” in the code.).
Then it follows the input-output chain as far down as it can, before moving on to any other “available” UGens that hadn’t been resolved yet.

Usually we will find Control near the top because normally its outputs are feeding into other units, pushing those other units later in the order. (What’s the point of a Control that isn’t controlling anything?) But there is no rule that Controls must precede other units. The typical ordering is a consequence of normal usage, in which other units depend on data from Control, so those other units must follow after Control.
"
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
		'uGensGraphFunc'
	],
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'instance creation' }
SynthDef class >> with: aCollectionOfUGens [

	| uGensDumped uGensSet |
	"first collect all the inputs of all the UGens in the collection as a Set to avoid duplicate"
	uGensSet := Set new.
	aCollectionOfUGens do: [ :i | uGensSet addAll: i inputs ].
	uGensSet addAll: aCollectionOfUGens.
	"sort UGens "
	uGensDumped := SortedCollection new.
	uGensDumped sortBlock: [ :a :b | a isInputOf: b ].
	uGensSet do: [ :i | uGensDumped add: i ].
	^ self new graph: uGensDumped 
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
SynthDef >> graph [

^ uGensGraphFunc 
]

{ #category : #accessing }
SynthDef >> graph: anUGenGraph [

	uGensGraphFunc  := anUGenGraph
]

{ #category : #initialization }
SynthDef >> initialize [

	super initialize.
	defname := 'a'.
	uGensGraphFunc := SortedCollection new.
	"define the sortBlock for the UGensGraphFunc"
	"uGensGraphFunc sortBlock: [ :a :b | a isInputOf: b ]."
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

	| integerNumberOfUGens |
	
	integerNumberOfUGens := uGensGraphFunc size.
	^ integerNumberOfUGens  asByteArrayOfSize: 4 
]

{ #category : #accessing }
SynthDef >> numberOfUGens: anInteger [
numberOfUGens := anInteger asByteArrayOfSize: 4
]
