Class {
	#name : #PharoColliderTests,
	#superclass : #TestCase,
	#category : #'PharoCollider-Tests'
}

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
PharoColliderTests >> testSynthDefCreateWith [

	| synthDefCase |
	synthDefCase := SynthDef with: #( #ugen1 #ugen2 #ugen3 ).
	self assert: synthDefCase numberOfUGens equals: #[ 0 0 0 3 ]
]

{ #category : #tests }
PharoColliderTests >> testSynthDefCreationWithUGensGraphFunc [

	| sDef uGen1 uGen2 |
	uGen1 := SinOsc new.
	uGen2 := Dac new.
	sDef := SynthDef with: { 
			        uGen1.
			        uGen2 }.

	self assert: sDef numberOfUGens equals: #[0 0 0 2 ]
]

{ #category : #tests }
PharoColliderTests >> testSynthDefNoNameNoUgensAsBytes [

	"returns th Int8 array with the SuperCollider SynthDefinition Format of a Synthef named 'a' and with noUgens nor controls "

	self
		assert: SynthDef new asBytes
		equals:
			#( 83 67 103 102 0 0 0 2 0 1 1 97 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 )
				asOrderedCollection
]

{ #category : #'as yet unclassified' }
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
newSynthDef := (SynthDef withName: 'x' graph: UGenGraph new).
	self
		assert: newSynthDef asBytes 
		equals:
			#( 83 67 103 102 0 0 0 2 0 1 1 120 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
			   0 0 ) asOrderedCollection
]

{ #category : #tests }
PharoColliderTests >> testUGenGraphFrom2Ugens [

self assert: (UGen new => UGen new ) equals: UGenGraph new.
]

{ #category : #tests }
PharoColliderTests >> testUGenIsInput [

| uGen1 uGen2 |
uGen2 := Control new.
uGen1 := SinOsc new freq: uGen2.


self assert: (uGen2 isInputOf: uGen1) equals: true
]
