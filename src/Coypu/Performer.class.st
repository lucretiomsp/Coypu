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
	updateInterval := Delay forSeconds: performance freq.
[
    aNumberOfSteps timesRepeat: [  | targetTime |
        performance incrementTransportStep.
        
        "High-precision wait using Smalltalk highResClock"
      
        targetTime := Smalltalk highResClock + (updateInterval asMicroseconds * 1000).
        [Smalltalk highResClock < targetTime] whileTrue. "Busy-wait"
    ]
] forkAt: Processor highestPriority.
	"[
	aNumberOfSteps timesRepeat: [
		performance incrementTransportStep.
		updateInterval wait ] ] forkAt: Processor timingPriority"
]

{ #category : 'as yet unclassified' }
Performer >> checkStepFor: aSequencer [

	| currentStep |
	currentStep := Performance uniqueInstance transportStep.
	(aSequencer gates wrap: currentStep) = 1 ifTrue: [ self playNoteFor: aSequencer ]
]

{ #category : 'LiveCoding-ExtraParams' }
Performer >> index: aStringOrAnArray to: aSequencer [
aSequencer extra: #Index values: aStringOrAnArray asDirtArrayOfValues.

]

{ #category : 'initialization' }
Performer >> initialize [ 
	super initialize.
	performance := Performance uniqueInstance.
	freq := performance freq.
	fourDaysAt120BPM := 4 days asMilliSeconds / ((60/ 120) /4).
	transport := Transport new.
]

{ #category : 'LiveCoding-ExtraParams' }
Performer >> level: aStringOrAnArray to: aSequencer [

	aSequencer extra: #ULevel values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'accessing' }
Performer >> performance [
^ performance
]

{ #category : 'playing' }
Performer >> play [

	self playFor: fourDaysAt120BPM
]

{ #category : 'accessing' }
Performer >> playEventAt: anIndex in: aSequencer [

self subclassResponsibility 
]

{ #category : 'playing' }
Performer >> playFor: aNumberOfSteps [
	performance bpm: 60 / (performance freq * 4).
	performance transportStep: 0.
	performance activeProcess: ([
		 aNumberOfSteps timesRepeat: [
			 (Delay forSeconds: performance freq) wait.

			 "sequencers scan"
			 [
			 performance valuesDo: [ :seq |
				 (seq gates wrap: performance transportStep) = 1 ifTrue: [
					 self playEventAt:  seq noteIndex in: seq.

					 "increment note Index"
					 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
				 Processor timingPriority - 2.

			 "step is incremented anyway"

			 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority - 1)
]

{ #category : 'playing' }
Performer >> playNote [

	self subclassResponsibility
]

{ #category : 'playing' }
Performer >> playNoteFor: aSequencer [

	self subclassResponsibility
]

{ #category : 'initialization' }
Performer >> resetPerformance [

performance bpm: 60 / (performance freq * 4).
			performance transportStep: 0.
			
]
