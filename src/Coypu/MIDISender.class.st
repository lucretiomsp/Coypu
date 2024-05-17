"
MIDISender
Use MIDISendere to send out MIDI events

example
mout := MIDISender new.
mout openMidiOutWithDevice: 5.
"
Class {
	#name : #MIDISender,
	#superclass : #Object,
	#instVars : [
		'midiOut',
		'defaultOutput',
		'instance'
	],
	#category : #'Coypu-MIDI'
}

{ #category : #'as yet unclassified' }
MIDISender >> allNotesOff [

1 to: 16 do: [ :i | 
self sendCC: 123 withValue: 0 onChannel: i]
]

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

	self instance: PortMidiLibrary uniqueInstance.
	self defaultOutput: instance getDefaultOutputDeviceID.
	self midiOut: (instance createNewPointerForStreamWithType: 'void**').
	
	
]

{ #category : #accessing }
MIDISender >> instance [
^ instance
]

{ #category : #accessing }
MIDISender >> instance: aPortMIDIInstance [
instance := PortMidiLibrary uniqueInstance.
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
MIDISender >> openWithDevice: aDeviceID [
	"Opens a new MidiOUT Stream with output device id aDeviceID to play notes.
	aDeviceID is an integer. PortMidi traceAllDevices / displays all available devices
	"
	
	self instance: PortMidiLibrary uniqueInstance.
	
	"assign the MIDISender to the PerformerMIDI"
	PerformerMIDI midiOut: self.
	
	self midiOut: (instance createNewPointerForStreamWithType: 'void**').
	^ (aDeviceID = -1) ifFalse: 
		[instance openOutputForStream: midiOut  
															withDevice: aDeviceID 
															withOutputDriverInfos: nil 
															withBufferSize: 512 
															withTimeProcedure: nil 
															withTimeInfos: nil 
															andLatency: 0 ] ifTrue: [ ^ -1 ]
]

{ #category : #initialization }
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

{ #category : #'as yet unclassified' }
MIDISender >> sendCC: aCCNumber withValue: aValue onChannel: aMIDIChannel [
" play aNoteNumber on channel aChannel with no corresponding noteOff - intended for drums"
| instance cChange channel |
instance := PortMidiLibrary uniqueInstance . 
channel := aMIDIChannel -1.
cChange := PortMidi  message: 176 + channel and: aCCNumber  and: aValue.

instance writeShortOn: self midiOut value when: 0 theMessage: cChange.




]

{ #category : #'as yet unclassified' }
MIDISender >> sendStart [

	" send Transport start message to exteral MIDI device"

	| startMsg clockMsg |
	startMsg := PortMidi message: 250 and: 0 and: 0.
	clockMsg := PortMidi message: 248 and: 0 and: 0.

	instance
		writeShortOn: self midiOut value
		when: 0
		theMessage: startMsg.
		
		instance
		writeShortOn: self midiOut value
		when: 0
		theMessage: clockMsg.
	
]
