Class {
	#name : 'MIDIReceiverTest',
	#superclass : 'TestCase',
	#instVars : [
		'deviceName'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'asserting' }
MIDIReceiverTest >> assertNoError: err [
	self
		assert: err = 0
		description: [
			err isInteger
				ifTrue: [ PortMidiLibrary uniqueInstance getErrorText: err ]
				ifFalse: [ 'expected an error code, got ' , err printString ] ]

]

{ #category : 'running' }
MIDIReceiverTest >> setUp [
	super setUp.
	MIDIReceiver closeAll.
	MIDISender closeAll.
	PortMidiLibrary uniqueInstance reset.
	deviceName := 'IAC Driver Bus 1'.
	(PortMidiLibrary uniqueInstance inputPortNames includes: deviceName)
		ifFalse: [ self skip: deviceName , ' not available' ]

]

{ #category : 'running' }
MIDIReceiverTest >> tearDown [
	MIDIReceiver closeAll.
	MIDISender closeAll.
	super tearDown
]

{ #category : 'asserting' }
MIDIReceiverTest >> testCloseAll [
	MIDIReceiver new openWithDevice: deviceName.
	MIDIReceiver closeAll.
	self assert: MIDIReceiver openDevices isEmpty
]

{ #category : 'asserting' }
MIDIReceiverTest >> testCloseStopsReceiving [
	| receiver process |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	process := receiver traceIncomingMessage.
	receiver close.
	self assert: process isTerminated.
	self assert: receiver receivinProcess isNil
]

{ #category : 'asserting' }
MIDIReceiverTest >> testCloseTwiceIsHarmless [
	| receiver |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	receiver close.
	self shouldnt: [ receiver close ] raise: Error

]

{ #category : 'asserting' }
MIDIReceiverTest >> testCloseUnopenedIsHarmless [

	MIDIReceiver new close
]

{ #category : 'asserting' }
MIDIReceiverTest >> testCloseUnregisters [
	| receiver |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	self assertNoError: receiver close.
	self deny: receiver isOpen.
	self assert: MIDIReceiver openDevices isEmpty
]

{ #category : 'asserting' }
MIDIReceiverTest >> testInvalidID [
	self assert: (MIDIReceiver new openWithDevice: -1) equals: -1.
	self assert: MIDIReceiver openDevices isEmpty
]

{ #category : 'asserting' }
MIDIReceiverTest >> testLookupIsInput [
	| id |
	id := MIDIReceiver new deviceIDNamed: deviceName.
	self assert: (PortMidiLibrary uniqueInstance getDeviceInfo: id) isInput
]

{ #category : 'asserting' }
MIDIReceiverTest >> testLoopbackReceivesCC [
	| lib sender receiver buffer deadline |
	lib := PortMidiLibrary uniqueInstance.
	receiver := MIDIReceiver new.
	self assertNoError: (receiver openWithDevice: deviceName).
	sender := MIDISender new.
	self assertNoError: (sender openWithDevice: deviceName).

	sender sendCC: 7 withValue: 100 onChannel: 1.

	deadline := Time millisecondClockValue + 1000.
	[ (lib portMidiPoll: receiver midiInput value) = 1
		or: [ Time millisecondClockValue > deadline ] ]
		whileFalse: [ 1 milliSecond wait ].
	self
		assert: (lib portMidiPoll: receiver midiInput value) = 1
		description: 'nothing received within 1 second'.

	buffer := PortMidiEvent new.
	lib readOn: receiver midiInput value inBuffer: buffer withSize: 1.
	self assert: (lib portMidiGetStatusFromMessage: buffer message) equals: 16rB0.
	self assert: (lib portMidiGetFirstDataFromMessage: buffer message) equals: 7.
	self assert: (lib portMidiGetSecondDataFromMessage: buffer message) equals: 100
]

{ #category : 'asserting' }
MIDIReceiverTest >> testNewInstanceTakesOverDevice [
	| first second |
	first := MIDIReceiver new.
	first openWithDevice: deviceName.
	second := MIDIReceiver new.
	self assertNoError: (second openWithDevice: deviceName).
	self deny: first isOpen.
	self assert: second isOpen.
	self assert: MIDIReceiver openDevices size equals: 1
]

{ #category : 'asserting' }
MIDIReceiverTest >> testNewReceiverIsClosed [
	self deny: MIDIReceiver new isOpen
]

{ #category : 'asserting' }
MIDIReceiverTest >> testOpenByID [
	| receiver id |
	id := PortMidiLibrary uniqueInstance idOfInputPortNamed: deviceName.
	receiver := MIDIReceiver new.
	self assertNoError: (receiver openWithDevice: id).
	self assert: receiver isOpen
]

{ #category : 'asserting' }
MIDIReceiverTest >> testOpenByName [
	| receiver |
	receiver := MIDIReceiver new.
	self assertNoError: (receiver openWithDevice: deviceName).
	self assert: receiver isOpen.
	self assert: (MIDIReceiver openDevices includes: receiver)
]

{ #category : 'asserting' }
MIDIReceiverTest >> testReopenAfterClose [
	| receiver |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	receiver close.
	self assertNoError: (MIDIReceiver new openWithDevice: deviceName)

]

{ #category : 'asserting' }
MIDIReceiverTest >> testReopenSameInstance [
	| receiver |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	self assertNoError: (receiver openWithDevice: deviceName).
	self assert: receiver isOpen.
	self assert: MIDIReceiver openDevices size equals: 1
]

{ #category : 'asserting' }
MIDIReceiverTest >> testSaveKeepsRegistry [
	| receiver |
	receiver := MIDIReceiver new.
	receiver openWithDevice: deviceName.
	MIDIReceiver startUp: false.
	self assert: (MIDIReceiver openDevices includes: receiver)
]

{ #category : 'asserting' }
MIDIReceiverTest >> testStartUpClearsRegistry [
	MIDIReceiver openDevices at: 99 put: Object new.
	MIDIReceiver startUp: true.
	self assert: MIDIReceiver openDevices isEmpty
]

{ #category : 'asserting' }
MIDIReceiverTest >> testUnknownName [
	self
		assert: (MIDIReceiver new openWithDevice: 'No Such Device')
		equals: -1.
	self assert: MIDIReceiver openDevices isEmpty
]
