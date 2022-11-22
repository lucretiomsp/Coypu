Class {
	#name : #UGen,
	#superclass : #AbstractFunction,
	#instVars : [
		'synthDef',
		'rate',
		'uGenName',
		'specialIndex',
		'synthIndex',
		'calculationRate',
		'inputs',
		'outputs',
		'numberOfInputs',
		'numberOfConstants',
		'constantValues',
		'constants',
		'antecedents',
		'descendants',
		'widthFirstAntecedents',
		'outputIndex',
		'aggregatedInputs'
	],
	#classInstVars : [
		'buildSynthDef',
		'synthDef'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
UGen class >> multiNew: arguments [

^ self multiNewList 
]

{ #category : #'instance creation' }
UGen class >> multiNewList [
]

{ #category : #'instance creation' }
UGen class >> multiNewList: arguments [

	| size args newArgs results |
	size := 0.
	args := arguments asUGenInputFor: self.

	^ results
]

{ #category : #'as yet unclassified' }
UGen >> => anUGen [

	^ UGensGraphFunc new numberOfUGens: 2
]

{ #category : #accessing }
UGen >> aggregatedInputs [
^ aggregatedInputs 
]

{ #category : #accessing }
UGen >> aggregatedInputs: anInteger [

aggregatedInputs := anInteger.
]

{ #category : #accessing }
UGen >> antecedents [
^ antecedents 
]

{ #category : #'as yet unclassified' }
UGen >> ar [ 
"set calculation rate to audio rate"
calculationRate := 2.
]

{ #category : #writeDefinition }
UGen >> assignTo: aSynthDef [
"my implementation to assign the UGen to a SynthDef"

synthDef := aSynthDef .
]

{ #category : #accessing }
UGen >> assignedSynthDef [
^ synthDef 
]

{ #category : #accessing }
UGen >> calculationRate [

	^ calculationRate
]

{ #category : #accessing }
UGen >> calculationRate: anObject [

	calculationRate := anObject
]

{ #category : #writeDefinition }
UGen >> collectConstants [ 
inputs do: [ :input | input isNumber ifTrue: [synthDef addConstant: input asFloat] ]


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

{ #category : #accessing }
UGen >> descendants [
^ descendants 
]

{ #category : #writeDefinition }
UGen >> dumpName [

^ self synthIndex asString , '_' , self class name asString.
]

{ #category : #writeDefinition }
UGen >> initTopoSort [

	"topological sort of UGens, taken from SUperCollider"

	inputs do: [ :input | 
		input isUGen ifTrue: [ 
			self antecedents add: input source.
			input source descendants add: self ] ].

	widthFirstAntecedents ifNotNil: [ 
		widthFirstAntecedents do: [ :ugen | 
			antecedents add: ugen.
			ugen descendants add: self ] ]
]

{ #category : #initialization }
UGen >> initialize [

	super initialize.
	inputs := Array new.
	outputs := Dictionary new.
	constants := Dictionary new.
	rate := #audio.
	specialIndex := 0.
	synthIndex := -1.
	outputIndex := 0.
  antecedents := Set new.
  descendants := Set new.
	"this may be temporary : source should be a member of Output Proxy"
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

{ #category : #writeDefinition }
UGen >> makeAvailable [

	antecedents size = 0 ifTrue: [ " synthDef.available = synthDef.available.add(this) "
		synthDef available: (synthDef available  traceCr "add: self")
		 ]
]

{ #category : #accessing }
UGen >> numInputs [

^ inputs size
]

{ #category : #accessing }
UGen >> numOutputs [

^ outputs  size
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

{ #category : #writeDefinition }
UGen >> optimizeGraph [ 
"empty method in SuperCollider !?!?!"
]

{ #category : #accessing }
UGen >> outputIndex [

	^ 0
]

{ #category : #accessing }
UGen >> outputs [

	^ outputs
]

{ #category : #accessing }
UGen >> rate [ 

" rate can be:
#audio #control #scalar #trigger
"
^ rate 
]

{ #category : #accessing }
UGen >> rateNumber [

	| arrayOfRates |
	arrayOfRates := #( #control #audio #demand ).
	^ arrayOfRates indexOf: self rate.
]

{ #category : #writeDefinition }
UGen >> removeAntecedents: anUGen [

antecedents remove: anUGen. 
self makeAvailable 
]

{ #category : #writeDefinition }
UGen >> schedule: anOutStack [

	descendants reverseDo: [ :ugen | ugen removeAntecedents: self ].
	
   ^ anOutStack add: self
]

{ #category : #accessing }
UGen >> setAntecedents [

	antecedents := Set new
]

{ #category : #accessing }
UGen >> setDescendants [

descendants := Set new.
]

{ #category : #accessing }
UGen >> source [
"source is a member of the OutputProxy class in SuperCollider"
	^ self
]

{ #category : #accessing }
UGen >> specialIndex [

	^ specialIndex
]

{ #category : #accessing }
UGen >> synthIndex [
^ synthIndex 
]

{ #category : #accessing }
UGen >> synthIndex: anInteger [

synthIndex := anInteger
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

{ #category : #accessing }
UGen >> widthFirstAntecedents [

^ widthFirstAntecedents
]

{ #category : #accessing }
UGen >> widthFirstAntecedents: aWidth [

	widthFirstAntecedents := aWidth 
]

{ #category : #writeDefinition }
UGen >> writeDef: int8Array [

	int8Array
		addAll: self class name asPString;
		add: self rateNumber;
		addAll: (self numInputs asByteArrayOfSize: 4);
		addAll: (self numOutputs asByteArrayOfSize: 4);
		addAll: (self specialIndex asByteArrayOfSize: 2).

	inputs do: [ :input | 
		int8Array addAll: (input writeInputSpec) ].
	self writeOutputSpec: int8Array.


	^ int8Array
]

{ #category : #writeDefinition }
UGen >> writeInputSpec [

	| int8Array |
	int8Array := OrderedCollection new.
	int8Array addAll: (self synthIndex asByteArrayOfSize: 4).
	int8Array addAll: (self outputIndex asByteArrayOfSize: 4).
	^ int8Array
]

{ #category : #writeDefinition }
UGen >> writeInputSpec: aSynthDef [
" should we use this?"
	| int8Array |
	int8Array := OrderedCollection new.
	int8Array addAll: (self synthIndex asByteArrayOfSize: 4).
	int8Array addAll: (self outputIndex asByteArrayOfSize: 4).
	^ int8Array
]

{ #category : #writeDefinition }
UGen >> writeOutputSpec: int8Array [

	"original SuperCollider method write to a file, not to an OrderedCollection, which I called int8Array"

	int8Array add: self rateNumber
]
