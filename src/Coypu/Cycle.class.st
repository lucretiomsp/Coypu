"
Cycle represents a convenience class to hold information about cyclep playing, inspired by Tidal Cycles
"
Class {
	#name : #Cycle,
	#superclass : #Object,
	#classVars : [
		'duration'
	],
	#category : #'Coypu-Sequencers'
}

{ #category : #accessing }
Cycle class >> duration [

	^ duration 
]

{ #category : #initialization }
Cycle class >> initialize [


	"default speed for a Cycle inside the LiveCoding Package for Pharo is 132 bpm"
	self setDuration: 60 / 132 * 4
]

{ #category : #'as yet unclassified' }
Cycle class >> play: aSequencer on: aMIDISender for: aNumberOfCycles [

	"playMIDISequenceAt: aRateInSeconds steps: aNumberOfSteps on: aMIDISender"

	"test"

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through athe Performance containing arrays of numbers as values
keys in the Performance represents MIDI channels and must be written as #ch1 #ch2 #ch3 and so on if you want to send noteOn/off or

if you want to send out ccs
"

	| step gateTime |
	"as in early hardware sequencers, default gatetime is 80% of the step duration"
	gateTime := 0. "we dont use it for now"
	step := 0.


	^ [ 
	  aNumberOfCycles timesRepeat: [ 
		  (Delay forSeconds:
			   Cycle duration * (aSequencer cycleDurations at:
				    (step modulo: aSequencer cycleDurations size))) wait.



		  (aSequencer gates at: (step modulo: aSequencer gatesSize)) = 1 
			  ifTrue: [ 
				  aMIDISender
					  playDrum: (aSequencer notes at:
							   (aSequencer noteIndex modulo: aSequencer notesSize))
					  onChannel: aSequencer midiChannel.
				  "advance"
				  aSequencer noteIndex: aSequencer noteIndex + 1 ].


		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #accessing }
Cycle class >> setDuration: aDurationInseconds [

duration := aDurationInseconds 
]

{ #category : #initialization }
Cycle >> initialize [

	super initialize.
	self setDuration: 60 / 132 * 4
]

{ #category : #initialization }
Cycle >> setDuration: aDurationInSeconds [

	duration := aDurationInSeconds 
]
