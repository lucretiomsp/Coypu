Class {
	#name : #PharoColliderTests,
	#superclass : #TestCase,
	#category : #'PharoCollider-Tests'
}

{ #category : #'as yet unclassified' }
PharoColliderTests >> tesSynthDefOutAndSinOscWithNoControl [


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
PharoColliderTests >> testSinOscExists [

	self assert: SinOsc new freq equals: 440.
	self assert: SinOsc new phase equals: 0.0.
	self assert: SinOsc new gain equals: 0.5
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
