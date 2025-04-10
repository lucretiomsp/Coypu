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
		'fourDaysAt120BPM',
		'transport'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'as yet unclassified' }
Performer >> advanceTransportInBackground [

 [performance incrementTransportStep ] forkAt:
			 Processor timingPriority
]

{ #category : 'as yet unclassified' }
Performer >> advanceTransportInBackgroundFor: aNumberOfSteps [

| updateInterval |
updateInterval := (Delay forSeconds: performance freq) .
	[
	aNumberOfSteps timesRepeat: [
		performance incrementTransportStep.
		updateInterval wait ] ] forkAt:
		Processor timingPriority
]

{ #category : 'as yet unclassified' }
Performer >> checkStepFor: aSequencer [

	| currentStep |
	currentStep := Performance uniqueInstance transportStep.
	(aSequencer gates wrap: currentStep) = 1 ifTrue: [ self playNote ]
]

{ #category : 'initialization' }
Performer >> initialize [ 
	super initialize.
	performance := Performance uniqueInstance.
	freq := performance freq.
	fourDaysAt120BPM := 4 days asMilliSeconds / ((60/ 120) /4).
	transport := Transport new.
]

{ #category : 'playing' }
Performer >> play [ 
	self subclassResponsibility 
]

{ #category : 'playing' }
Performer >> playFor: aNumberOfSteps [ 
	self subclassResponsibility 
]

{ #category : 'playing' }
Performer >> playNote [

	self subclassResponsibility
]

{ #category : 'initialization' }
Performer >> resetPerformance [

performance bpm: 60 / (performance freq * 4).
			performance transportStep: 0.
			
]
