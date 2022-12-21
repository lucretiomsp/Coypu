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
		'func',
		'children',
		'controls',
		'controlNames',
		'allControlNames',
		'controlIndex',
		'constants',
		'constantsSet',
		'maxLocalBufs',
		'numberOfConstants',
		'parameters',
		'numberOfVariants',
		'constantValues',
		'numberOfUGens',
		'uGensGraphFunc',
		'available',
		'variants',
		'widthFirstUGens',
		'rewriteInProgress',
		'desc',
		'metadata'
	],
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'as yet unclassified' }
SynthDef class >> name: aString with: aCollectionOfUGens [

	^ self new
		  name: aString;
		  graph: aCollectionOfUGens;
		  finishBuild
]

{ #category : #'instance creation' }
SynthDef class >> with: aCollectionOfUGens [

	^ self new
		  graph: aCollectionOfUGens;
		  finishBuild
]

{ #category : #topoSorting }
SynthDef >> addConstant: aValue [
(constantsSet includes: aValue) not ifTrue: [ constantsSet add: aValue. constants at: aValue  put: constants size ]
]

{ #category : #topoSorting }
SynthDef >> addUGen: anUGen [

	" if (rewriteInProgress.isNil) "

	" we forget about this for now"

	anUGen synthIndex: children size.
	anUGen widthFirstAntecedents: widthFirstUGens copy.
	(' I AM ADDING UGEN' , anUGen class name asString) traceCr.
	self children add: anUGen
]

{ #category : #converting }
SynthDef >> asBytes [

	| int8Array SCgf version def |
	int8Array := OrderedCollection new.
	"int32 - four byte file type id containing the ASCII characters: 'SCgf' "
	SCgf := 'SCgf' asByteArray.
	int8Array addAll: SCgf.
	"int32 - file version, currently 2."
	version := #( 0 0 0 2 ).
	int8Array addAll: version.
	"int16 - number of synth definitions in this file (D)."
	def := #( 0 1 ). "for one definition"
	int8Array addAll: def.
	"pstring - the name of the synth definition"
	int8Array addAll: defname asPString.
	"int32 - number of constants (K)"
	int8Array addAll: (constants size asByteArrayOfSize: 4).
	"constant values"
	constants keys do: [ :item | 
		int8Array addAll: item asInt8ArrayOfSize4 ].
	"number of controls"
	int8Array addAll: (controls size asByteArrayOfSize: 4).
	"control values"
	controls do: [ :c | 
		int8Array addAll: (c values asByteArrayOfSize: 4) ].
	"control param names - maybe must be changed!"
	int8Array addAll: (controls size asByteArrayOfSize: 4).

	"param name and paramIndex"
	controls do: [ :c | 
		int8Array
			addAll: c paramName asPString;
			addAll: ((controls indexOf: c) - 1 asByteArrayOfSize: 4) ].
	" number of UGens"
	int8Array addAll: (self children size asByteArrayOfSize: 4).
	"UGens description"
	children do: [ :c | int8Array addAll: c asBytes ]. "must be implemented for UGens"
	" variants ?? for the moment we leave it to 0"
	int8Array addAll: (self variants asByteArrayOfSize: 2).
	"end"
	^ int8Array asArray
]

{ #category : #converting }
SynthDef >> asBytesDeprecated [

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



	^ int8Array asArray
]

{ #category : #converting }
SynthDef >> asBytesSCImplementation [

	"kind of like SC writeDef methods, using an ordered collection to store the result"

	| int8Array allControlNamesTemp allControlNamesMap |
	int8Array := OrderedCollection new. "??better to have fixed size array of 256?"
	int8Array add: defname asPString.
	int8Array add: (controls size asByteArrayOfSize: 4).
	controls do: [ :item | int8Array add: item ].

	allControlNamesTemp := allControlNames reject: [ :cn | 
		                       cn rate = #control ]. "!!!! originally = #nonControl !!!!!!"

	int8Array add: (allControlNamesTemp size asByteArrayOfSize: 4).
	allControlNamesTemp do: [ :item | 
		item name isNotNil ifTrue: [ 
			int8Array add: item name asPString.
			int8Array add: (item index asByteArrayOfSize: 4) ] ].

	int8Array add: children size.
	children do: [ :item | item writeDef: int8Array  ]
]

{ #category : #accessing }
SynthDef >> available [
^ available
]

{ #category : #accessing }
SynthDef >> available: anOrderedCollection [

	available := anOrderedCollection 
]

{ #category : #topoSorting }
SynthDef >> checkInputs [

"should be implementedMethods: "
	
]

{ #category : #accessing }
SynthDef >> children [
^ children
]

{ #category : #topoSorting }
SynthDef >> cleanupTopoSort [

	children isNotNil ifTrue: [ 
		children do: [ :ugen | 
			ugen setAntecedents.
			ugen setDescendants] ]
]

{ #category : #topoSorting }
SynthDef >> collectConstants [
children isNotNil ifTrue: [  children do: [ :ugen | ugen collectConstants ]]
]

{ #category : #accessing }
SynthDef >> constants [

	^ constants 
]

{ #category : #accessing }
SynthDef >> controls [
^ controls 
]

{ #category : #accessing }
SynthDef >> costantsSet [

^ constantsSet 
]

{ #category : #topoSorting }
SynthDef >> dumpUGens [

	self name traceCr.

	children do: [ :ugen | 
		(ugen dumpName , ', ' , ugen rate , ', '
		 , ', ' ,  ugen inputs asString) traceCr ]
]

{ #category : #topoSorting }
SynthDef >> finishBuild [

	"taken from SuperCollider implementation - last method to be call to get the SynthDf asBytes"

	self available: OrderedCollection new.

	"self optimizeGraph."
	self initTopoSort.
	self collectConstants.

	"self checkInputs. will die on error"

	"re-sort graph, topological REindex"

	self available: OrderedCollection new
	"self topologicalSort."

	"self indexUGens"

	"UGen buildSynthDef: nil"
]

{ #category : #accessing }
SynthDef >> graph [

^ uGensGraphFunc 
]

{ #category : #accessing }
SynthDef >> graph: aCollectionOfUGens [

	| tempCollection synthIndx |
	synthIndx := 0.
	controls := OrderedCollection new.
	tempCollection := Set new.
	aCollectionOfUGens do: [ :ug | 
		tempCollection add: ug.
		tempCollection addAll: (ug inputs reject: [ :inp | inp isUGen not ]) ].

	children := Array new: tempCollection size.
	tempCollection do: [ :ugen | 
		ugen isControl ifTrue: [ controls add: ugen ] ].
	tempCollection do: [ :ugen | 
		children at: ugen aggregatedInputs size + 1 put: ugen ].
	children do: [ :ugen | ugen assignTo: self . ugen synthIndex: synthIndx . synthIndx := synthIndx + 1].

	^ controls
]

{ #category : #accessing }
SynthDef >> graphDeprecated: aCollectionOfUGens [

	| synthIndx |
	synthIndx := 0.
	aCollectionOfUGens do: [ :ugen | 
		(children includes: ugen) not ifTrue: [ self addUGen: ugen ].

		"we must check the following part"
		uGensGraphFunc sortedUGens add: ugen.

		ugen inputs do: [ :inp | 
			inp isUGen & (uGensGraphFunc sortedUGens includes: inp) not 
				ifTrue: [ 
					uGensGraphFunc sortedUGens add: inp.
					children add: inp ] ] ].
	"corresponding to SuperCollider addUGens method of the SynthDef class
		"
		children do: [ :ugen | self addUGen: ugen ]
		" WE TRY !!!!!!!!"
	"children do: [ :ugen | 
		ugen assignTo: self.
		ugen synthIndex: synthIndx.
		ugen widthFirstAntecedents: self widthFirstUGens.
		('I AM DOING MY GRAPH JOB' , ugen synthIndex asString) traceCr.
		synthIndx := synthIndx + 1 ]"
]

{ #category : #'as yet unclassified' }
SynthDef >> graphNotWorking: aCollectionOfUGens [

	| synthIndx |
	synthIndx := 0.
	aCollectionOfUGens do: [ :ugen | 
		(children includes: ugen) not ifTrue: [ self addUGen: ugen ].

		"we must check the following part"
		uGensGraphFunc sortedUGens add: ugen.

		ugen inputs do: [ :inp | 
			inp isUGen & (uGensGraphFunc sortedUGens includes: inp) not 
				ifTrue: [ 
					uGensGraphFunc sortedUGens add: inp.
					children add: inp ] ] ].
	"corresponding to SuperCollider addUGens method of the SynthDef class
		"
	children do: [ :ugen | 
		ugen assignTo: self.
		ugen synthIndex: synthIndx.
		ugen widthFirstAntecedents: self widthFirstUGens.
		('I AM DOING MY GRAPH JOB' , ugen synthIndex asString) traceCr.
		synthIndx := synthIndx + 1 ]
]

{ #category : #topoSorting }
SynthDef >> indexUGens [

	" counting from 1 or from 0????"

	| index |
	index := 0.
	children traceCr.
	children ifNotNil: [children do: [ :ugen | ugen synthIndex: index . index := index + 1]]
]

{ #category : #topoSorting }
SynthDef >> initTopoSort [

	"initially topological sort, based on SuperCollider implementation"

	"available := nil."

children isNotNil ifTrue: [ 
		children do: [ :ugen | ugen makeAvailable ]].

" old "
"	children isNotNil ifTrue: [ 
		children do: [ :ugen | 
			ugen setAntecedents.
			ugen setDescendants ] ].
	children isNotNil ifTrue: [ 
		children do: [ :ugen | ugen initTopoSort ] ].
	children isNotNil ifTrue: [ 
		children reverseDo: [ :ugen | 
			ugen descendants asArray sort: [ :a :b | 
				a synthIndex < b synthIndex ].
			ugen makeAvailable all ugens with no antecedents are made available ] ] "
]

{ #category : #initialization }
SynthDef >> initialize [

	super initialize.
	"SuperCollider implementation"
	children := Array new.
	constants := Dictionary new.
	constantsSet := Set new.
	available := OrderedCollection new.
	controls := OrderedCollection new.
	controlIndex := 0.
	maxLocalBufs := 0.

	"my implementation"
	defname := 'a'.
	controlIndex := 0.
	uGensGraphFunc := UGensGraphFunc new.
	"define the sortBlock for the UGensGraphFunc"
	"uGensGraphFunc sortBlock: [ :a :b | a isInputOf: b ]."
	numberOfConstants := 0 asByteArrayOfSize: 4.
	parameters := OrderedCollection new.
	numberOfUGens := 0 asByteArrayOfSize: 4.
	numberOfVariants := 0 asByteArrayOfSize: 2.
	variants := 0.
]

{ #category : #accessing }
SynthDef >> name [
^ defname
]

{ #category : #accessing }
SynthDef >> name: aString [ 
	defname := aString
]

{ #category : #accessing }
SynthDef >> numberOfConstants [

| numOfConsts |

^ numOfConsts 
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

{ #category : #topoSorting }
SynthDef >> optimizeGraph [

	self initTopoSort.
	
	"children copy isNotNil ifTrue: [ 
		children copy do: [ :ugen | ugen optimizeGraph ] ]"

]

{ #category : #topoSorting }
SynthDef >> topologicalSort [

	| outStack |
	
	outStack := OrderedCollection new.
	self initTopoSort.

	[ available isNotEmpty ] whileTrue: [ 
		(available removeLast schedule:   outStack ) traceCr.
		"outStack := (available removeLast schedule: outStack) "].

	children := outStack.
	'in topological sort' traceCr.
	children traceCr.
	self cleanupTopoSort
]

{ #category : #accessing }
SynthDef >> variants [
^ variants
]

{ #category : #accessing }
SynthDef >> variants: anInteger [

	^ anInteger
]

{ #category : #accessing }
SynthDef >> widthFirstUGens [
^ widthFirstUGens 
]

{ #category : #accessing }
SynthDef >> widthFirstUGens: aWidthFirstUG [

	widthFirstUGens := aWidthFirstUG 
]
