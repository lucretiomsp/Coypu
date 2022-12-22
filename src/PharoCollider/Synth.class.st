"
Corresponds to SuperCollider Snth class
"
Class {
	#name : #Synth,
	#superclass : #Object,
	#category : #'PharoCollider-SynthDef'
}

{ #category : #'as yet unclassified' }
Synth >> playDummySynth [

	{ '/s_new'. 'io'. 1001. 0. 0 } sendToSCServer
]
