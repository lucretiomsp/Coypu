"
The Performer selects the audio backend.
PerformerKyma for Symbolic SoundKyma.
PerformerLocal for a local OSC backend (FAUST, ChucK, PureData, Max/MSP - just to name a few)
PerformerSuperDirt for the SuperDirt audio engine, a SuperCollider quark which is usually controlled by TidalCycles
"
Class {
	#name : 'Performer',
	#superclass : 'Object',
	#instVars : [
		'performance',
		'freq',
		'fourDaysAt120BPM',
		'transport',
		'nextTargetMicros'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'playing' }
Performer >> advanceTransportInBackground [

 [performance incrementTransportStep ] forkAt:
			 Processor timingPriority
]

{ #category : 'playing' }
Performer >> advanceTransportInBackgroundFor: aNumberOfSteps [

	| updateInterval |
	updateInterval := Delay forSeconds: performance freq.
[
    aNumberOfSteps timesRepeat: [  | targetTime |
        performance incrementTransportStep.
        
        "High-precision wait using Smalltalk highResClock"
      
        targetTime := Smalltalk highResClock + (updateInterval asMicroseconds * 1000).
        [Smalltalk highResClock < targetTime] whileTrue. "Busy-wait"
    ]
] forkAt: Processor highestPriority.
	"[
	aNumberOfSteps timesRepeat: [
		performance incrementTransportStep.
		updateInterval wait ] ] forkAt: Processor timingPriority"
]

{ #category : 'playing' }
Performer >> checkStepFor: aSequencer [

	| currentStep |
	currentStep := Performance uniqueInstance transportStep.
	(aSequencer gates wrap: currentStep) = 1 ifTrue: [ self playNoteFor: aSequencer ]
]

{ #category : 'LiveCoding-ExtraParams' }
Performer >> index: aStringOrAnArray to: aSequencer [
aSequencer extra: #Index values: aStringOrAnArray asDirtArrayOfValues.

]

{ #category : 'initialization' }
Performer >> initialize [ 
	super initialize.
	performance := Performance uniqueInstance.
	freq := performance freq.
	fourDaysAt120BPM := 4 days asMilliSeconds / ((60/ 120) /4).
	transport := Transport new.
]

{ #category : 'LiveCoding-ExtraParams' }
Performer >> level: aStringOrAnArray to: aSequencer [

	aSequencer extra: #ULevel values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'accessing' }
Performer >> nextTargetMicros [

^ nextTargetMicros 
]

{ #category : 'accessing' }
Performer >> nextTargetMicros: aMicroSecondsValue [

nextTargetMicros := aMicroSecondsValue 
]

{ #category : 'accessing' }
Performer >> performance [
^ performance
]

{ #category : 'playing' }
Performer >> play [

	self playFor: fourDaysAt120BPM
]

{ #category : 'playing' }
Performer >> playCyclicFor: aNumberOfCycles [
   
    | cycleMicros startMicros cycleStart waitNextCycle |
    startMicros := Time microsecondClockValue.
    performance activeProcess: ([
        1 to: aNumberOfCycles do: [ :cycleIndex |
            cycleMicros := (performance freq * 1_000_000 * 4) asInteger.
            cycleStart := startMicros + ((cycleIndex - 1) * cycleMicros).
            performance valuesDo: [ :seq |
                | events |
                events := seq queryFrom: 0 to: 1.
                events do: [ :event |
                    | eventMicros |
                    eventMicros := cycleStart + (event onset * cycleMicros) asInteger.
                    [
                        | waitMicros |
                        waitMicros := eventMicros - Time microsecondClockValue max: 0.
                        (Delay forMilliseconds: waitMicros // 1000) wait.
                        self playEventAt: event value in: seq
                    ] forkAt: Processor timingPriority - 2 ] ].
            waitNextCycle := (cycleStart + cycleMicros) - Time microsecondClockValue max: 0.
            (Delay forMilliseconds: waitNextCycle // 1000) wait ]
    ] forkAt: Processor timingPriority - 1)
]

{ #category : 'accessing' }
Performer >> playEventAt: anIndex in: aSequencer [

self subclassResponsibility 
]

{ #category : 'playing' }
Performer >> playFor: aNumberOfSteps [

	| nextStepMicros stepMicros nowMicros waitMicros waitMillis startMicros |
	"Initial BPM (will update automatically when freq changes)"
	

	performance bpm: 60 / (performance freq * 4).
	performance transportStep: 0.

	"Monotonic baseline time"
	startMicros := Time microsecondClockValue.
	performance activeProcess: ([
			 nextStepMicros := startMicros.

			 1 to: aNumberOfSteps do: [ :stepIndex | "Recompute step duration dynamically"
					 stepMicros := (performance freq * 1_000_000) asInteger.

					 "Accumulate next timestamp"
					 nextStepMicros := nextStepMicros + stepMicros.

					 nowMicros := Time microsecondClockValue.
					 waitMicros := nextStepMicros - nowMicros max: 0.
					 waitMillis := waitMicros // 1000.

					 "Sequencer scan"
					 (Delay forMilliseconds: waitMillis) wait.

					 [
						 performance valuesDo: [ :seq |
								 (seq gates wrap: performance transportStep) = 1 ifTrue: [
										 self playEventAt: seq noteIndex in: seq.

										 "increment note Index"
										 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor timingPriority - 2.

					 "step is incremented anyway" performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority - 1)
]

{ #category : 'playing' }
Performer >> playNote [

	self subclassResponsibility
]

{ #category : 'playing' }
Performer >> playNoteFor: aSequencer [

	self subclassResponsibility
]

{ #category : 'initialization' }
Performer >> resetPerformance [

performance bpm: 60 / (performance freq * 4).
			performance transportStep: 0.
			
]

{ #category : 'accessing' }
Performer >> waitMillis [


			  "Get current tempo dynamically every step"
    | stepMicros nowMicros waitMicros waitMillis |
stepMicros := (performance freq * 1_000_000) asInteger.

    "Add this step's duration to the accumulator"
    nextTargetMicros := nextTargetMicros + stepMicros.

    nowMicros := Time microsecondClockValue.
    waitMicros := (nextTargetMicros - nowMicros) max: 0.
    waitMillis := waitMicros // 1000.

^ waitMillis
]
