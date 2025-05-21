"
Performer for external MIDI hardware
"
Class {
	#name : 'PerformerMIDI',
	#superclass : 'Performer',
	#classInstVars : [
		'midiOut'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerMIDI class >> midiOut [

	^ midiOut
]

{ #category : 'accessing' }
PerformerMIDI class >> midiOut: aMIDISender [

	midiOut := aMIDISender 
]

{ #category : 'playing' }
PerformerMIDI >> play [

	"play a Phaust performance for 4 days at 120 bpm"

	self playFor: fourDaysAt120BPM
]

{ #category : 'accessing' }
PerformerMIDI >> playEventAt: anIndex in: aSequencer [

	| gateTime dur midiNote mch stepDuration midiSender freq |
	freq := Performance uniqueInstance freq.
	gateTime := 0.9. "must be changeable"
	midiSender := PerformerMIDI midiOut.
	mch := aSequencer midiChannel.
	stepDuration := Performance uniqueInstance freq.
	midiNote := aSequencer notes asDirtArray wrap: anIndex.
	dur := aSequencer durations asDirtArray wrap: anIndex.
	midiSender
		playNote: midiNote
		onChannel: mch
		duration: dur * freq * gateTime.

]

{ #category : 'playing' }
PerformerMIDI >> playFor: aNumberOfSteps [
	"play the performance with an external MIDI devices - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

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
						 seq playMIDIEventAt: seq noteIndex. "delta!!!!"
						 "increment note Index"
						 seq noteIndex: seq noteIndex + 1 ]
						 ] ] forkAt: Processor highIOPriority .

			 "step is incremented anyway"
			 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)
]
