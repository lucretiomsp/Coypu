"
I am a test double for Random: I answer scripted values in order, cycling, so stochastic code can be tested deterministically.

	(GenScriptedRandom values: #( 0.1 0.9 )) next
"
Class {
	#name : 'GenScriptedRandom',
	#superclass : 'Object',
	#instVars : [
		'values',
		'index'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'instance creation' }
GenScriptedRandom class >> values: aCollection [

	^ self new
		  setValues: aCollection;
		  yourself
]

{ #category : 'accessing' }
GenScriptedRandom >> next [

	index := index \\ values size + 1.
	^ values at: index
]

{ #category : 'accessing' }
GenScriptedRandom >> nextInteger: anInteger [
	"Same contract as Random>>nextInteger:, an integer from 1 to anInteger."

	^ (self next * anInteger) truncated + 1
]

{ #category : 'initialization' }
GenScriptedRandom >> setValues: aCollection [

	values := aCollection asArray.
	index := 0
]
