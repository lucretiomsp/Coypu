"
MIDISender
Use MIDISendere to send out MIDI events

example
mout := MIDISender new.
mout openMidiOutWithDevice: 5.
"
Class {
	#name : 'MIDISender',
	#superclass : 'Object',
	#instVars : [
		'midiOut',
		'defaultOutput',
		'instance',
		'deviceID'
	],
	#classVars : [
		'OpenDevices'
	],
	#category : 'Coypu-MIDI',
	#package : 'Coypu',
	#tag : 'MIDI'
}

{ #category : 'open/close' }
MIDISender class >> closeAll [
	self openDevices values copy do: [ :each | each close ]
]

{ #category : 'class initialization' }
MIDISender class >> initialize [
	SessionManager default registerUserClassNamed: self name
]

{ #category : 'open/close' }
MIDISender class >> openDevices [
	^ OpenDevices ifNil: [ OpenDevices := Dictionary new ]

]

{ #category : 'system startup' }
MIDISender class >> startUp: resuming [
	resuming ifTrue: [ OpenDevices := nil ]
]

{ #category : 'sending' }
MIDISender >> allNotesOff [

	1 to: 16 do: [ :i | 
		self sendCC: 123 withValue: 0 onChannel: i]
]

{ #category : 'initialization' }
MIDISender >> close [
	deviceID ifNil: [ ^ self ].
	PortMidiLibrary uniqueInstance portMidiCloseIOStream: midiOut value.
	self class openDevices removeKey: deviceID ifAbsent: [ ].
	deviceID := nil
]

{ #category : 'open/close' }
MIDISender >> closeMidiOut [
	"Close the MidiOUT stream (where the score sends notes)."
	^ PortMidiLibrary uniqueInstance portMidiCloseIOStream: midiOut value
]

{ #category : 'initialization' }
MIDISender >> defaultOutput [
	"Returns the defaultOutDeviceID of the user machine if it is online."
	^ defaultOutput
]

{ #category : 'initialization' }
MIDISender >> defaultOutput: aDevice [
	"Sets the new default output for the score."
	defaultOutput := aDevice
]

{ #category : 'logging' }
MIDISender >> deviceIDNamed: aString [
	^ [ PortMidiLibrary uniqueInstance idOfOutputPortNamed: aString ]
		  on: Error
		  do: [ -1 ]
]

{ #category : 'initialization' }
MIDISender >> initialize [

	self instance: PortMidiLibrary uniqueInstance.
	self defaultOutput: instance getDefaultOutputDeviceID.
	self midiOut: (instance createNewPointerForStreamWithType: 'void**').
	
	
]

{ #category : 'accessing' }
MIDISender >> instance [
^ instance
]

{ #category : 'accessing' }
MIDISender >> instance: aPortMIDIInstance [
instance := PortMidiLibrary uniqueInstance.
]

{ #category : 'testing' }
MIDISender >> isOpen [
	^ deviceID notNil
]

{ #category : 'initialization' }
MIDISender >> midiOut [
	"Gets the MidiOUT stream that is used to write the melody."
	^ midiOut
]

{ #category : 'initialization' }
MIDISender >> midiOut: anOutputStream [
	"Sets a new MidiOUT stream that is used to write the melody."
	midiOut := anOutputStream
]

{ #category : 'open/close' }
MIDISender >> openDevices [
	^ self class openDevices
]

{ #category : 'open/close' }
MIDISender >> openWithDevice: aDeviceIDOrName [
	"Open a MIDI out stream on a device given by id (Integer) or name (String).
	PortMidi traceAllDevices displays all available devices."

	^ aDeviceIDOrName openMidiStream: self
]

{ #category : 'outputManagement' }
MIDISender >> openWithDeviceID: aDeviceID [

	| err |
	aDeviceID = -1 ifTrue: [ ^ -1 ].
	self close.
	(self class openDevices at: aDeviceID ifAbsent: [ nil ]) ifNotNil: [ :previous | previous close ].
	instance := PortMidiLibrary uniqueInstance.
	self midiOut: (instance createNewPointerForStreamWithType: 'void**').
	err := instance
		       openOutputForStream: midiOut
		       withDevice: aDeviceID
		       withOutputDriverInfos: nil
		       withBufferSize: 512
		       withTimeProcedure: nil
		       withTimeInfos: nil
		       andLatency: 0.
	err = 0 ifTrue: [
			deviceID := aDeviceID.
			self class openDevices at: aDeviceID put: self.
			PerformerMIDI midiOut: self ].
	^ err
]

{ #category : 'initialization' }
MIDISender >> playChord: aNoteNumber type: aChordType onChannel: aMIDIChannel duration: aDurationInSeconds [

	" play aChord of aChordType with root aNoteNumber on the selected channel with a fixed velocity of 100"

	| noteOn noteOff chordOn chordOff mout |
	instance := self instance.

	noteOn := 144 + (aMIDIChannel - 1).
	noteOff := 128 + (aMIDIChannel - 1).
	chordOn := Array new: aChordType size.
	chordOff := Array new: aChordType size.

	mout := self.
	" create the chord"


	(1 to: aChordType size) do: [ :i | 
		chordOn at: i put: (PortMidi
				 message: noteOn
				 and: aNoteNumber + (aChordType at: i)
				 and: 100).
		chordOff at: i put: (PortMidi
				 message: noteOff
				 and: aNoteNumber + (aChordType at: i)
				 and: 100) ].

	[ 
	(1 to: aChordType size) do: [ :i | 
		(aNoteNumber + (aChordType at: i)) traceCr.
		instance
			writeShortOn: mout midiOut value
			when: 0
			theMessage: (chordOn at: i) ].

	(Delay forSeconds: aDurationInSeconds) wait.

	(1 to: aChordType size) do: [ :i | 
		instance
			writeShortOn: mout midiOut value
			when: 0
			theMessage: (chordOff at: i) ] ] fork
]

{ #category : 'sending' }
MIDISender >> playDrum: aNoteNumber onChannel: aMIDIChannel [
" play aNoteNumber on channel aChannel with no corresponding noteOff - intended for drums"
| instance noteOn channel |
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
noteOn := PortMidi  message: 144 + channel and: aNoteNumber  and: 100.

instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.

^ 'Drum was played'


]

{ #category : 'initialization' }
MIDISender >> playNote: aNoteNumber onChannel: aMIDIChannel [
	" play aNoteNumber on channel aChannel for a standard duration of 250 ms"

	| noteOn noteOff channel |
	instance := PortMidiLibrary uniqueInstance.
	channel := aMIDIChannel - 1.
	noteOn := PortMidi
		          message: 144 + aMIDIChannel
		          and: aNoteNumber
		          and: 100.
	noteOff := PortMidi
		           message: 128 + aMIDIChannel
		           and: aNoteNumber
		           and: 100.
	instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.
	(Delay forSeconds: 0.05) wait.
	instance writeShortOn: self midiOut value when: 0 theMessage: noteOff.
	^ 'note was played'
]

{ #category : 'initialization' }
MIDISender >> playNote: aNoteNumber onChannel: aMIDIChannel duration: aDurationInSeconds [

	" play aNoteNumber on channel aChannel for aDurationInSeconds"

	| noteOn noteOff channel |
	channel := aMIDIChannel - 1.
	noteOn := PortMidi
		          message: 144 + channel
		          and: aNoteNumber
		          and: 100.
	noteOff := PortMidi
		           message: 128 + channel
		           and: aNoteNumber
		           and: 100.
	[ 
	instance writeShortOn: self midiOut value when: 0 theMessage: noteOn.
	(Delay forSeconds: aDurationInSeconds) wait.
	instance writeShortOn: self midiOut value when: 0 theMessage: noteOff ]
		fork
]

{ #category : 'accessing' }
MIDISender >> portDirection [

	^ 'OUTPUT'
]

{ #category : 'sending' }
MIDISender >> sendCC: aCCNumber withValue: aValue onChannel: aMIDIChannel [
" play aNoteNumber on channel aChannel with no corresponding noteOff - intended for drums"
| cChange channel |
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
cChange := PortMidi  message: 176 + channel and: aCCNumber  and: aValue.

instance writeShortOn: self midiOut value when: 0 theMessage: cChange.




]

{ #category : 'sending' }
MIDISender >> sendClock [
	" send clock message to exteral MIDI device"

	|  clockMsg |

	clockMsg := PortMidi message: 248 and: 0 and: 0.

	instance writeShortOn: self midiOut value when: 0 theMessage: clockMsg "
"
]

{ #category : 'sending' }
MIDISender >> sendStart [
	" send Transport start message to exteral MIDI device"

	| startMsg clockMsg |
	startMsg := PortMidi message: 16rFA and: 0 and: 0.
	clockMsg := PortMidi message: 248 and: 0 and: 0.

	instance
		writeShortOn: self midiOut value
		when: 0
		theMessage: startMsg.
"
	instance
		writeShortOn: self midiOut value
		when: 0
		theMessage: clockMsg "
]

{ #category : 'sending' }
MIDISender >> sendStop [
	" send Transport start message to exteral MIDI device"

	| stopMsg  |
	stopMsg := PortMidi message: 16rFC and: 0 and: 0.
	

	instance writeShortOn: self midiOut value when: 0 theMessage: stopMsg 

]
