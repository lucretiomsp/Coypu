Class {
	#name : #MIDISender,
	#superclass : #Object,
	#instVars : [
		'midiOut',
		'defaultOutput'
	],
	#category : #LiveCoding
}

{ #category : #initialization }
MIDISender >> closeMidiOut [
	"Close the MidiOUT stream (where the score sends notes)."
	^ PortMidiLibrary uniqueInstance portMidiCloseIOStream: midiOut value
]

{ #category : #initialization }
MIDISender >> defaultOutput [
	"Returns the defaultOutDeviceID of the user machine if it is online."
	^ defaultOutput
]

{ #category : #initialization }
MIDISender >> defaultOutput: aDevice [
	"Sets the new default output for the score."
	defaultOutput := aDevice
]

{ #category : #initialization }
MIDISender >> initialize [
	| instance |
	instance := PortMidiLibrary uniqueInstance.
	self defaultOutput: instance getDefaultOutputDeviceID.
	self midiOut: (instance createNewPointerForStreamWithType: 'void**').
	
]

{ #category : #initialization }
MIDISender >> midiOut [
	"Gets the MidiOUT stream that is used to write the melody."
	^ midiOut
]

{ #category : #initialization }
MIDISender >> midiOut: anOutputStream [
	"Sets a new MidiOUT stream that is used to write the melody."
	midiOut := anOutputStream
]

{ #category : #initialization }
MIDISender >> openMidiOutWithDevice: aDeviceID [
	"Opens a new MidiOUT Stream with output device id aDeviceID to play notes."
	^ (aDeviceID = -1) ifFalse: 
		[PortMidiLibrary uniqueInstance openOutputForStream: midiOut  
															withDevice: aDeviceID 
															withOutputDriverInfos: nil 
															withBufferSize: 512 
															withTimeProcedure: nil 
															withTimeInfos: nil 
															andLatency: 0 ] ifTrue: [ ^ -1 ]
]

{ #category : #'as yet unclassified' }
MIDISender >> playDrum: aNoteNumber onChannel: aMIDIChannel [
" play aNoteNumber on channel aChannel with no corresponding noteOff - intended for drums"
| instance noteOn channel |
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
noteOn := PortMidi  message: 144 + channel and: aNoteNumber  and: 100.

instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.

^ 'Drum was played'


]

{ #category : #initialization }
MIDISender >> playNote: aNoteNumber onChannel: aMIDIChannel [
" play aNoteNumber on channel aChannel for a standard duration of 250 ms"
| instance noteOn noteOff channel |
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
noteOn := PortMidi  message: 144 + aMIDIChannel and: aNoteNumber  and: 100.
noteOff := PortMidi  message: 128 + aMIDIChannel and: aNoteNumber  and: 100.
instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.
(Delay forSeconds: 0.05) wait. 
instance writeShortOn: self midiOut value when: 0 theMessage: noteOff.
^ 'note was played'


]

{ #category : #initialization }
MIDISender >> playNote: aNoteNumber onChannel: aMIDIChannel duration: aDurationInMs [
" play aNoteNumber on channel aChannel for aDurationInMs"
| instance noteOn noteOff channel dur|
dur := aDurationInMs / 1000 asFloat .
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
noteOn := PortMidi  message: 144 + aMIDIChannel and: aNoteNumber  and: 100.
noteOff := PortMidi  message: 128 + aMIDIChannel and: aNoteNumber  and: 100.
instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.
(Delay forSeconds: 0.1) wait  . 
instance writeShortOn: self midiOut value when: 0 theMessage: noteOff.
^ 'note was played'


]
