"
Peformer to play the Performance on the SuperDirt audio engine for SuperCollider.
"
Class {
	#name : #PerformerSuperDirt,
	#superclass : #Performer,
	#category : #'LiveCoding-Performance'
}

{ #category : #playing }
PerformerSuperDirt >> playDirtFor: aNumberOfSteps [

	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	| process  |
	self freq: 132 bpm.
	bpm := 60 / (self freq * 4). 
	transportStep := 1.
	process := [ 
	           aNumberOfSteps timesRepeat: [ 
		           (Delay forSeconds: self freq) wait.
		           "sequencers scan"
		           [ 
		           self valuesDo: [ :seq | 
			           (seq gates wrap: transportStep) = 1
				           ifTrue: [ 
					           seq playFullDirtEventAt: seq noteIndex  "delta!!!!" .
					           "increment note Index"
					           seq noteIndex: seq noteIndex + 1 ]
				           ifFalse: [ nil ] ] ] forkAt: Processor timingPriority.

		           "step is incremented anyway"
		           self incrementTransportStep ] ] forkAt: Processor timingPriority.


	^ process
]
