Class {
	#name : #PharoColliderTests,
	#superclass : #TestCase,
	#instVars : [
		'sDef',
		'ugGraphFunc',
		'oscillator',
		'out',
		'freqControl'
	],
	#category : #'PharoCollider-Tests'
}

{ #category : #running }
PharoColliderTests >> setUp [

	super setUp.
	
	
	"Put here a common initialization logic for tests"
	freqControl := Control new.
	oscillator := SinOsc new freq: freqControl .
	out := Dac new input: oscillator .
	ugGraphFunc := { oscillator . out }.
	sDef := SynthDef withName: 'io' graph: ugGraphFunc  .
]

{ #category : #tests }
PharoColliderTests >> testAddElementsOfArrayAsBytesToOrderedCollection [

	| array arrayOfBytes oc |
	array := #( 1 2 3 ).
	oc := OrderedCollection new addAll: #( 0 0 0 1 0 0 0 1 0 0 0 3 ).
	arrayOfBytes := (1 to: 3) collect: [ :i | (array at: i) asByteArrayOfSize: 4 ]
]

{ #category : #tests }
PharoColliderTests >> testArrayWithBytesOfSize [

	self
		assert: ( #( 1 2 3 ) asArryaWithBytesOfSize:
		   4 )
		equals: (#( 0 0 0 1 0 0 0 2 0 0 0 3 ) asOrderedCollection )
]

{ #category : #tests }
PharoColliderTests >> testControlCreationWithName [

	self assert: (Control newWithName: 'First') name equals: 'First'
]

{ #category : #tests }
PharoColliderTests >> testDacExists [

	self assert: Dac new bus equals: 0.
	self assert: Dac new input class equals: UGen
]

{ #category : #tests }
PharoColliderTests >> testMidiToFreq [ 
self assert: 69 midiToFreq equals: 440
]

{ #category : #tests }
PharoColliderTests >> testNumberUGensBasic [

	| s output oscillator fc |
	fc := Control new.
	oscillator := SinOsc new freq: fc.
	output := Dac new input: oscillator.

	s := SynthDef new: output.
	
self assert: s numberOfUGens   equals: 2
]

{ #category : #tests }
PharoColliderTests >> testSinOscExists [

	self assert: SinOsc new freq equals: 440.
	self assert: SinOsc new phase equals: 0.0.
	self assert: SinOsc new gain equals: 0.5
]

{ #category : #tests }
PharoColliderTests >> testStringAsPString [

	"SuperCollider pascal format string: a byte (an unsigned int8) giving the length followed by that many bytes"

	self assert: 'io' asPString equals: #[2 105 111]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefAsBytes [


	| bytes sDef |
	
	bytes := #( 83 67 103 102 "SCgf" 0 0 0 2 "version" 0 1 1 "number of synth defs" 0 0 0 1 "number of constants" 0 0 0 0 "only costant is 0" 0 0 0 1 "number of params" 0 0 0 0 "param initial value" 0 0 0 1 "number of param names" 
	4 102 114 101 113 "param name (1st only) = freq" 0 0 0 0 "param index"
	0 0 0 3 "number of UGens"
	7 67 111 110 116 114 111 108 "UGen name (Control)"
	1 "kontrol Rate"
	0 0 0 0 "inputs"
	0 0 0 1 "outputs"
	0 0 "special index"
	1 " OUTPUT US KontrolRate"
	
	6 83 105 110 79 115 99 "UGen name SinOsc"
	2 "AudioRate"
	0 0 0 2 "inputs"
	0 0 0 1 "outputs"
	0 0 "special index"
	0 0 0 0 "1st input index of UGen --> Control"
	0 0 0 0 "1st input -- index of Control's output = 0 (1st, only Control output "
	-1 -1 -1 -1 "2nd input (SinOSc phase) = 0xFFFFFFFF = -1 --> constant"
	0 0 0 0 "use the first constant"
	2 "output = AudioRate"
	
	3 79 117 116 "UGen name Out"
	2 "AudioRate"
	0 0 0 2 "inputs"
	0 0 0 0 "ouputs"
	0 0 "special index"
	-1 -1 -1 -1 "value of 1st input = constant"
	0 0 0 0 "constant index 0 "
	0 0 0 1 "2nd input comes from UGen 1 = SinOsc"
	0 0 0 0 "1st output from SinOsc"
	
	0 0 "num variants = 0"
	
	
	).

	
	self assert: sDef asBytesDeprecated equals: bytes 
	
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefCreateWith [

	| synthDefCase |
	synthDefCase := SynthDef with: #( #ugen1 #ugen2 #ugen3 ).
	self assert: synthDefCase numberOfUGens equals: #[ 0 0 0 3 ]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefCreationWithUGensGraphFunc [

	| sDef uGen1 uGen2 |
	uGen1 := SinOsc new.
	uGen2 := Dac new.
	sDef := SynthDef with: { 
			        uGen1.
			        uGen2 }.

	self assert: sDef numberOfUGens equals: #[0 0 0 2 ]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefNoNameNoUgensAsBytes [

	"returns th Int8 array with the SuperCollider SynthDefinition Format of a Synthef named 'a' and with noUgens nor controls "

	self
		assert: SynthDef new asBytesDeprecated
		equals:
			#( 83 67 103 102 0 0 0 2 0 1 1 97 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 )
				asOrderedCollection
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefNumberOfConstants [

| sDef freqControl oscillator out uFunc |
	freqControl := Control new.
	oscillator := SinOsc new freq: freqControl .
	out := Dac new input: oscillator .
	uFunc := { oscillator . out }.
	sDef := SynthDef withName: 'io' graph: uFunc .
	
self assert: sDef numberOfConstants equals: #[0 0 0 1]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefuGensGraphFuncBasicSorting [

	| sDef uGensGraphFuncIsSorted oscillator out freqControl pos1 pos2 pos3|
	freqControl := Control new.
	oscillator := SinOsc new freq: freqControl.
	out := Dac new input: oscillator.
	sDef := SynthDef with: { 
			        oscillator.
			        out }.
pos1 := (sDef graph at: 1) = freqControl.
pos2 := (sDef graph at: 2) = oscillator.
pos3 := (sDef graph at: 3) = out.
uGensGraphFuncIsSorted := pos1 & pos2 & pos3.
	self assert: uGensGraphFuncIsSorted equals: true
]

{ #category : #tests }
PharoColliderTests >> testSynthWithNameAndEmptyGraph [
| newSynthDef|
newSynthDef := (SynthDef withName: 'x' graph: UGenGraphFunc new).
	self
		assert: newSynthDef asBytesDeprecated 
		equals:
			#( 83 67 103 102 0 0 0 2 0 1 1 120 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			   0 0 ) asOrderedCollection
]

{ #category : #tests }
PharoColliderTests >> testUGenIsInput [

| uGen1 uGen2 |
uGen2 := Control new.
uGen1 := SinOsc new freq: uGen2.


self assert: (uGen2 isInputOf: uGen1) equals: true
]
