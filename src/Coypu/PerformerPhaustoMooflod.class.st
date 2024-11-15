"
Special type of Performer deseigned ad hoc for the Mooflod experimental Performance
"
Class {
	#name : 'PerformerPhaustoMooflod',
	#superclass : 'Performer',
	#category : 'Coypu-Performance',
	#package : 'Coypu',
	#tag : 'Performance'
}

{ #category : 'playing' }
PerformerPhaustoMooflod >> play [ 
	"play a Phaust performance for 4 days at 120 bpm"

	self playFor: fourDaysAt120BPM 
]

{ #category : 'playing' }
PerformerPhaustoMooflod >> playFor: aNumberOfSteps [
	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	Performance uniqueInstance activeDSP
		ifNil: [
			^ Error new signal:
				  'There must be an active DSP for this performance' ]
		ifNotNil: [
			performance bpm: 60 / (performance freq * 4).
			performance transportStep: 0.
			performance activeProcess: ([
				 aNumberOfSteps timesRepeat: [
					 (Delay forSeconds: performance freq) wait.
					 "sequencers scan"
					 [
					 performance valuesDo: [ :seq |
						 (seq gates wrap: performance transportStep) = 1
							 ifTrue: [
								 seq playPhaustMooflodEventAt: seq noteIndex. "delta!!!!"
								 "increment note Index"
								 seq noteIndex: seq noteIndex + 1 ]
								 ] ] forkAt: Processor highIOPriority .

					 "step is incremented anyway"
					 performance incrementTransportStep ] ] forkAt:
					 Processor timingPriority) ]
]
