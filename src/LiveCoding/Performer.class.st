"
The Performer selects the audio backend.
PerformerKyma for Symbolic SoundKyma.
PerformerLocal for a local OSC backend (FAUST, ChucK, PureData, Max/MSP - just to name a few)
PerformerSuperDirt for the SuperDirt audio engine, a SuperCollider quark which is usually controlled by TidalCycles
"
Class {
	#name : #Performer,
	#superclass : #Object,
	#instVars : [
		'performance',
		'freq'
	],
	#category : #'LiveCoding-Performance'
}

{ #category : #initialization }
Performer >> initialize [ 
super initialize .
performance :=  Performance uniqueInstance .
freq := performance freq.
]

{ #category : #playing }
Performer >> playDirtFor: aNumberOfSteps [

self subclassResponsibility 
]
