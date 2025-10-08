"
Performer for Phausto. 
Phausto and its libraries must be loaded into your image.
Find Phausto here:
https://github.com/lucretiomsp/phausto
"
Class {
	#name : 'PerformerPhausto',
	#superclass : 'Performer',
	#instVars : [
		'dspCounter'
	],
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerPhausto >> dspCounter [

^ dspCounter 
]

{ #category : 'initialization' }
PerformerPhausto >> initialize [ 

super initialize.
"self initializeCounter."
]

{ #category : 'initialization' }
PerformerPhausto >> initializeCounter [

| counter bgraph counterLevel dsp |
counter := Counter new trig: (PhBeat new label: 'performerBPM').
bgraph := PhHBarGraph new label: 'dspStep' ; input: counter; max: 999999.
counterLevel := PhHSlider new label: 'cl' values: #(0 0 1 0.1).
dsp := (bgraph  * counterLevel ) asDsp. 
dsp init.
dsp start.
dspCounter := dsp.
]

{ #category : 'playing' }
PerformerPhausto >> play [ 
	"play a Phaust performance for 4 days at 120 bpm"

	self playFor: fourDaysAt120BPM 
]

{ #category : 'accessing' }
PerformerPhausto >> playEventAt: anIndex dsp: aDsp freq: aFrequency in: aSequencer [

	| dur aParameterList |
	dur := aSequencer durations asDirtArray wrap: anIndex.
	aParameterList := self performance activeDSP allParameters.

	aSequencer extraParams keysAndValuesDo: [ :k :v |
		aParameterList
			setValue: (v wrap: anIndex)
			parameter: aSequencer seqKey , k asString
			forDsp: aDsp ].

	aParameterList
		setValue: (aSequencer notes wrap: anIndex) midiNoteToFreq
		parameter: aSequencer phaustNoteDestination
		forDsp: aDsp. 
	aParameterList
		trig: aSequencer phaustGateDestination
		for: dur * aFrequency * (aSequencer gateTimes wrap: anIndex)
		forDsp: aDsp.


]

{ #category : 'accessing' }
PerformerPhausto >> playEventAt: anIndex in: aSequencer [

	self playEventAt: anIndex dsp: self performance activeDSP  freq: self performance freq  in: aSequencer 
]

{ #category : 'playing' }
PerformerPhausto >> playFor: aNumberOfSteps [
	self performance activeDSP
		ifNil: [
			^ Error new signal:
				  'There must be an active DSP for this performance' ]
		ifNotNil: [ super playFor: aNumberOfSteps ]
]

{ #category : 'playing' }
PerformerPhausto >> playForEXP: aNumberOfSteps [
	" experimental method to decrease jitter and improve timing 
	########################################################
	play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	
	Performance uniqueInstance activeDSP
		ifNil: [
			^ Error new signal:
				  'There must be an active DSP for this performance' ]
		ifNotNil: [
			self resetPerformance.
			self advanceTransportInBackgroundFor: aNumberOfSteps.
			
			performance activeProcess: ([
				 aNumberOfSteps timesRepeat: [
					 
					 [ "sequencers scan"
					 performance valuesDo: [ :seq | self checkStepFor: seq ] .(Delay forSeconds: performance freq) wait ]
						 forkAt: Processor timingPriority ]  ])].
]

{ #category : 'playing' }
PerformerPhausto >> playNote [
]

{ #category : 'playing' }
PerformerPhausto >> playNoteFor: aSequencer [

	 aSequencer playPhaustEventAt: aSequencer noteIndex. 
							 "increment note Index"
							 aSequencer noteIndex: aSequencer noteIndex + 1
]

{ #category : 'playing' }
PerformerPhausto >> playWithDspCounter [
    | lastCounterValue currentCounterValue |
    
    performance bpm: 60 / (performance freq * 4).
    performance transportStep: 0.
    lastCounterValue := (self dspCounter getParamValue: 'dspStep') asInteger.
    
    performance activeProcess: ([
        9999 timesRepeat: [
            (Delay forMilliseconds: 5) wait.
            
            currentCounterValue := (self dspCounter getParamValue: 'dspStep') asInteger.
            
            "Only trigger when counter VALUE CHANGES (step transition)"
            currentCounterValue ~= lastCounterValue ifTrue: [
                
                "Handle multiple missed steps"
                [ lastCounterValue < currentCounterValue ] whileTrue: [
                    lastCounterValue := lastCounterValue + 1.
                    performance transportStep: lastCounterValue.
                    
                    "Trigger sequencers ONCE per step"
                    [ performance valuesDo: [ :seq |
                        (seq gates wrap: lastCounterValue) = 1 ifTrue: [
                            self playEventAt: seq noteIndex in: seq.
                            seq noteIndex: seq noteIndex + 1
                        ]
                    ]] forkAt: Processor timingPriority - 2.
                ].
            ].
        ]
    ] forkAt: Processor timingPriority - 1)
]

{ #category : 'as yet unclassified' }
PerformerPhausto >> runSequencersWithSteps: aNumberOfSteps [

	performance activeProcess: ([
				 aNumberOfSteps timesRepeat: [
					 (Delay forSeconds: performance freq) wait.
					 [ "sequencers scan"
					 performance valuesDo: [ :seq |
						 (seq gates wrap: performance transportStep) = 1 ifTrue: [
							 seq playPhaustEventAt: seq noteIndex. "delta!!!!"
							 "increment note Index"
							 seq noteIndex: seq noteIndex + 1 ] ] ] forkAt:
						 Processor highIOPriority.

					 "step is incremented anyway"
					 performance incrementTransportStep ] ] forkAt:
					 Processor timingPriority) 
]
