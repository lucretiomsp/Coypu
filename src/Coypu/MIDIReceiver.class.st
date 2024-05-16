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
	#category : #'Coypu-MIDI'
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

	^ aDeviceID = -1
		  ifFalse: [
			  PortMidiLibrary uniqueInstance
				  openInputForStream: midiIn
				  withDevice: aDeviceID
				  withInputDriverInfos: nil
				  withBufferSize: 512
				  withTimeProcedure: nil
				  andTimeInfos: nil
]
		  ifTrue: [ ^ -1 ]
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

{ #category : #'as yet unclassified' }
MIDIReceiver >> traceIncomingMessage [

	| instance buffer proc |
	instance := PortMidiLibrary uniqueInstance.
	buffer := PortMidiEvent new.
	proc := [ [
		        instance
			        advancedReadOn: self midiInput value
			        inBuffer: buffer
			        withSize: 512.
		        (instance portMidiGetStatusFromMessage: buffer message)
			        traceCr.
		        (instance portMidiGetFirstDataFromMessage: buffer message)
			        traceCr.
		        (instance portMidiGetSecondDataFromMessage: buffer message)
			        traceCr ] repeat  ] fork.
	^ proc
]

{ #category : #'as yet unclassified' }
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
