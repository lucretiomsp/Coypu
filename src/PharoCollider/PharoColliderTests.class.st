Class {
	#name : #PharoColliderTests,
	#superclass : #TestCase,
	#category : #'PharoCollider-Tests'
}

{ #category : #running }
PharoColliderTests >> setUp [

	super setUp.
	
	
	"Put here a common initialization logic for tests"
	"
	freqControl := Control new.
	oscillator := SinOsc new freq: freqControl .
	out := Dac new input: oscillator .
	ugGraphFunc := UGensGraphFunc with: { oscillator . out }.
	sDef := SynthDef withName: 'io' graph: ugGraphFunc  .
	"
]

{ #category : #tests }
PharoColliderTests >> testAddElementsOfArrayAsBytesToOrderedCollection [

	| array arrayOfBytes oc |
	array := #( 1 2 3 ).
	oc := OrderedCollection new addAll: #( 0 0 0 1 0 0 0 1 0 0 0 3 ).
	arrayOfBytes := (1 to: 3) collect: [ :i | (array at: i) asByteArrayOfSize: 4 ]
]

{ #category : #tests }
PharoColliderTests >> testArrayAsUGensGraphFunc [

| arr oscillator out|

oscillator := SinOsc new.
out := Out new.
arr := Array  with: oscillator with: out.

self assert: arr asUGensGraphFunc class equals: UGensGraphFunc 
]

{ #category : #tests }
PharoColliderTests >> testArrayWithBytesOfSize [

	self
		assert: ( #( 1 2 3 ) asArryaWithBytesOfSize:
		   4 )
		equals: (#( 0 0 0 1 0 0 0 2 0 0 0 3 ) asOrderedCollection )
]

{ #category : #utilityTests }
PharoColliderTests >> testAsBitsArray [


self assert: 8 asBitsArray equals: #(1 0 0 0)
]

{ #category : #utilityTests }
PharoColliderTests >> testAsBitsArrayOfSize [

self assert: (8 asBitsArrayOfSize: 8 ) equals: #( 0 0 0 0 1 0 0 0)
]

{ #category : #uGensTests }
PharoColliderTests >> testControlAsBytes [

	"at a first moment all Controls are at Conttrol rate, kr"

	| control result |
	result := #( 7 67 111 110 116 114 111 108 1 0 0 0 0 0 0 0  1 0 0 1 ). "UGen name" "kr" "0 inputs" "1 output" "special index" "output is kr"
	control := Control new.

	self assert: control asBytes equals: result
]

{ #category : #tests }
PharoColliderTests >> testControlCreationWithName [

	self assert: (Control newWithName: 'First') name equals: 'First'
]

{ #category : #tests }
PharoColliderTests >> testDacExists [

	self assert: Out new bus equals: 0.
	self assert: Out new input class equals: UGen
]

{ #category : #utilityTests }
PharoColliderTests >> testFloatAsInt8Array [

self assert: 440.0 asInt8ArrayOfSize4 equals: #(67 -36 0 0).
]

{ #category : #utilityTests }
PharoColliderTests >> testInt8Conversions [

self assert: 220 asInt8 equals: -36.
self assert: 92 asInt8 equals: 92
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
	output := Out new input: oscillator.

	s := SynthDef new: output.
	
self assert: s numberOfUGens   equals: 2
]

{ #category : #uGensTests }
PharoColliderTests >> testOutAsBytes [

	"at a first moment all Controls are at Conttrol rate, kr"

	| freqControl oscillator out sd result |
	result := #( 3 79 117 116 2 0 0 0 2 0 0 0 0 0 0 -1 -1 -1 -1 0 0 0 0 0
	             0 0 1 0 0 0 0 ).
	freqControl := Control newWithName: 'freq'.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
	sd := SynthDef new.
	sd graph: { 
			oscillator.
			out }.

	self assert: out asBytes equals: result
]

{ #category : #uGensTests }
PharoColliderTests >> testPureUGenIsUGenSubClass [

self assert: (PureUGen superclass) equals: UGen.
]

{ #category : #uGensTests }
PharoColliderTests >> testSinOscAsBytes [

	"at a first moment all Controls are at Control rate, kr"

	| freqControl oscillator out sd result |
	result := #( 6 83 105 110 79 115 99 2 0 0 0 2 0 0 0 1 0 0 0 0 0 0 0 0
	             0 0 -1 -1 -1 -1 0 0 0 0 2 ).
	freqControl := Control newWithName: 'freq'.
oscillator := SinOsc new freq: freqControl .
out := Out new input: oscillator.
sd := SynthDef new.
sd graph: { oscillator .out   }.

	self assert: oscillator asBytes equals: result
]

{ #category : #tests }
PharoColliderTests >> testSinOscExists [

	self assert: SinOsc new freq equals: 440.
	self assert: SinOsc new phase equals: 0.0.
	self assert: SinOsc new gain equals: 0.5
]

{ #category : #SinOscTests }
PharoColliderTests >> testSinOscIsPureUGen [

self assert: (SinOsc superclass ) equals: PureUGen 
]

{ #category : #SinOscTests }
PharoColliderTests >> testSinOscWriteDef [

	| int8Array expectedResult |
	int8Array := OrderedCollection new.
	expectedResult := #( 6 83 105 110 79 115 99 2 0 0 0 2 0 0 0 1 0 0 -1
	                     -1 -1 -1 0 0 0 0 -1 -1 -1 -1 0 0 0 1 2 ).

	self
		assert: (SinOsc new writeDef: int8Array)
		equals: expectedResult asDirtArray
]

{ #category : #tests }
PharoColliderTests >> testStringAsPString [

	"SuperCollider pascal format string: a byte (an unsigned int8) giving the length followed by that many bytes"

	self assert: 'io' asPString equals: #[2 105 111]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefAsBytes [

	| bytes sDef oscillator out freqControl |
	freqControl := Control newWithName: 'freq'.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
	sDef := SynthDef name: 'io' with: { 
			        oscillator.
			        out }.

	bytes := #( 83 67 103 102 
	0 0 0 2 
	0 1 
	2 105 111 
	0 0 0 1 
	0 0 0 0 
	0 0 0 1 
	0 0 0 0 
	0 0 0 1 
	4 102 114 101 113 
	0 0 0 0 
	0 0 0 3 
	7 67 111 110 116 114 111 108
	1 
	0 0 0 0 
	0 0 0 1 
	0 0 
	1 
	6 83 105 110 79 115 99 
	2 
	0 0 0 2 
	0 0 0 1 
	0 0 0 0 
	0 0 
	0 0 0 0 
	-1 -1 -1 -1 
	0 0 0 0 
	2 
	3 79 117 116 
	2 
	0 0 0 2 
	0 0 0 0 
	0 0 
	-1 -1 -1 -1 
	0 0 0 0 
	0 0 0 1 
	0 0 0 0 
	0 0 ). "SCgf" "version" "number of synth defs" "io defname" "number of constants" "only costant is 0" "number of params" "param initial value" "number of param names" "param name (1st only) = freq" "param index" "number of UGens" "UGen name (Control)" "kontrol Rate" "inputs" "outputs" "special index" " OUTPUT is KontrolRate" "UGen name SinOsc" "AudioRate" "inputs" "outputs" "special index" "1st input index of UGen --> Control" "1st input -- index of Control's output = 0 (1st, only Control output " "2nd input (SinOSc phase) = 0xFFFFFFFF = -1 --> constant" "use the first constant" "output = AudioRate" "UGen name Out" "AudioRate" "inputs" "ouputs" "special index" "value of 1st input = constant" "constant index 0 " "2nd input comes from UGen 1 = SinOsc" "1st output from SinOsc" "num variants = 0"


	self assert: sDef asBytes equals: bytes
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefAsBytesSCImplementation [

	| bytes sDef oscillator out freqControl |
	freqControl := Control new name: 'Control'.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
	sDef := SynthDef withName: 'io' graph: { 
			        oscillator.
			        out }.

	bytes := #( 83 67 103 102 0 0 0 2 0 1 2 105 111 0 0 0 1 0 0 0 0 0 0 0
	            1 0 0 0 0 0 0 0 1 4 102 114 101 113 0 0 0 0 0 0 0 3 7 67
	            111 110 116 114 111 108 1 0 0 0 0 0 0 0 1 0 0 1 6 83 105
	            110 79 115 99 2 0 0 0 2 0 0 0 1 0 0 0 0 0 0 0 0 0 0 -1 -1
	            -1 -1 0 0 0 0 2 3 79 117 116 2 0 0 0 2 0 0 0 0 0 0 -1 -1
	            -1 -1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 ). "SCgf" "version" "number of synth defs" "io defname" "number of constants" "only costant is 0" "number of params" "param initial value" "number of param names" "param name (1st only) = freq" "param index" "number of UGens" "UGen name (Control)" "kontrol Rate" "inputs" "outputs" "special index" " OUTPUT is KontrolRate" "UGen name SinOsc" "AudioRate" "inputs" "outputs" "special index" "1st input index of UGen --> Control" "1st input -- index of Control's output = 0 (1st, only Control output " "2nd input (SinOSc phase) = 0xFFFFFFFF = -1 --> constant" "use the first constant" "output = AudioRate" "UGen name Out" "AudioRate" "inputs" "ouputs" "special index" "value of 1st input = constant" "constant index 0 " "2nd input comes from UGen 1 = SinOsc" "1st output from SinOsc" "num variants = 0"


	self assert: sDef asBytesSCImplementation  equals: bytes
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
	uGen2 := Out new.
	sDef := SynthDef with: { 
			        uGen1.
			        uGen2 }.

	self assert: sDef numberOfUGens equals: #[0 0 0 2 ]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefFixedSinOSc [

	| bytes sDef oscillator out |
	oscillator := SinOsc new freq: 220.
	out := Out new input: oscillator.
	sDef := SynthDef name: 'io' with: { 
			        oscillator.
			        out }.

	bytes := #( 83 67 103 102 0 0 0 2 0 1 2 105 111 0 0 0 2 67 92 0 0 0 0
	            0 0 0 0 0 0 0 0 0 0 0 0 0 2 6 83 105 110 79 115 99 2 0 0
	            0 2 0 0 0 1 0 0 -1 -1 -1 -1 0 0 0 0 -1 -1 -1 -1 0 0 0 1 2
	            3 79 117 116 2 0 0 0 2 0 0 0  0 0 0 -1 -1 -1 -1 0 0 0 1
	            0 0 0 0 0 0 0 0 0 0 ). "SCgf" "version" "number of synth defs" "io defname" "number of constants" "only costant is 0" "number of params" "param initial value" "number of param names" "param name (1st only) = freq" "param index" "number of UGens" "UGen name (Control)" "kontrol Rate" "inputs" "outputs" "special index" " OUTPUT is KontrolRate" "UGen name SinOsc" "AudioRate" "inputs" "outputs" "special index" "1st input index of UGen --> Control" "1st input -- index of Control's output = 0 (1st, only Control output " "2nd input (SinOSc phase) = 0xFFFFFFFF = -1 --> constant" "use the first constant" "output = AudioRate" "UGen name Out" "AudioRate" "inputs" "ouputs" "special index" "value of 1st input = constant" "constant index 0 " "2nd input comes from UGen 1 = SinOsc" "1st output from SinOsc" "num variants = 0"


	self assert: sDef asBytes equals: bytes
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
	out := Out new input: oscillator .
	uFunc := { oscillator . out }.
	sDef := SynthDef withName: 'io' graph: uFunc .
	
self assert: sDef numberOfConstants equals: #[0 0 0 1]
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefTopoSortBasic [

	| sDef oscillator out freqControl |
	freqControl := Control new name: 'Control'.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
	sDef := SynthDef with: { 
			        oscillator.
			        out }.
	self
		assert: (sDef children asDirtArray at: 1) class name
		equals: #Control.
	self assert: (sDef children asDirtArray at: 2) class name equals: #SinOsc.
	self assert: (sDef children asDirtArray at: 3) class name equals: #Out
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefTopoSortBasicWithName [

	| sDef oscillator out freqControl |
	freqControl := Control new name: 'Control'.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
	sDef := SynthDef name: 'io' with: { 
			        oscillator.
			        out }.
	self
		assert: (sDef children asDirtArray at: 1) class name
		equals: #Control.
	self assert: (sDef children asDirtArray at: 2) class name equals: #SinOsc.
	self assert: (sDef children asDirtArray at: 3) class name equals: #Out
]

{ #category : #synthDefTesting }
PharoColliderTests >> testSynthDefuGensGraphFuncBasicSorting [

	| sDef uGensGraphFuncIsSorted oscillator out freqControl pos1 pos2 pos3|
	freqControl := Control new.
	oscillator := SinOsc new freq: freqControl.
	out := Out new input: oscillator.
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
newSynthDef := (SynthDef withName: 'x' graph: UGensGraphFunc new).
	self
		assert: newSynthDef asBytesDeprecated 
		equals:
			#( 83 67 103 102 0 0 0 2 0 1 1 120 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			   0 0 ) asOrderedCollection
]

{ #category : #uGensTests }
PharoColliderTests >> testUGenInputsUGen [

| s fc |
fc := Control newWithName: 'freq'.
s := SinOsc new freq: fc.

self assert: s inputsUGen equals: (Array with: fc)
]

{ #category : #tests }
PharoColliderTests >> testUGenIsInput [

| uGen1 uGen2 |
uGen2 := Control new.
uGen1 := SinOsc new freq: uGen2.


self assert: (uGen2 isInputOf: uGen1) equals: true
]

{ #category : #uGensTests }
PharoColliderTests >> testUGenName [

self assert: (SinOsc name) equals: 'SinOsc'.
]

{ #category : #synthDefTesting }
PharoColliderTests >> testUGenSpec [

| oscillator bytes|

oscillator := SinOsc new.
bytes := #( 6 83 105 110 79 115 99 "UGen name SinOsc" 2  "audio rate" 0 0 0 2 "inputs" 0 0 0 1 "output" 0 0 "special index"
-1 -1 -1 -1 "1st input is constant"  0 0 0 0 "index of 1st input" -1 -1 -1 -1 "2nd input is constant" 0 0 0 1 "indexo f second constant"
2 "audioRate"
 ).

self assert: oscillator uGenSpec equals: bytes. 
]

{ #category : #uGensTests }
PharoColliderTests >> testUGenSuperClassIsAbstractFunction [

self assert: (UGen superclass) equals: AbstractFunction
]

{ #category : #ugGraphFuncTesting }
PharoColliderTests >> testUGensGraphFuncSorting [

| freqControl oscillator out ugGraphFunc pos1 pos2 pos3 |

freqControl := Control new.
oscillator := SinOsc new freq: freqControl .
out := Out new input: oscillator .
ugGraphFunc := UGensGraphFunc with: { oscillator . out }.

pos1 := (ugGraphFunc   at: 1) = freqControl.
pos2 := (ugGraphFunc  at: 2) = oscillator  .
pos3 := (ugGraphFunc  at: 3) = out.
^ self assert: (pos1 & pos2 & pos3)  equals: true
]
