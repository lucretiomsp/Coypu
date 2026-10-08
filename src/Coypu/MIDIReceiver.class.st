"
MIDIReceiver
Use the MIDIReceiever to receive MIDI events.
"
Class {
	#name : 'MIDIReceiver',
	#superclass : 'Object',
	#instVars : [
		'midiIn',
		'defaultInput',
		'receivingProcess',
		'deviceID'
	],
	#classVars : [
		'OpenDevices'
	],
	#classInstVars : [
		'midiIn',
		'deviceID'
	],
	#category : 'Coypu-MIDI',
	#package : 'Coypu',
	#tag : 'MIDI'
}

{ #category : 'open/close' }
MIDIReceiver class >> close [

	| receivinProcess |
	midiIn ifNil: [ ^ self ].
	receivinProcess ifNotNil: [ :p |
		p terminate.
		receivinProcess := nil ].
	PortMidiLibrary uniqueInstance closeStream: midiIn.
	self class openDevices removeKey: deviceID ifAbsent: [ ].
	midiIn := nil.
	deviceID := nil
]

{ #category : 'open/close' }
MIDIReceiver class >> closeAll [
	self openDevices values copy do: [ :each | each close ]
]

{ #category : 'open/close' }
MIDIReceiver class >> openDevices [
	^ OpenDevices ifNil: [ OpenDevices := Dictionary new ]
]

{ #category : 'outputManagement' }
MIDIReceiver >> close [

	midiIn ifNil: [ ^ self ].
	receivingProcess ifNotNil: [ :p |
			p terminate.
			receivingProcess := nil ].
	PortMidiLibrary uniqueInstance closeStream: midiIn.
	self class openDevices removeKey: deviceID ifAbsent: [ ].
	midiIn := nil.
	deviceID := nil
]

{ #category : 'accessing' }
MIDIReceiver >> defaultInput [
^ defaultInput 
]

{ #category : 'accessing' }
MIDIReceiver >> defaultInput: anInput [
	defaultInput := anInput.
]

{ #category : 'initialization' }
MIDIReceiver >> initialize [
	| instance |
	instance := PortMidiLibrary uniqueInstance.
	self defaultInput: instance getDefaultOutputDeviceID.
	self midiInput: (instance createNewPointerForStreamWithType: 'void**').
	
]

{ #category : 'testing' }
MIDIReceiver >> isOpen [
	^ midiIn notNil

]

{ #category : 'accessing' }
MIDIReceiver >> midiInput [
^ midiIn 
]

{ #category : 'accessing' }
MIDIReceiver >> midiInput: anInputStream [
	"Sets a new MidiInput stream that is used to read incoming notes."
	midiIn := anInputStream
]

{ #category : 'outputManagement' }
MIDIReceiver >> openMidiInputWithDevice: aDeviceID [
	"Opens a new MidiOUT Stream with output device id aDeviceID to play notes."
	^ (aDeviceID = -1) ifFalse: 
		[PortMidiLibrary uniqueInstance openInputForStream: midiIn  
															withDevice: aDeviceID 
															withInputDriverInfos: nil 
															withBufferSize: 512 
															withTimeProcedure: nil 
															andTimeInfos: nil 
															] ifTrue: [ ^ -1 ]
														
													
]

{ #category : 'outputManagement' }
MIDIReceiver >> openWithDevice: aDeviceIDOrName [
	"Open the MIDI input stream on a device given by id (Integer) or name (String)."

	^ aDeviceIDOrName openMidiStream: self
]

{ #category : 'outputManagement' }
MIDIReceiver >> openWithDeviceID: aDeviceID [

	| lib err |
	aDeviceID = -1 ifTrue: [ ^ -1 ].
	self close.
	(self class openDevices at: aDeviceID ifAbsent: [ nil ])
		ifNotNil: [ :previous | previous close ].
	lib := PortMidiLibrary uniqueInstance.
	midiIn := lib createNewPointerForStreamWithType: 'void**'.
	err := lib
		  openInputForStream: midiIn
		  withDevice: aDeviceID
		  withInputDriverInfos: nil
		  withBufferSize: 512
		  withTimeProcedure: nil
		  andTimeInfos: nil.
	err = 0 ifTrue: [
		deviceID := aDeviceID.
		self class openDevices at: aDeviceID put: self ].
	^ err
]

{ #category : 'accessing' }
MIDIReceiver >> portDirection [

	^ 'INPUT'
]

{ #category : 'reading' }
MIDIReceiver >> readInBuffer: buffer withSize: bufferSize [
	"Calls the PortMidi C library method that read bufferSize MIDI message on aStream and stores it in buffer."
]

{ #category : 'reading' }
MIDIReceiver >> readIncomingMessageSize: aNumberOfEvents [

	| instance buffer |
	instance := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.

	[ 
	aNumberOfEvents timesRepeat: [ 
		instance advancedReadOn: self midiInput value inBuffer: buffer withSize: 1.
		(instance portMidiGetStatusFromMessage: buffer message) traceCr.
		(instance portMidiGetFirstDataFromMessage: buffer message) traceCr.
		(instance portMidiGetSecondDataFromMessage: buffer message) traceCr ] ]
		fork
]

{ #category : 'accessing' }
MIDIReceiver >> receivinProcess [

	^ receivingProcess
]

{ #category : 'accessing' }
MIDIReceiver >> receivinProcess: aProcess [

	receivingProcess := aProcess
]

{ #category : 'logging' }
MIDIReceiver >> traceIncomingMessage [

	| instance buffer |
	instance := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.
	receivingProcess := [
		                   [
			                   instance advancedReadOn: self midiInput value inBuffer: buffer withSize: 512.
			                   ('I am the buffer message' , buffer message asString) traceCr.
			                   (instance portMidiGetStatusFromMessage: buffer message) traceCr.
			                   (instance portMidiGetFirstDataFromMessage: buffer message) traceCr.
			                   (instance portMidiGetSecondDataFromMessage: buffer message) traceCr ] repeat ] fork.
	^ receivingProcess
]

{ #category : 'messages' }
MIDIReceiver >> trig: aDsp [

	| instance buffer proc |
	instance := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.
	proc := [
	        [ 1 > 0 ] whileTrue: [
		        instance
			        advancedReadOn: self midiInput value
			        inBuffer: buffer
			        withSize: 512.
		        
		        aDsp setValue: ((instance portMidiGetFirstDataFromMessage: buffer message) /100)
			        parameter: 'TrigMe'.
		        (instance portMidiGetSecondDataFromMessage: buffer message)
			        traceCr ] ] fork.
	^ proc
]
