"
Performer for Phausto. 
Phausto and its libraries must be loaded into your image.
Find Phausto here:
https://github.com/lucretiomsp/phausto
"
Class {
	#name : 'PerformerPhausto',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'playing' }
PerformerPhausto >> play [ 
	"play a Phaust performance for 4 days at 120 bpm"

	self playFor: fourDaysAt120BPM 
]

{ #category : 'playing' }
PerformerPhausto >> playFor: aNumberOfSteps [
	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	Performance uniqueInstance activeDSP
		ifNil: [
			^ Error new signal:
				  'There must be an active DSP for this performance' ]
		ifNotNil: [ performance bpm: 60 / (performance freq * 4).
			performance transportStep: 0.
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
					 Processor timingPriority)]
			
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
