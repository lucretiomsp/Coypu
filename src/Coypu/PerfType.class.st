"
I am a PerformerType and I am here to hel you the manage the double dispatch the messages for tdifferences type of Performances
"
Class {
	#name : 'PerfType',
	#superclass : 'Object',
	#category : 'Coypu-Performance',
	#package : 'Coypu',
	#tag : 'Performance'
}

{ #category : 'adding' }
PerfType >> addSequencer: aSequencer to: aSymbol [

	aSequencer noteIndex: 1.
	aSequencer seqKey: aSymbol asString.

	"For SuperDirt"
	aSequencer dirtMessage at: '_id' put: aSequencer seqKey.
	aSequencer dirtMessage at: 'orbit' put: aSequencer orbit.

	(aSequencer dirtMessage includesKey: 's') ifFalse: [
		aSequencer dirtMessage at: 's' put: aSymbol asString asDirtArray ].
	
	"For Polyphony"
	aSequencer seqChords
		ifNil: [ Performance uniqueInstance at: aSymbol put: aSequencer ]
		ifNotNil: [
		Performance uniqueInstance at: aSymbol put: aSequencer asPolySeq ].


	"For PerformerPhaust"
	Performance uniqueInstance performer class = PerformerPhaust ifTrue: [
		aSequencer phaustGateDestination: aSequencer seqKey , 'Gate'.
		aSequencer phaustNoteDestination: aSequencer seqKey , 'Note' ]
]

{ #category : 'playing' }
PerfType >> playFor: aNumberOfSteps [
	" reset all the Sequencers , just on performance at once"

	| perf |
	Transcript clear; show: 'PERFORMANCE DI TIPO BASICO'; open.
	perf := Performance uniqueInstance.
	perf activeProcess isTerminated ifTrue: [
		perf performer playFor: aNumberOfSteps ].

	perf resetAllSequencers
]

{ #category : 'accessing' }
PerfType >> playPhaustEventAt: anIndex forSequencer: aSequencer [
	"sends a message to Phausto / the DSP api must be written in a sensible way "

	| dur stepDuration assignedDsp perf |
	perf := Performance uniqueInstance.
	assignedDsp := perf activeDSP.
	stepDuration := perf freq.

	" please use also duration for gate !!! - future implementation"
	dur := aSequencer durations asDirtArray wrap: anIndex.

	aSequencer extraParams keysAndValuesDo: [ :k :v |
		assignedDsp
			setValue: (v wrap: anIndex)
			parameter: aSequencer  seqKey , k asString ].

	assignedDsp
		setValue: (aSequencer  notes wrap: anIndex) midiNoteToFreq
		parameter: aSequencer phaustNoteDestination. "convert note Number to Frequency"
	"as in early sequencers, standard gate time is 80% of duration"
	assignedDsp
		trig: aSequencer phaustGateDestination
		for: dur * stepDuration * 0.8.

	^ true
]
