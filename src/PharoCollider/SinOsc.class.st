"
1537+02:00 LiveCoding4Pharo10.0.image priorSource: 3085015
"
Class {
	#name : #SinOsc,
	#superclass : #PureUGen,
	#instVars : [
		'freq',
		'phase'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'accessing - structure variables' }
SinOsc >> freq [

	^ inputs at: 1
]

{ #category : #accessing }
SinOsc >> freq: aFloatOrAUGen [

	"frequency can be a float or a UGen, if it is a UGen, the constant is only phase"

	freq := aFloatOrAUGen. " ? "
	self addInput: aFloatOrAUGen  At: 1 
	
]

{ #category : #'accessing - structure variables' }
SinOsc >> initialize [

	"initialize ad Super Collider SinOSc at audiorate"

	super initialize.
	calculationRate := 2.

	outputs := #( #left ). "does this make sense?"
	inputs := Array with: 440.0 with: 0.0 "the initialized SinOsc has a frequency of 440hz and a phase of 0.0"
]

{ #category : #accessing }
SinOsc >> phase [

	^ inputs at: 2.
]

{ #category : #accessing }
SinOsc >> phase: aFloatOrAUGen [

	phase := aFloatOrAUGen.
	self addInput: aFloatOrAUGen At: 2
]
