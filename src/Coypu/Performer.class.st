"
The Performer selects the audio backend.
PerformerKyma for Symbolic SoundKyma.
PerformerLocal for a local OSC backend (FAUST, ChucK, PureData, Max/MSP - just to name a few)
PerformerSuperDirt for the SuperDirt audio engine, a SuperCollider quark which is usually controlled by TidalCycles
"
Class {
	#name : 'Performer',
	#superclass : 'Object',
	#instVars : [
		'performance',
		'freq',
		'fourDaysAt120BPM'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'initialization' }
Performer >> initialize [ 
	super initialize.
	performance := Performance uniqueInstance.
	freq := performance freq.
	fourDaysAt120BPM := 4 days asMilliSeconds / ((60/ 120) /4)
]

{ #category : 'playing' }
Performer >> play [ 
	self subclassResponsibility 
]

{ #category : 'playing' }
Performer >> playFor: aNumberOfSteps [ 
	self subclassResponsibility 
]
