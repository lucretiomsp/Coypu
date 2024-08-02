"
A performance is a Dictionary subclass used for live coding package.


"
Class {
	#name : 'Performance',
	#superclass : 'Dictionary',
	#instVars : [
		'performer',
		'freq',
		'backup',
		'bpm',
		'transportStep',
		'activeProcess',
		'dirtMIDIDevice',
		'activeDSP'
	],
	#classInstVars : [
		'uniqueInstance',
		'orbit',
		'performanceType'
	],
	#category : 'Coypu-Performance',
	#package : 'Coypu',
	#tag : 'Performance'
}

{ #category : 'instance creation' }
Performance class >> new [ 

^ Error new signal: 'Performance is a singleton -- Use unique instance instead'
]

{ #category : 'accessing' }
Performance class >> orbit [

	^ orbit
]

{ #category : 'accessing' }
Performance class >> orbit: anInteger [

	orbit := anInteger % 12
]

{ #category : 'accessing' }
Performance class >> performanceType [

	^ performanceType
]

{ #category : 'accessing' }
Performance class >> performanceType: aPerformanceType [

	performanceType := aPerformanceType 
]

{ #category : 'initialization' }
Performance class >> reset [

	<script>
	uniqueInstance := nil
]

{ #category : 'instance creation' }
Performance class >> uniqueInstance [

	self orbit: 0.
	
	^ uniqueInstance ifNil: [ uniqueInstance := super new . self performanceType: PerfType new. ]
]

{ #category : 'as yet unclassified' }
Performance >> Dictionary [  Variable or expression expected -><< #Performance
	layout: VariableLayout;
	slots: {
			 #visualization .
			 #performer .
			 #canvas .
			 #rsGroupDictionary .
			 #freq .
			 #backup .
			 #bpm .
			 #transportStep .
			 #activeProcess.
			 };
	tag: 'Performance';
	package: 'LiveCoding'
]

{ #category : 'accessing' }
Performance >> activeDSP [
	^ activeDSP 
]

{ #category : 'accessing' }
Performance >> activeDSP: aDSP [
	activeDSP := aDSP
]

{ #category : 'accessing' }
Performance >> activeProcess [

	^ activeProcess
]

{ #category : 'accessing' }
Performance >> activeProcess: anObject [

	activeProcess := anObject
]

{ #category : 'performance  - adding' }
Performance >> add: aSequencer channel: anIntegerBetween1And16 [

	aSequencer midiChannel: anIntegerBetween1And16. 
	super add: aSequencer.
]

{ #category : 'accessing' }
Performance >> at: key put: anObject [
	"Set the value at key to be anObject.  If key is not found, create a
	new entry for key and set is value to anObject. Answer anObject."

	super at: key put: anObject.
	
	"implement later tracks visualizers"
	"self trackVisualizers
		at: key
		put: (MfPatternElement new display: anObject gates).
		self perfVisualizer root addChild: (trackVisualizers at: key)."
]

{ #category : 'LiveCoding - Performance' }
Performance >> backup [

	
	^ backup
]

{ #category : 'accessing' }
Performance >> backup: anObject [

	backup := anObject
]

{ #category : 'accessing' }
Performance >> bpm [

	^ bpm
]

{ #category : 'accessing' }
Performance >> bpm: aRateInSeconds [
	bpm := 60 / 4 / (aRateInSeconds ).
]

{ #category : 'accessing' }
Performance >> dirtMIDIDevice [

	^ dirtMIDIDevice
]

{ #category : 'accessing' }
Performance >> dirtMIDIDevice: aString [
	"select a SuperDirt MIDI device for the Performance"
	dirtMIDIDevice := aString
]

{ #category : 'accessing' }
Performance >> freq [
	"better to convert it to Float to avoid OSC sending issues"
	^ freq asFloat
]

{ #category : 'accessing' }
Performance >> freq: aDurationInSeconds [
	"use for playback speed"

	freq := aDurationInSeconds asFloat
]

{ #category : 'LiveCoding - Performance' }
Performance >> incrementTransportStep [
	transportStep := transportStep + 1.
]

{ #category : 'initialization' }
Performance >> initialize: aSize [

	super initialize: aSize.
	activeProcess := Process new terminate.
	self muteAll.
	freq := 132 bpm.
]

{ #category : 'testing' }
Performance >> isPerformance [

	^ true
]

{ #category : 'accessing' }
Performance >> length [
	"return the number of steps of the largest array contained in the performance values"

	| valuesSizes maxLength |
	valuesSizes := (1 to: self values size) collect: [ :i |
		               ((self values at: i) at: 1) size ].
	maxLength := valuesSizes inject: 0 into: [ :a :c | a max: c ].
	^ maxLength
]

{ #category : 'muting and soloing' }
Performance >> mute: aKeyOrAnArrayOfKeys [
	"remove all the keys in the arrayOfKeys from the Performance or remove just a single key"

	| tracks |
	tracks := #( #Kick #TpSampler #Fm2Op #PsgPlus #Chordy ).

	aKeyOrAnArrayOfKeys isArray
		ifTrue: [
		aKeyOrAnArrayOfKeys do: [ :i | self removeKey: i ifAbsent: [  ] ] ]
		ifFalse: [
			self removeKey: aKeyOrAnArrayOfKeys.
			self performanceType class = PerfTypeMooflod ifTrue: [
				self performanceType visualizer cleanRow:
					(tracks indexOf: aKeyOrAnArrayOfKeys) ] ]
]

{ #category : 'muting and soloing' }
Performance >> muteAll [
	" remove all keys from the Performance"

	| anArrayOfKeys |
	backup := self asDictionary.
	self keysDo: [ :i | self removeKey: i ifAbsent: [ nil ] ].


]

{ #category : 'LiveCoding - satelliteEvent' }
Performance >> pacaDance [

	"convenience method created for the ICLC2023 performance - it just play the performance at 132 bpm for 4096 bars"

	| aRateInSeconds aNumberOfSteps step beatInSeconds gateTime |
	aRateInSeconds := 132 bpm.
	aNumberOfSteps := 4096 bars.
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	self resetAllSequencers. "reset all the sequencers"
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
										  key asString , 'Duration' ].

							  "experimental, for extra control parameter"
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ].

							  "new experimental, for second extra control"
							  value extra2 notNil
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ].


							  value noteIndex: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toKyma: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : 'accessing' }
Performance >> performanceType [
	^ self class performanceType
]

{ #category : 'accessing' }
Performance >> performanceType: aPerformanceType [ 
	^ self class performanceType: aPerformanceType 
]

{ #category : 'accessing' }
Performance >> performer [

	^ performer
]

{ #category : 'accessing' }
Performance >> performer: aPerformer [
"choose a Performer for the Performance"
" to be safe, it clear the performance"
	Performance uniqueInstance muteAll.
	performer := aPerformer. 
	Performance uniqueInstance muteAll.
]

{ #category : 'playing' }
Performance >> play [
	" reset all the Sequencers"
	self resetAllSequencers.

	"just on performance at once"
	self activeProcess  
		ifNil:  [ self performer play ] 
		ifNotNil: [ (self activeProcess isTerminated )
							 ifTrue: [ self performer play ] ]
.


	
]

{ #category : 'playing' }
Performance >> playFor: aNumberOfSteps [
	"what happens depends on the Performance type! "

	self class performanceType playFor: aNumberOfSteps.
	self class performanceType asString traceCr 
]

{ #category : 'as yet unclassified' }
Performance >> playKymaSequencFor: aNumberOfSteps [

"with this method you can chane the Performance speed in real time! "
	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| step beatInSeconds gateTime |
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	self resetAllSequencers. "reset all the sequencers"
	"as in early hardware sequencers, default gatetime is 80% of the step duration"


	step := 0.


	^ [ 
	  bpm := 60 / (self freq * 4).

	  gateTime := self freq * 0.8.
	  beatInSeconds := self freq * 4.
	  bpm toKyma: 'BPM'.


	  aNumberOfSteps timesRepeat: [ 
		  (Delay forSeconds: self freq) wait.
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
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].

							  "new experimental, for second extra control"
							  value extra2 notNil
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ]
								  ifFalse: [ nil ].


							  value noteIndex: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toKyma: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : 'playing' }
Performance >> playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	| step beatInSeconds gateTime |
	'x' asPacaAddress. "if PacaAddress is not stored yet"
	self resetAllSequencers. "reset all the sequencers"
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
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toKyma:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].

							  "new experimental, for second extra control"
							  value extra2 notNil
								  ifTrue: [ 
									  ((value extra2 at: 2) at:
										   (value noteIndex modulo: value extra2Size)) toKyma:
										  key asString , (value extra2 at: 1) ]
								  ifFalse: [ nil ].


							  value noteIndex: value noteIndex + 1

							  "noteIndex := noteIndex + 1." ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toKyma: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : 'as yet unclassified' }
Performance >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps [

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values and symbols represnting the OSC address without slash that will be sent out.
an OSC with the address /vcs/BPM/1 with the rate converted in BeatsPerMinutes"

	"if the value in the dictionay is a Sequencer, an OSC message is sent to the key as OSC address with two arguments, one for the gate, and one for the note. the gate stays at 1 for the duration selected."

	| step beatInSeconds gateTime |
	bpm := 60 / (aRateInSeconds * 4).
	gateTime := aRateInSeconds * 0.8.
	beatInSeconds := aRateInSeconds * 4.
	step := 0.

	^ [ 
	  bpm toLocal: 'BPM/'.

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
								  toLocalAsGate: gateTime
									  *
									  (value durations at:
										   (value noteIndex modulo: value durationsSize))
								  note: note.


							  "experimental, for extra control parameter"
							  value extra1 notNil
								  ifTrue: [ 
									  ((value extra1 at: 2) at:
										   (value noteIndex modulo: value extra1Size)) toLocal:
										  key asString , (value extra1 at: 1) ]
								  ifFalse: [ nil ].
							  value noteIndex: value noteIndex + 1 ]
						  ifFalse: [ nil ] ]
				  ifFalse: [ 
				  (value at: (step modulo: value size)) toLocal: key asString ] ].

		  "step is incrementing in any case"
		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : 'removing' }
Performance >> remove: aKey [
	"shorter version of removeKey:"

	self removeKey: aKey ifAbsent: [  ] 
]

{ #category : 'initialization' }
Performance >> resetAllSequencers [
	"reset noteIndex fro all the sequencers in the Performance. "

	self keysAndValuesDo: [ :key :value |
		value isSequencer
			ifTrue: [ value noteIndex: 1 ] ]
]

{ #category : 'LiveCoding - Performance' }
Performance >> restore [

	"restore what the performance was before receiveing messages muteAll or solo"

	| p |
	p := Performance uniqueInstance.
	self backup keysAndValuesDo: [ :k :v | 
		p at: k put: v].
	p keysAndValuesRemove: [ :kp :vp | (p backup includesKey: kp) not ] 
]

{ #category : 'muting and soloing' }
Performance >> solo: aKeyOrAnArrayOfKeys [

	" remove all keys from the Performance except aKey or anArrayOfKeys"

	| anArrayOfKeys |
	backup := self asDictionary. "do the backup"
	anArrayOfKeys := self keys.
	aKeyOrAnArrayOfKeys isArray
		ifTrue: [ 
			self keysAndValuesRemove: [ :keys :values | 
				(aKeyOrAnArrayOfKeys  includes: keys) not ] ]
		ifFalse: [ 
			self keysAndValuesRemove: [ :keys :values | "
	[canvas isNotNil ifTrue: [ 
		anArrayOfKeys do: [ :i | (i ~= aKey) ifTrue: [  
			canvas removeShape: (rsGroupDictionary at: i) asShape ] ]] ] fork
" 
				keys ~= aKeyOrAnArrayOfKeys ] ]
]

{ #category : 'accessing' }
Performance >> stop [

	self performanceType stop.
]

{ #category : 'modifying' }
Performance >> swap: firstKey with: secondKey [
"swap the values of two perfromance keys"
	| tempValue |
	tempValue := self at: firstKey.
	self at: firstKey put: (self at: secondKey).
	self at: secondKey put: tempValue
]

{ #category : 'accessing' }
Performance >> transportStep [
	^ transportStep
]

{ #category : 'accessing' }
Performance >> transportStep: anInteger [
	transportStep := anInteger 
]

{ #category : 'accessing' }
Performance >> type [
	^ self class type
]

{ #category : 'accessing' }
Performance >> type: aPerformanceType [ 
	^ self class type: aPerformanceType 
]

{ #category : 'LiveCoding - Performance' }
Performance >> unsolo: aKeyInPerformance [
	"convenience method to unsolo a key in the performance"
	
	self restore
]
