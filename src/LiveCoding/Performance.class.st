"
""A performance is a Dictionary subclass used for live coding package""
"
Class {
	#name : #Performance,
	#superclass : #Dictionary,
	#type : #variable,
	#instVars : [
		'visualization',
		'performer'
	],
	#category : #'LiveCoding-Performance'
}

{ #category : #'as yet unclassified' }
Performance class >> basic [

	^ self new
		  visualization: NoneVisualization new;
		  yourself
]

{ #category : #'as yet unclassified' }
Performance class >> withCircles [

	^ self new
		  visualization: CircleVisualization new;
		  yourself
]

{ #category : #accessing }
Performance >> length [
"return the number of steps of the largest array contained in the performance values"
| valuesSizes maxLength |
valuesSizes := (1 to: (self values size)) collect: [ :i | ((self values at: i) at: 1 )size ].
maxLength := valuesSizes inject: 0 into: [ :a :c | (a > c) ifTrue: [ a ] ifFalse: [ c ] ].
^ maxLength 
]

{ #category : #playing }
Performance >> mute: anArrayOfKeys [
"remove all the keys in the arrayOfKeys from the Performance"
anArrayOfKeys do: [ :i | self removeKey: i ifAbsent: [ ] ] 
]

{ #category : #playing }
Performance >> muteAll [
" remove all keys from the Performance"
self keysDo: [ :i | self removeKey: i ifAbsent: [ ] ] .
]

{ #category : #accessing }
Performance >> performer [

	^ performer
]

{ #category : #accessing }
Performance >> performer: anObject [

	performer := anObject
]

{ #category : #playing }
Performance >> play: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	"if the value in the dictionay is a Sequencer, an OSC message is sent to the key as OSC address with two arguments, one for the gate, and one for the note. the gate stays at 1 for the duration selected."

	| step bpm beatInSeconds gateTime |
	bpm := 60 / (aRateInSeconds * 4).
	gateTime := aRateInSeconds * 0.8.
	beatInSeconds := aRateInSeconds * 4.
	step := 0.

	^ [ 
	  performer bpm: bpm.
	  visualization startWith: bpm.

	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait. "WAIT time"
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  self keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1 ifTrue: [ 
						  | note gateTimeInSeconds |
						  note := value note.
						  gateTimeInSeconds := gateTime * value duration.

						  performer
							  playGate: key
							  withTime: gateTimeInSeconds
							  withNote: note.
						  visualization showSound: key withNote: note.

						  "experimental, for extra control parameter"
						  value extra1 isArray ifTrue: [ 
							  self playExtra: value extra1 of: key at: value noteIndex ].
						  value extra2 isArray ifTrue: [ 
							  self playExtra: value extra2 of: key at: value noteIndex ].

						  value stepIndex ] ]
				  ifFalse: [ 
					  | note |
					  note := value at: (step modulo: value size).
					  performer playGate: key withNote: note ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #'as yet unclassified' }
Performance >> playExtra: anExtraCollection of: baseGate at: index [

	| extraGate fullGate notes currentNote |
	extraGate := anExtraCollection at: 1.
	notes := anExtraCollection at: 2.

	currentNote := notes at: (index modulo: notes size).
	fullGate := baseGate , extraGate.

	performer playGate: fullGate withNote: currentNote
]

{ #category : #playing }
Performance >> playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| step bpm beatInSeconds gateTime |
	"as in early hardware sequencers, default gatetime is 80% of the step duration"
	bpm := 60 / (aRateInSeconds * 4).
	gateTime := aRateInSeconds * 0.8.
	beatInSeconds := aRateInSeconds * 4.
	step := 0.


	^ [ 
	  bpm toKyma: 'BPM'.

	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  self keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ 
							  | note |
							  note := value notes at:
								          (value noteIndex modulo: value notesSize).
							  key asString
								  toKymaAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.

							  "maybe this part is not useful anymore"
							  value durations isArray
								  ifTrue: [ 
									  (value durations at:
										   (value noteIndex modulo: value durationsSize)) toKyma:
										  key asString , 'Duration' ]
								  ifFalse: [ nil ].

							  "experimental, for extra control parameter"
							  value extra1 isArray
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].

							  "new experimental, for second extra control"
							  value extra2 isArray
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ]
								  ifFalse: [ nil ].


							  value at: 4 put: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
					  (value at: (step modulo: value size)) toKyma: key asString.
					  (Delay forSeconds: aRateInSeconds) wait ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #playing }
Performance >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	"if the value in the dictionay is a Sequencer, an OSC message is sent to the key as OSC address with two arguments, one for the gate, and one for the note. the gate stays at 1 for the duration selected."

	| step bpm beatInSeconds gateTime |
	bpm := 60 / (aRateInSeconds * 4).
	gateTime := aRateInSeconds * 0.8.
	beatInSeconds := aRateInSeconds * 4.
	step := 0.

	^ [ 
	  bpm toLocal: 'BPM'.

	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  self keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ 
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ 
							  | note |
							  note := value notes at:
								          (value noteIndex modulo: value notesSize).
							  key asString
								  toLocalFor: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.


							  "experimental, for extra control parameter"
							  value extra1 isArray
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toLocal:
										  (key asString , value extra1 at: 1) ]
								  ifFalse: [ nil ].
							  value at: 4 put: value noteIndex + 1 ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toLocal: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #playing }
Performance >> playMIDISequenceAt: aRateInSeconds steps: aNumberOfSteps on: aMIDISender [

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


	^ [ "bpm toKyma: 'BPM'."
	  visualization startWith: bpm.
	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: aRateInSeconds) wait.
		  " test if dictionary values is an Array of two arrays or as defined, a sequence"

		  self keysAndValuesDo: [ :key :value | 
			  value isSequencer
				  ifTrue: [ "end of the isSequencer true condition"
					  (value gates at: (step modulo: value gatesSize)) = 1
						  ifTrue: [ "aMIDISender playDrum: 56 onChannel: (((key asString) at: 3) asInteger)."
							  aMIDISender
								  playDrum:
								  (value notes at: (value noteIndex modulo: value notesSize))
								  onChannel: (key asString at: 3) digitValue.

							  visualization showSound: key withNote: 60.

							  "old imlementation"
							  "(key asString) toKymaAsGate: ( gateTime * ((value durations ) at: (value noteIndex modulo: (value durationsSize)))) note: ((value notes) at: ((value    noteIndex ) modulo: (value notesSize)))."

							  "sends a ControlChange message on the same channel, if provided"
							  value extra1 isArray
								  ifTrue: [ 
									  aMIDISender
										  sendCC: (value extra1 at: 1)
										  withValue:
										  ((value extra1 at: 2) at:
											   (value noteIndex modulo: value extra1Size))
										  onChannel: (key asString at: 3) digitValue ]
								  ifFalse: [ nil ].

							  "sends another ControlChange message on the same channel, if provided"
							  value extra2 isArray
								  ifTrue: [ 
									  aMIDISender
										  sendCC: (value extra2 at: 1)
										  withValue:
										  ((value extra2 at: 2) at:
											   (value noteIndex modulo: value extra2Size))
										  onChannel: (key asString at: 3) digitValue ]
								  ifFalse: [ nil ].

							  "advance"
							  value at: 4 put: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
					  aMIDISender
						  sendCC: 74
						  withValue: (value at: (step modulo: value size))
						  onChannel: (key asString at: 3) digitValue ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #accessing }
Performance >> visualization [

	^ visualization
]

{ #category : #accessing }
Performance >> visualization: anObject [

	visualization := anObject
]
