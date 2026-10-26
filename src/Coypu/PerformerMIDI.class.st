"
Performer for external MIDI hardware
"
Class {
	#name : 'PerformerMIDI',
	#superclass : 'Performer',
	#instVars : [
		'channelMap'
	],
	#classInstVars : [
		'midiOut',
		'defaultChannels'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerMIDI class >> defaultChannelAt: aKey [

	^ (defaultChannels ifNil: [ Dictionary new ])
		  at: aKey
		  ifAbsent: [ self factoryChannels at: aKey ifAbsent: [ 1 ] ]
]

{ #category : 'accessing' }
PerformerMIDI class >> defaultChannels [
^ defaultChannels ifNil: [ defaultChannels := self factoryChannels ]
]

{ #category : 'accessing' }
PerformerMIDI class >> defaultChannels: anArrayOfAssociations [

	defaultChannels := anArrayOfAssociations asDictionary
]

{ #category : 'accessing' }
PerformerMIDI class >> factoryChannels [

	^ {
		  (#kick -> 1).
		  (#snare -> 2).
		  (#bass -> 3).
		  (#rim -> 4).
		  (#ch -> 5).
		  (#oh -> 6) .
(#pad -> 7) .
(#lead -> 8) .
(#vox -> 9) 	.	
			  (#perc -> 10) .
(#drums -> 11) .
(#percLoop -> 12) 	.	
		(#bassLoop -> 13) 	.	
				(#chordLoop -> 14) 	.	
		(#synthLoop -> 15) 	.	
		
		}
		
		
		 asDictionary
]

{ #category : 'accessing' }
PerformerMIDI class >> midiOut [

	^ midiOut
]

{ #category : 'accessing' }
PerformerMIDI class >> midiOut: aMIDISender [

	midiOut := aMIDISender 
]

{ #category : 'accessing' }
PerformerMIDI class >> resetDefaultChannels [

	defaultChannels := nil
]

{ #category : 'accessing' }
PerformerMIDI >> channelFor: aSequencer [

	| key |
	aSequencer midiChannel ifNotNil: [ :ch | ^ ch ].
	key := (aSequencer seqKey ifNil: [ ^ 1 ]) asSymbol.
	^ (channelMap ifNil: [ Dictionary new ])
		  at: key
		  ifAbsent: [ self class defaultChannelAt: key ]
]

{ #category : 'accessing' }
PerformerMIDI >> channels [
	"The effective map: class defaults overridden by this performer's entries."

	^ self class defaultChannels copy
		  addAll: (channelMap ifNil: [ Dictionary new ]);
		  yourself
]

{ #category : 'accessing' }
PerformerMIDI >> channels: anArrayOfAssociations [

	channelMap ifNil: [ channelMap := Dictionary new ].
	channelMap addAll: anArrayOfAssociations asDictionary
]

{ #category : 'LiveCoding-ExtraParams' }
PerformerMIDI >> index: aStringOrAnArray to: aSequencer [


	"add the index as ccvalue to ccnumber 20"
	aSequencer extra: 19 values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding-ExtraParams' }
PerformerMIDI >> level: aStringOrAnArray to: aSequencer [
	"add the index as ccvalue to ccnumber 7"

	aSequencer extra: 7  values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'playing' }
PerformerMIDI >> play [

	"play a Phaust performance for 4 days at 120 bpm"

	self playFor: fourDaysAt120BPM
]

{ #category : 'playing' }
PerformerMIDI >> playEventAt: anIndex in: aSequencer [

	| gateTime dur midiNote mch stepDuration midiSender  |
	freq := Performance uniqueInstance freq.
	gateTime := 0.9. "must be changeable"
	midiSender := self class midiOut.
	mch := self channelFor: aSequencer.
	stepDuration := Performance uniqueInstance freq.
	midiNote := aSequencer notes asDirtArray wrap: anIndex.
	dur := aSequencer durations asDirtArray wrap: anIndex.
	midiSender playNote: midiNote onChannel: mch duration: dur * freq * gateTime
]

{ #category : 'playing' }
PerformerMIDI >> playFor: aNumberOfSteps [


	| nextStepMicros nextClockMicros stepMicros clockMicros nowMicros waitMicros waitMillis startMicros |
	"Initial BPM (will update automatically when freq changes)"
	performance bpm: 60 / (performance freq * 4).
	performance transportStep: 0.

	"Monotonic baseline time"
	startMicros := Time microsecondClockValue.

	"===================================="
	"        MIDI CLOCK THREAD           "
	"===================================="
	[
		nextClockMicros := startMicros.

		1 to: aNumberOfSteps * 6 do: [ :i | "Recompute clock duration dynamically"
				clockMicros := (performance freq / 6 * 1_000_000) asInteger.

				"Accumulate next timestamp"
				nextClockMicros := nextClockMicros + clockMicros.

				nowMicros := Time microsecondClockValue.
				waitMicros := nextClockMicros - nowMicros max: 0.
				waitMillis := waitMicros // 1000.

				(Delay forMilliseconds: waitMillis) wait.

				self class midiOut sendClock ] ] forkAt: 78. "same priority you used"


	"Start the MIDI stream"
	self class midiOut sendStart.



	"===================================="
	"        TRANSPORT THREAD            "
	"===================================="
	performance activeProcess: ([
			 nextStepMicros := startMicros.

			 1 to: aNumberOfSteps do: [ :stepIndex | "Recompute step duration dynamically"
					 stepMicros := (performance freq * 1_000_000) asInteger.

					 "Accumulate next timestamp"
					 nextStepMicros := nextStepMicros + stepMicros.

					 nowMicros := Time microsecondClockValue.
					 waitMicros := nextStepMicros - nowMicros max: 0.
					 waitMillis := waitMicros // 1000.

					 (Delay forMilliseconds: waitMillis) wait.

					 [
						 performance valuesDo: [ :seq |
								 (seq gates wrap: performance transportStep) = 1 ifTrue: [
										 seq playMIDIEventAt: seq noteIndex.
										 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor highIOPriority.

					 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)
]
