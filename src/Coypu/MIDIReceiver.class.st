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
		'deviceID',
		'deviceName'
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

{ #category : 'class initialization' }
MIDIReceiver class >> closeAll [
	self openDevices values copy do: [ :each | each close ]

]

{ #category : 'class initialization' }
MIDIReceiver class >> initialize [
	SessionManager default registerUserClassNamed: self name

]

{ #category : 'class initialization' }
MIDIReceiver class >> openDevices [
	^ OpenDevices ifNil: [ OpenDevices := Dictionary new ]
]

{ #category : 'class initialization' }
MIDIReceiver class >> shutDown: quitting [
	quitting ifTrue: [ self closeAll ]
]

{ #category : 'class initialization' }
MIDIReceiver class >> startUp: resuming [
	resuming ifTrue: [ OpenDevices := nil ]
]

{ #category : 'initialization' }
MIDIReceiver >> close [
	| err |
	deviceID ifNil: [ ^ 0 ].
	receivingProcess ifNotNil: [ :p |
		p terminate.
		receivingProcess := nil ].
	err := PortMidiLibrary uniqueInstance portMidiCloseIOStream: midiIn value.
	self class openDevices removeKey: deviceID ifAbsent: [ ].
	deviceID := nil.
	^ err
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
MIDIReceiver >> deviceIDNamed: aString [
	^ [ PortMidiLibrary uniqueInstance idOfInputPortNamed: aString ]
		  on: Error
		  do: [ -1 ]

]

{ #category : 'as yet unclassified' }
MIDIReceiver >> eviceIDNamed: aString [
	^ [ PortMidiLibrary uniqueInstance idOfInputPortNamed: aString ]
		  on: Error
		  do: [ -1 ]
]

{ #category : 'initialization' }
MIDIReceiver >> initialize [
	| lib |
	super initialize.
	lib := PortMidiLibrary uniqueInstance.
	defaultInput := lib getDefaultInputDeviceID.
	midiIn := lib createNewPointerForStreamWithType: 'void**'

]

{ #category : 'initialization' }
MIDIReceiver >> isOpen [
	^ deviceID notNil
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

{ #category : 'initialization' }
MIDIReceiver >> receivingProcess [
	^ receivingProcess

]

{ #category : 'initialization' }
MIDIReceiver >> receivingProcess: aProcess [
	receivingProcess := aProcess
]

{ #category : 'initialization' }
MIDIReceiver >> traceIncomingMessage [
	| lib buffer |
	lib := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.
	receivingProcess := [
		[
			lib advancedReadOn: midiIn value inBuffer: buffer withSize: 1.
			(lib portMidiGetStatusFromMessage: buffer message) traceCr.
			(lib portMidiGetFirstDataFromMessage: buffer message) traceCr.
			(lib portMidiGetSecondDataFromMessage: buffer message) traceCr ]
			repeat ] fork.
	^ receivingProcess
]

{ #category : 'initialization' }
MIDIReceiver >> trig: aDsp [
	| lib buffer |
	lib := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.
	receivingProcess := [
		[
			lib advancedReadOn: midiIn value inBuffer: buffer withSize: 1.
			aDsp
				setValue: (lib portMidiGetFirstDataFromMessage: buffer message) / 100
				parameter: 'TrigMe' ]
			repeat ] fork.
	^ receivingProcess
]
