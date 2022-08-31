Class {
	#name : #SynthDef,
	#superclass : #Object,
	#category : #'PharoCollider-SynthDef'
}

{ #category : #converting }
SynthDef >> asBytes [
	| int8Array SCgf version def defname numberOfConstants numberOfParameters numberOfParameterNames numberOfVariants numberOfUGens|
	int8Array := OrderedCollection new.
	"int32 - four byte file type id containing the ASCII characters: 'SCgf' "
	SCgf := 'SCgf' asByteArray.
	(1 to:  SCgf size ) do: [ :i | int8Array add: (SCgf at: i) ] .
	"int32 - file version, currently 2."
	version := #( 0 0 0 2). 
	( 1 to: version size) do: [ :i | int8Array add: (version at: i) ].
	"int16 - number of synth definitions in this file (D)."
	def := #(0 1 ). "for one definition"
	( 1 to: def size) do: [ :i | int8Array add: (def  at: i) ].
	"pstring - the name of the synth definition"
	defname := 0.
	int8Array addLast: defname .
	"int32 - number of constants (K)"
	numberOfConstants := #( 0 0 0 0).
	( 1 to: numberOfConstants size) do: [ :i | int8Array add: (numberOfConstants at: i) ].
	
	"[float32] * K - constant values"
	
	"int32 - number of parameters (P)"
    numberOfParameters := #( 0 0 0 0).
	( 1 to: numberOfParameters size ) do: [ :i | int8Array add: (numberOfParameters  at: i) ].
	
	"[float32] * P - initial parameter values"
	
	"int32 - number of parameter names (N)"
	 numberOfParameterNames := #( 0 0 0 0).
	( 1 to: numberOfParameterNames size ) do: [ :i | int8Array add: (numberOfParameterNames   at: i) ].
	
		"int32 - number of unit generators (U)"
	numberOfUGens  := #(0 0 0 0).
	( 1 to: numberOfUGens size ) do: [ :i | int8Array add: (numberOfUGens   at: i) ].
	
	"int16 - number of variants (V)"
	numberOfVariants := #(0 0 ).
	( 1 to: numberOfVariants size ) do: [ :i | int8Array add: (numberOfVariants   at: i) ].
	

	
^ int8Array 
]
