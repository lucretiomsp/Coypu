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

	"| midiClockInterval |
	performance bpm: 60 / (performance freq * 4).
	midiClockInterval := performance freq / 6.
	performance transportStep: 0.
	[
		aNumberOfSteps timesRepeat: [
				self class midiOut sendClock.
				14 milliSeconds wait ] ] forkAt: 78.
	self class midiOut sendStart.
	performance activeProcess: ([
			 aNumberOfSteps timesRepeat: [
					 (Delay forSeconds: performance freq) wait. ""sequencers scan""
					 [
						 performance valuesDo: [ :seq |
								 (seq gates wrap: performance transportStep) = 1 ifTrue: [
										 seq playMIDIEventAt: seq noteIndex. ""delta!!!!"" ""increment note Index""
										 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor highIOPriority. ""step is incremented anyway""
					 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)"

	" ######################### MONOTONIC CLOCK"

	"play the performance with an external MIDI devices - default freq is 132 bpm.
    Performance speed can be changed with p freq: a bpm"
| nextStepMicros nextClockMicros
  stepMicros clockMicros
  nowMicros waitMicros waitMillis
  startMicros |

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

    1 to: (aNumberOfSteps * 6) do: [:i |

        "Recompute clock duration dynamically"
        clockMicros := ((performance freq / 6) * 1_000_000) asInteger.

        "Accumulate next timestamp"
        nextClockMicros := nextClockMicros + clockMicros.

        nowMicros := Time microsecondClockValue.
        waitMicros := (nextClockMicros - nowMicros) max: 0.
        waitMillis := waitMicros // 1000.

        (Delay forMilliseconds: waitMillis) wait.

        self class midiOut sendClock.
    ].

] forkAt: 78.  "same priority you used"


"Start the MIDI stream"
self class midiOut sendStart.



"===================================="
"        TRANSPORT THREAD            "
"===================================="
performance activeProcess: (

    [
        nextStepMicros := startMicros.

        1 to: aNumberOfSteps do: [:stepIndex |

            "Recompute step duration dynamically"
            stepMicros := (performance freq * 1_000_000) asInteger.

            "Accumulate next timestamp"
            nextStepMicros := nextStepMicros + stepMicros.

            nowMicros := Time microsecondClockValue.
            waitMicros := (nextStepMicros - nowMicros) max: 0.
            waitMillis := waitMicros // 1000.

            (Delay forMilliseconds: waitMillis) wait.

            [
                performance valuesDo: [:seq |
                    (seq gates wrap: performance transportStep) = 1 ifTrue: [
                        seq playMIDIEventAt: seq noteIndex.
                        seq noteIndex: seq noteIndex + 1.
                    ].
                ].
            ] forkAt: Processor highIOPriority.

            performance incrementTransportStep.
        ].
    ] forkAt: Processor timingPriority
).

]
