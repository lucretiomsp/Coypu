"
EXPERIMENTAL!!!!!
Sends OSC mesages to SuperDirt port and to port 8000 to use for visual with Processing or Hydra or Jitter (just to name a few)
"
Class {
	#name : #PerformerSuperDirtAndVisual,
	#superclass : #Performer,
	#category : #'Coypu-Performance'
}

{ #category : #playing }
PerformerSuperDirtAndVisual >> play [ 
self playDirtAndVisual 
]

{ #category : #'as yet unclassified' }
PerformerSuperDirtAndVisual >> playDirtAndVisual [

	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	
	performance bpm: 60 / (performance  freq * 4). 
	performance transportStep: 1.
	performance activeProcess: ([ 
		        "the perfrormance last 4 days at 120 bpm"
	           fourDaysAt120BPM  timesRepeat: [ 
		           (Delay forSeconds: performance  freq) wait.
		           "sequencers scan"
		           [ 
		           performance  valuesDo: [ :seq | 
			           (seq gates wrap: performance transportStep) = 1
				           ifTrue: [ 
					           seq playFullDirtEventAt: seq noteIndex port: 57120 "delta!!!!" ; playFullDirtEventAt: seq noteIndex port: 8000.
					            
					           "increment note Index"
					           seq noteIndex: seq noteIndex + 1 ]
				           ifFalse: [ nil ] ] ] forkAt: Processor timingPriority.

		           "step is incremented anyway"
		           performance  incrementTransportStep ] ] forkAt: Processor timingPriority).



]
