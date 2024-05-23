"
Performer for  Symbolic Sound Kyma
"
Class {
	#name : #PerformerKyma,
	#superclass : #Performer,
	#category : #'Coypu-Performer'
}

{ #category : #playing }
PerformerKyma >> play [
self playKymaSequencFor: fourDaysAt120BPM 
]

{ #category : #playing }
PerformerKyma >> playFor: aNumberOfSteps [
	"with this method you can chane the Performance speed in real time! "

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| bpm |
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	performance resetAllSequencers. "reset all the sequencers"

	bpm := 60 / (performance freq * 4) bpm toKyma: 'BPM'.

	performance bpm: bpm.
	performance transportStep: 0.
	performance activeProcess: ([
		 aNumberOfSteps timesRepeat: [
			 (Delay forSeconds: performance freq) wait.
			 "sequencers scan"
			 [
			 performance valuesDo: [ :seq |
				
				 (seq gates wrap: performance transportStep) = 1
					 ifTrue: [
						 seq playFullKymaEventAt: seq noteIndex.
						 "increment note Index"
						 seq noteIndex: seq noteIndex + 1 ]
					 ifFalse: [ "performance transportStep" nil ] ] ] forkAt:
				 Processor timingPriority.

			 "step is incremented anyway"

			 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)
]

{ #category : #playing }
PerformerKyma >> playForOld: aNumberOfSteps [

"with this method you can chane the Performance speed in real time! "
	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| step bpm beatInSeconds gateTime |
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	performance resetAllSequencers. "reset all the sequencers"
	"as in early hardware sequencers, default gatetime is 80% of the step duration"


	step := 0.

performance  activeProcess: ([ 
	  bpm := 60 / (freq * 4).

	  gateTime := freq * 0.8.
	  beatInSeconds := freq * 4.
	  bpm toKyma: 'BPM'.


	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: freq) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  performance keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ 
							  | note |
							  note := value notes at:
								          (value noteIndex modulo: value notesSize).
							  key asString
								  toKymaAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.

							  "maybe this part is not useful anymore"
							  value durations isArray
								  ifTrue: [ 
									  (value durations at:
										   (value noteIndex modulo: value durationsSize)) toKyma:
										  key asString , 'Duration' ]
								  ifFalse: [ nil ].

							  "experimental, for extra control parameter"
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].

							  "new experimental, for second extra control"
							  value extra2 notNil
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ]
								  ifFalse: [ nil ].


							  value noteIndex: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toKyma: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority)
]

{ #category : #playing }
PerformerKyma >> playKymaSequencFor: aNumberOfSteps [

"with this method you can chane the Performance speed in real time! "
	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| step bpm beatInSeconds gateTime |
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	performance resetAllSequencers. "reset all the sequencers"
	"as in early hardware sequencers, default gatetime is 80% of the step duration"


	step := 0.

performance  activeProcess: ([ 
	  bpm := 60 / (freq * 4).

	  gateTime := freq * 0.8.
	  beatInSeconds := freq * 4.
	  bpm toKyma: 'BPM'.


	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: freq) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  performance keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ 
							  | note |
							  note := value notes at:
								          (value noteIndex modulo: value notesSize).
							  key asString
								  toKymaAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.

							  "maybe this part is not useful anymore"
							  value durations isArray
								  ifTrue: [ 
									  (value durations at:
										   (value noteIndex modulo: value durationsSize)) toKyma:
										  key asString , 'Duration' ]
								  ifFalse: [ nil ].

							  "experimental, for extra control parameter"
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].

							  "new experimental, for second extra control"
							  value extra2 notNil
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ]
								  ifFalse: [ nil ].


							  value noteIndex: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toKyma: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority)
]
