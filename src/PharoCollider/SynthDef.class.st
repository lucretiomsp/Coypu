Class {
	#name : #SynthDef,
	#superclass : #Object,
	#category : #PharoCollider
}

{ #category : #examples }
SynthDef class >> example1 [
| sdf |
sdf := OrderedCollection new. "sdf for SynthDefFile"

"int32 - four byte file type id containing the ASCII characters: SCgf"
sdf addAll: #(83 67 103 102). 

"int32  - file version  currently 2"
"int16 - number of synth definitions in this file (D)."




^ sdf
]

{ #category : #examples }
SynthDef class >> exampleWithName: aString [
| sdf |
sdf := OrderedCollection new. "sdf for SynthDefFile"

"int32 - four byte file type id containing the ASCII characters: SCgf"
sdf addAll: #(83 67 103 102). 
"int32  - file version  currently 2"
sdf addAll: #(0 0 0 2).
"int16 - number of synth definitions in this file (D)."
sdf addAll: #(0 1). "if just one synth definition"

"[ synth-definition ] * D / a synth-definition is :"

"pstring - the name of the synth definition - first size and then the charachters"
sdf add: aString size.
aString do: [ :i | sdf addLast: i asciiValue ].

"int32 - number of constants (K)"
sdf addAll: #(0 0 0 7) . "if for example we have 7 constants"

"[float32] * K - constant values"
"int32 - number of parameters (P)"
"[float32] * P - initial parameter values"
"int32 - number of parameter names (N)"



^ sdf
]
