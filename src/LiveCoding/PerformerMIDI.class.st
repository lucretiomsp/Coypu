"
Performer for external MIDI hardware
"
Class {
	#name : #PerformerMIDI,
	#superclass : #Performer,
	#category : #'LiveCoding-Performance'
}

{ #category : #playing }
PerformerMIDI >> play [
self shouldBeImplemented 
]

{ #category : #accessing }
PerformerMIDI >> playMIDISequenceAt: aRateInSeconds for: aNumberOfSteps on: aMIDISender [

	"test"

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through athe Performance containing arrays of numbers as values
keys in the Performance represents MIDI channels and must be written as #ch1 #ch2 #ch3 and so on if you want to send noteOn/off or

if you want to send out ccs
"

	| step bpm beatInSeconds gateTime |
	"as in early hardware sequencers, default gatetime is 80% of the step duration"
	bpm := 60 / (aRateInSeconds * 4).
	beatInSeconds := aRateInSeconds * 4.
	gateTime := aRateInSeconds * 0.8.
	step := 0.


	performance activeProcess: ([ "bpm toKyma: 'BPM'."" we dont do a visualization at the momentn""visualization startWith: bpm."
	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  performance values do: [ :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1 ifTrue: [ "noteIndex := noteIndex + 1."
						  value hasChords
							  ifFalse: [ 
								  aMIDISender
									  playDrum:
									  (value notes at: (value noteIndex modulo: value notesSize))
									  onChannel: value midiChannel ]
							  ifTrue: [ 
								  aMIDISender
									  playChord: 60
									  type: (Chord chordLists at:
											   (value chords at:
												    (value noteIndex modulo: value chords size)))
									  onChannel: value midiChannel
									  duration: 0.2 ].
						  "sends a ControlChange message on the same channel, if provided"
						  value extra1 notNil
							  ifTrue: [ 
								  aMIDISender
									  sendCC: (value extra1 at: 1)
									  withValue:
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size))
									  onChannel: value midiChannel ]
							  ifFalse: [ nil ].

						  "sends another ControlChange message on the same channel, if provided"
						  value extra2 notNil
							  ifTrue: [ 
								  aMIDISender
									  sendCC: (value extra2 at: 1)
									  withValue:
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size))
									  onChannel: value midiChannel ]
							  ifFalse: [ nil ].

						  "advance"
						  value noteIndex: value noteIndex + 1 ] ]
				  ifFalse: [ nil ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority)
]
