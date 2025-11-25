"
Performer for  a generic OSC audio client on port: 57142
"
Class {
	#name : 'PerformerLocal',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'playing' }
PerformerLocal >> play [

	self playFor: fourDaysAt120BPM  
]

{ #category : 'accessing' }
PerformerLocal >> playEventAt: anIndex in: aSequencer [

| aSequence gateTime value note |
aSequence key asString
								  toLocalAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.
]

{ #category : 'playing' }
PerformerLocal >> playFor: aNumberOfSteps [
	"play the performance with an external MIDI devices - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	"performance bpm: 60 / (performance freq * 4).
	performance transportStep: 0.
	performance activeProcess: ([
			 aNumberOfSteps timesRepeat: [
					 (Delay forSeconds: performance freq) wait.
					 ""sequencers scan""
					 [
						 performance valuesDo: [ :seq |
								 (seq gates wrap: performance transportStep) = 1 ifTrue: [
										 seq playLocalEventAt: seq noteIndex. ""delta!!!!""
										 ""increment note Index""
										 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor highIOPriority.

					 ""step is incremented anyway""
					 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)"

	| startTime stepMicros nextTargetMicros nowMicros waitMicros waitMillis |
	
	"Reset transport"
	performance transportStep: 0.

	"Start from monotonic clock (does not jump)"
	startTime := Time microsecondClockValue.

	performance activeProcess: ([
			 1 to: aNumberOfSteps do: [ :stepIndex | "Absolute target time for this step"
					  "Get current tempo dynamically every step"
    stepMicros := (performance freq * 1_000_000) asInteger.

    "Add this step's duration to the accumulator"
    nextTargetMicros := nextTargetMicros + stepMicros.

    nowMicros := Time microsecondClockValue.
    waitMicros := (nextTargetMicros - nowMicros) max: 0.
    waitMillis := waitMicros // 1000.


					 (Delay forMilliseconds: waitMillis) wait.

					 "Do work in separate high-priority task"
					 [
						 performance valuesDo: [ :seq |
								 (seq gates wrap: performance transportStep) = 1 ifTrue: [
										 seq playLocalEventAt: seq noteIndex.
										 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor highIOPriority.

					 "Advance transport"
					 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)
]

{ #category : 'accessing' }
PerformerLocal >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	"if the value in the dictionay is a Sequencer, an OSC message is sent to the key as OSC address with two arguments, one for the gate, and one for the note. the gate stays at 1 for the duration selected."

	| step bpm beatInSeconds gateTime |
	bpm := 60 / (aRateInSeconds * 4).
	gateTime := aRateInSeconds * 0.8.
	beatInSeconds := aRateInSeconds * 4.
	step := 0.

	performance activeProcess: ([ 
	  bpm toLocal: 'BPM/'.

	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  performance  keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ 
							  | note |
							  note := value notes at:
								          (value noteIndex modulo: value notesSize).
							  key asString
								  toLocalAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.


							  "experimental, for extra control parameter"
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toLocal:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].
							  value noteIndex: value noteIndex + 1 ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toLocal: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority)
]
