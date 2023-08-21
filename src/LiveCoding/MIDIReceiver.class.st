"
MIDIReceiver
Use the MIDIReceiever to receive MIDI events.
"
Class {
	#name : #MIDIReceiver,
	#superclass : #Object,
	#instVars : [
		'midiIn',
		'defaultInput'
	],
	#category : #'LiveCoding-MIDI'
}

{ #category : #accessing }
MIDIReceiver >> defaultInput [
^ defaultInput 
]

{ #category : #accessing }
MIDIReceiver >> defaultInput: anInput [
defaultInput := anInput.
]

{ #category : #'as yet unclassified' }
MIDIReceiver >> initialize [
	| instance |
	instance := PortMidiLibrary uniqueInstance.
	self defaultInput: instance getDefaultOutputDeviceID.
	self midiInput: (instance createNewPointerForStreamWithType: 'void**').
	
]

{ #category : #'as yet unclassified' }
MIDIReceiver >> midiInput [
^ midiIn 
]

{ #category : #'as yet unclassified' }
MIDIReceiver >> midiInput: anInputStream [
	"Sets a new MidiInput stream that is used to read incoming notes."
	midiIn := anInputStream
]

{ #category : #outputManagement }
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

{ #category : #outputManagement }
MIDIReceiver >> openWithDevice: aDeviceID [
	"Opens a new MidiOUT Stream with output device id aDeviceID to play notes."
	^ (aDeviceID = -1) ifFalse: 
		[PortMidiLibrary uniqueInstance openOutputForStream: midiIn  
															withDevice: aDeviceID 
															withOutputDriverInfos: nil 
															withBufferSize: 512 
															withTimeProcedure: nil 
															withTimeInfos: nil 
															andLatency: 0 ] ifTrue: [ ^ -1 ]
]

{ #category : #'as yet unclassified' }
MIDIReceiver >> readInBuffer: buffer withSize: bufferSize [
	"Calls the PortMidi C library method that read bufferSize MIDI message on aStream and stores it in buffer."
]

{ #category : #'as yet unclassified' }
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
