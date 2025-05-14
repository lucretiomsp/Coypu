"
Peformer to play the Performance on the SuperDirt audio engine for SuperCollider.
"
Class {
	#name : 'PerformerSuperDirt',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'playing' }
PerformerSuperDirt >> play [
	"play the performance for almost 4 days at 120 bpm"
	self playDirtFor: fourDaysAt120BPM 
]

{ #category : 'playing' }
PerformerSuperDirt >> playDirt [

	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	
	performance bpm: 60 / (performance  freq * 4). 
	
	performance activeProcess: ([ 
		        "the perfrormance last 4 days at 120 bpm"
	           fourDaysAt120BPM  timesRepeat: [ 
		  
		           "sequencers scan"
		           [ 
		           performance  valuesDo: [ :seq | 
			           (seq gates wrap: performance transportStep) = 1
				           ifTrue: [ 
					           seq playFullDirtEventAt: seq noteIndex  "delta!!!!" .
					           "increment note Index"
					           seq noteIndex: seq noteIndex + 1 ]
				            ] ] forkAt: Processor timingPriority.

		           "step is incremented anyway"
		           performance  incrementTransportStep ] ] forkAt: Processor timingPriority).



]

{ #category : 'playing' }
PerformerSuperDirt >> playDirtFor: aNumberOfSteps [

	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"


	
	performance bpm: 60 / (performance freq * 4). 
	performance transportStep: 1.
	performance activeProcess: ([ 
	           aNumberOfSteps timesRepeat: [ 
		           (Delay forSeconds: performance freq) wait.
		           "sequencers scan"
		           [ 
		           performance valuesDo: [ :seq | 
			           (seq gates wrap: performance transportStep) = 1
				           ifTrue: [ 
					           seq playFullDirtEventAt: seq noteIndex  .
					           "increment note Index"
					           seq noteIndex: seq noteIndex + 1 ]
				            ] ] forkAt: Processor timingPriority.

		           "step is incremented anyway"
		           performance incrementTransportStep ] ] forkAt: Processor timingPriority).


	
]

{ #category : 'accessing' }
PerformerSuperDirt >> playEventAt: anIndex in: aSequencer [
	"sends a mesaage to SuperDirt with all the desired OSC arguments and values"

	| message dur stepDuration |
	stepDuration := Performance uniqueInstance freq asFloat.
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := aSequencer durations asDirtArray wrap: anIndex.

	message
		add: 'delta';
		add: (stepDuration * dur) asFloat. "delta should change"
	aSequencer dirtMessage keysAndValuesDo: [ :key :value |
		message
			add: key;
			add: (value asDirtArray wrap: anIndex) ].



	(OSCBundle for: { (OSCMessage for: message) })
		sendToAddressString: '127.0.0.1'
		port: 57120.
	^ true
]
