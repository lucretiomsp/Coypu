"
Performer for Phausto. 
Phausto and its libraries must be loaded into your image.
Find Phausto here:
https://github.com/lucretiomsp/phausto
"
Class {
	#name : #PerformerPhaust,
	#superclass : #Performer,
	#category : #'Coypu-Performance'
}

{ #category : #playing }
PerformerPhaust >> play [ 
"play a Phaust performance for 4 days at 120 bpm"

self playFor: fourDaysAt120BPM 
]

{ #category : #playing }
PerformerPhaust >> playFor: aNumberOfSteps [
	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	Performance uniqueInstance activeDSP
		ifNil: [
			^ Error new signal:
				  'There must be an active DSP for this performance' ]
		ifNotNil: [
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
								 seq playPhaustEventAt: seq noteIndex. "delta!!!!"
								 "increment note Index"
								 seq noteIndex: seq noteIndex + 1]
							 ifFalse: [ nil ] ] ] forkAt: Processor timingPriority.

					 "step is incremented anyway"
					 performance incrementTransportStep ] ] forkAt:
					 Processor timingPriority) ]
]
