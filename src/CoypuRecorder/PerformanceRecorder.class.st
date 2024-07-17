"
## For the Class part:
  The recorder of performance .

## For the Responsibility part:
Decorator of Performance used to record the performance 
Uses a savedPerformance to save the commands used during the performance.

## For the Collaborators Part:
Decorator of Performance Using RecordedCommand in the OrderedCollection savedPerformance.

## Public API and Key Messages

- Use it has a performance and it will save every command used in savedPerformance.
- You can get those command in a txt file via the message ""writeScriptInTxtFile""
- PerformanceRecorder is a singleton so you can get access to it via the line ""PerformanceRecorder uniqueInstance"".

## Internal Representation and Key Implementation Points:

### Instance Variables
announcer: <Announcer> Used to save the command and to stock them in savedPerformance>
savedPerformance:	<SavedPerformance> object that has an OrderedCollection where the commands used are saved as RecordedCommand objects.


"
Class {
	#name : 'PerformanceRecorder',
	#superclass : 'Object',
	#instVars : [
		'savedPerformance',
		'announcer'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'CoypuRecorder-Recorder',
	#package : 'CoypuRecorder',
	#tag : 'Recorder'
}

{ #category : 'instance creation' }
PerformanceRecorder class >> new [

	^ Error new signal:
		  'PerformanceRecorder is a singleton -- Use unique instance instead'
]

{ #category : 'accessing' }
PerformanceRecorder class >> uniqueInstance [

	^ uniqueInstance ifNil: [
		  uniqueInstance := super new]
]

{ #category : 'accessing' }
PerformanceRecorder >> Dictionary [

	^ Performance uniqueInstance dictionary
]

{ #category : 'accessing' }
PerformanceRecorder >> activeDSP [ 

^ Performance uniqueInstance activeDSP
]

{ #category : 'accessing' }
PerformanceRecorder >> activeDSP: aDSP [


	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'activeDSP: ' , aDSP asString , '.').
	Performance uniqueInstance activeDSP: aDSP
]

{ #category : 'accessing' }
PerformanceRecorder >> activeDSP: aDSP atTime: aTime [

	(Delay forMilliseconds: aTime) wait.
	Performance uniqueInstance activeDSP: aDSP
]

{ #category : 'accessing' }
PerformanceRecorder >> activeProcess [

	^Performance uniqueInstance activeProcess
]

{ #category : 'accessing' }
PerformanceRecorder >> activeProcess: anObject [

Performance uniqueInstance activeProcess: anObject
]

{ #category : 'adding' }
PerformanceRecorder >> add: aSequencer channel: anIntegerBetween1And16 [

Performance uniqueInstance add: aSequencer channel: anIntegerBetween1And16
]

{ #category : 'announcer' }
PerformanceRecorder >> announce: anAnnouncement [
	"Used to announce with the announcer of PerformanceRecorder"

	announcer ifNil: [
		announcer := Announcer new.
		announcer
			when: RhythmAnnouncement
			send: #addInstrument:
			to: savedPerformance;
			when: SymbolAnnouncement send: #lastSymbol: to: savedPerformance;
			when: DirtNotesAnnouncement
			send: #lastDirtNotes:
			to: savedPerformance;
			when: DelayAnnouncement send: #appliesDelay: to: savedPerformance;
			when: DoubleRhythmAnnouncement
			send: #lastSymbol:
			to: savedPerformance;
			when: NotesAnnouncement send: #appliesNotes: to: savedPerformance;
			when: ExtraValuesAnnouncement send: #appliesExtraValues: to: savedPerformance ].

	announcer announce: anAnnouncement
]

{ #category : 'accessing' }
PerformanceRecorder >> announcer [


	^ announcer
]

{ #category : 'accessing' }
PerformanceRecorder >> announcer: anAnnouncer [

	announcer := anAnnouncer
]

{ #category : 'accessing' }
PerformanceRecorder >> at: key put: anObject [

Performance uniqueInstance at: key put: anObject
]

{ #category : 'accessing' }
PerformanceRecorder >> backup [

^	Performance uniqueInstance backup
]

{ #category : 'accessing' }
PerformanceRecorder >> backup: anObject [

	Performance uniqueInstance backup: anObject
]

{ #category : 'accessing' }
PerformanceRecorder >> bpm [

^	Performance uniqueInstance bpm
]

{ #category : 'accessing' }
PerformanceRecorder >> bpm: aRateInSeconds [


	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'bpm: ', aRateInSeconds  asString , '.').
	Performance uniqueInstance bpm: aRateInSeconds
]

{ #category : 'accessing' }
PerformanceRecorder >> bpm: aRateInSeconds atTime: aTime [
	"Call the message bpm with a atTime delay"

	(Delay forMilliseconds: aTime) wait.

	self bpm: aRateInSeconds
]

{ #category : 'accessing' }
PerformanceRecorder >> canvas [

	^Performance uniqueInstance canvas
]

{ #category : 'accessing' }
PerformanceRecorder >> canvas: aRSCanvas [

Performance uniqueInstance canvas: aRSCanvas
]

{ #category : 'accessing' }
PerformanceRecorder >> dirtMIDIDevice [
	"select a SuperDirt MIDI device for the Performance"

	^Performance uniqueInstance dirtMIDIDevice
]

{ #category : 'accessing' }
PerformanceRecorder >> dirtMIDIDevice: aString [
	"select a SuperDirt MIDI device for the Performance"
	
Performance uniqueInstance dirtMIDIDevice: aString
]

{ #category : 'accessing' }
PerformanceRecorder >> emptySavedPerformance [

	savedPerformance collectionOfCommands removeAll
]

{ #category : 'accessing - structure variables' }
PerformanceRecorder >> freq [
	^ Performance uniqueInstance freq
]

{ #category : 'accessing' }
PerformanceRecorder >> freq1: anObject [

Performance uniqueInstance freq1: anObject
]

{ #category : 'accessing' }
PerformanceRecorder >> freq: aDurationInSeconds [
"Create a new RecordedOrderCommand to add to the savedPerformance before calling the freq: message of the Performance "
	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'freq: ' , (1 / (4 * aDurationInSeconds) * 60) asInteger asString
			 , ' bpm.').
	Performance uniqueInstance freq: aDurationInSeconds
]

{ #category : 'accessing' }
PerformanceRecorder >> freq: aDurationInSeconds atTime: aTime [
	"Call the message freq: with a atTime delay"

	(Delay forMilliseconds: aTime) wait.

	self freq: aDurationInSeconds
]

{ #category : 'LiveCoding - Performance' }
PerformanceRecorder >> incrementTransportStep [

	Performance uniqueInstance incrementTransportStep 
]

{ #category : 'initialization' }
PerformanceRecorder >> initialize [
	
savedPerformance := SavedPerformance new
]

{ #category : 'initialization' }
PerformanceRecorder >> initialize: aSize [

Performance uniqueInstance initialize: aSize
]

{ #category : 'testing' }
PerformanceRecorder >> isPerformance [ 

Performance uniqueInstance isPerformance
]

{ #category : 'testing' }
PerformanceRecorder >> isVisualizerOpen: aBoolean [ 

Performance uniqueInstance isVisualizerOpen: aBoolean.
]

{ #category : 'accessing' }
PerformanceRecorder >> length [

Performance uniqueInstance length
]

{ #category : 'as yet unclassified' }
PerformanceRecorder >> levelOfDetail: anIntegerBetween1And5 [

Performance uniqueInstance levelOfDetail: anIntegerBetween1And5 
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> mute: aKeyOrAnArrayOfKeys [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the mute: message of the Performance "

	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'mute: ' , '#' , aKeyOrAnArrayOfKeys asString , '.').
	Performance uniqueInstance mute: aKeyOrAnArrayOfKeys
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> mute: aKeyOrAnArrayOfKeys atTime: aTime [
	"Call the mute method with a atTime delay"

	(Delay forMilliseconds: aTime) wait.

	self mute: aKeyOrAnArrayOfKeys
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> muteAll [
"Create a new RecordedOrderCommand to add to the savedPerformance before calling the muteAll: message of the Performance "
	savedPerformance
		add:( RecordedInstructionCommand new
		instruction: 'muteAll.').
	Performance uniqueInstance muteAll
		
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> muteAllAtTime: aTime [
	"Call the message muteAll with a atTime delay"

	(Delay forMilliseconds: aTime) wait.

	self muteAll
]

{ #category : 'as yet unclassified' }
PerformanceRecorder >> openVisualizers [

Performance uniqueInstance opensVisualizer.
]

{ #category : 'as yet unclassified' }
PerformanceRecorder >> opensVisualizers [

Performance uniqueInstance opensVisualizer.
]

{ #category : 'LiveCoding - satelliteEvent' }
PerformanceRecorder >> pacaDance [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the pacaDance message of the Performance "

	savedPerformance add: (RecordedInstructionCommand new instruction: 'pacaDance').

	Performance uniqueInstance pacaDance
]

{ #category : 'LiveCoding - satelliteEvent' }
PerformanceRecorder >> pacaDanceAtTime: aTime [
	"call the pacaDanceAtTime: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self pacaDance
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> perfVisualizer [

	^Performance uniqueInstance perfVisualizer
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> perfVisualizer: aPerfVisualizer [

	Performance uniqueInstance perfVisualizer: aPerfVisualizer 
]

{ #category : 'as yet unclassified' }
PerformanceRecorder >> performanceType [

	^ Performance performanceType
]

{ #category : 'as yet unclassified' }
PerformanceRecorder >> performanceType: aPerformanceType [

    savedPerformance add: (RecordedInstructionCommand new instruction:
             'performanceType: ' , aPerformanceType asString).
    ^ Performance performanceType: aPerformanceType
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> performer [

	^Performance uniqueInstance performer
]

{ #category : 'accessing' }
PerformanceRecorder >> performer: aPerformer [

self emptySavedPerformance.
	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'performer: ' , aPerformer asString allButFirst , ' new.').
	Performance uniqueInstance performer: aPerformer
]

{ #category : 'accessing' }
PerformanceRecorder >> performer: aPerformer atTime: aDelay [

	(Delay forMilliseconds: aDelay) wait.
	self performer: aPerformer
]

{ #category : 'playing' }
PerformanceRecorder >> play [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the play message of the Performance "
	savedPerformance add: (RecordedInstructionCommand new instruction: 'play.').
	Performance uniqueInstance play
]

{ #category : 'playing' }
PerformanceRecorder >> playFor: aNumberOfSteps [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the playFor: message of the Performance "
	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'playFor: ' , (aNumberOfSteps / 16) asString , ' bars.').
	Performance uniqueInstance playFor: aNumberOfSteps
]

{ #category : 'playing' }
PerformanceRecorder >> playFor: aNumberOfSteps atTime: aTime [
	"call the playFor: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self playFor: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playKymaSequencFor: aNumberOfSteps [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the playKymaSequencFor:  message of the Performance "
	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'playKymaSequencFor: ' , aNumberOfSteps asString , '.').
	Performance uniqueInstance playKymaSequencFor: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playKymaSequencFor: aNumberOfSteps atTime: aTime [
	"call the playKymaSequencFor: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	Performance uniqueInstance playKymaSequencFor: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the playKymaSequenceAt:for:  message of the Performance "

	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'playKymaSequenceAt:' , aRateInSeconds asString , ' ' , 'for: '
			 , aNumberOfSteps asString , '.').
	Performance uniqueInstance
		playKymaSequenceAt: aRateInSeconds
		for: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps atTime: aTime [
	"call the playKymaSequenceAt: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.
	self playKymaSequenceAt: aRateInSeconds for: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the playLocalSequenceAt:for:  message of the Performance "

	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'playLocalSequenceAt:' , aRateInSeconds asString , ' ' , 'for: '
			 , aNumberOfSteps asString , '.').
	Performance uniqueInstance
		playLocalSequenceAt: aRateInSeconds
		for: aNumberOfSteps
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps atTime: aTime [
	"call the playLocalSequenceAt:for: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self playLocalSequenceAt: aRateInSeconds for: aNumberOfSteps
]

{ #category : 'playing' }
PerformanceRecorder >> playatTime: aTime [
	"call the play method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.
	self play
]

{ #category : 'removing' }
PerformanceRecorder >> remove: aKey [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the remove:  message of the Performance "
	Performance uniqueInstance remove: aKey
]

{ #category : 'removing' }
PerformanceRecorder >> remove: aKey atTime: aTime [
	"call the remove: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self remove: aKey
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> resetAllSequencers [ 

Performance uniqueInstance resetAllSequencers 
]

{ #category : 'accessing' }
PerformanceRecorder >> restore [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the restore  message of the Performance "
	savedPerformance add: (RecordedInstructionCommand new instruction: 'restore.').
	Performance uniqueInstance restore
]

{ #category : 'accessing' }
PerformanceRecorder >> restoreAtTime: aTime [
	"call the remove: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self restore
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> rsGroupDictionary [

	^Performance uniqueInstance rsGroupDictionary
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> rsGroupDictionary: anRSGroupDictionary [

 Performance uniqueInstance rsGroupDictionary: anRSGroupDictionary  
]

{ #category : 'accessing' }
PerformanceRecorder >> savedPerformance [

	^ savedPerformance
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> solo: aKeyOrAnArrayOfKeys [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the solo: message of the Performance "
		savedPerformance add: (RecordedInstructionCommand new instruction:
			 'solo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.').
	Performance uniqueInstance solo: aKeyOrAnArrayOfKeys.

]

{ #category : 'muting and soloing' }
PerformanceRecorder >> solo: aKeyOrAnArrayOfKeys atTime: aTime [
	"call the solo: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self solo: aKeyOrAnArrayOfKeys
]

{ #category : 'accessing' }
PerformanceRecorder >> stop [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the stop message of the Performance "

	savedPerformance add: (RecordedInstructionCommand new instruction: 'stop.').
	Performance uniqueInstance stop
]

{ #category : 'accessing' }
PerformanceRecorder >> stopAtTime: aTime [
	"call the stop method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self stop
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> swap: firstKey with: secondKey [

Performance uniqueInstance swap: firstKey with: secondKey
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> trackVisualizers [

	^Performance uniqueInstance trackVisualizers
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> trackVisualizers: aDictionary [

	^Performance uniqueInstance trackVisualizers: aDictionary 
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> transportStep [

	^Performance uniqueInstance transportStep
]

{ #category : 'muting and soloing' }
PerformanceRecorder >> transportStep: anInteger [

Performance uniqueInstance transportStep: anInteger
]

{ #category : 'accessing - structure variables' }
PerformanceRecorder >> type [

^Performance uniqueInstance type
]

{ #category : 'accessing - structure variables' }
PerformanceRecorder >> type: aPerformanceType [

	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'type: ' , aPerformanceType asString,'.').
	Performance uniqueInstance type: aPerformanceType
]

{ #category : 'LiveCoding - Performance' }
PerformanceRecorder >> unsolo: aKeyOrAnArrayOfKeys [
	"Create a new RecordedOrderCommand to add to the savedPerformance before calling the unsolo: message of the Performance "
	Performance uniqueInstance unsolo: aKeyOrAnArrayOfKeys.
	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'unsolo: ' , '#' , aKeyOrAnArrayOfKeys asString , '.')
]

{ #category : 'LiveCoding - Performance' }
PerformanceRecorder >> unsolo: aKeyOrAnArrayOfKeys atTime: aTime [
	"call the unsolo: method with a aTime delay"

	(Delay forMilliseconds: aTime) wait.

	self unsolo: aKeyOrAnArrayOfKeys
]

{ #category : 'accessing' }
PerformanceRecorder >> visualization [

^	Performance uniqueInstance visualization
]

{ #category : 'accessing' }
PerformanceRecorder >> visualization: anObject [

Performance uniqueInstance visualization: anObject 
]

{ #category : 'accessing' }
PerformanceRecorder >> visualizer [ 

^ Performance uniqueInstance visualizer
]
