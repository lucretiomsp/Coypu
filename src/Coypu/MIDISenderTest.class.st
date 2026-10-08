Class {
	#name : 'MIDISenderTest',
	#superclass : 'TestCase',
	#instVars : [
		'deviceName'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'asserting' }
MIDISenderTest >> assertNoError: err [
	self
		assert: err = 0
		description: [ PortMidiLibrary uniqueInstance getErrorText: err ]
]

{ #category : 'running' }
MIDISenderTest >> setUp [
	super setUp.
	deviceName := 'IAC Driver Bus 1'.
	(PortMidiLibrary uniqueInstance outputPortNames includes: deviceName)
		ifFalse: [ self skip: deviceName , ' not available' ].
	MIDISender closeAll
]

{ #category : 'running' }
MIDISenderTest >> setup [ 
super setUp.
	deviceName := 'IAC Driver Bus 1'.
	(PortMidiLibrary uniqueInstance outputPortNames includes: deviceName)
		ifFalse: [ self skip: deviceName , ' not available' ].
	MIDISender closeAll
]

{ #category : 'running' }
MIDISenderTest >> tearDown [
	MIDISender closeAll.
	super tearDown
]

{ #category : 'asserting' }
MIDISenderTest >> testCloseAll [
	MIDISender new openWithDevice: deviceName.
	MIDISender closeAll.
	self assert: MIDISender openDevices isEmpty
]

{ #category : 'asserting' }
MIDISenderTest >> testCloseTwiceIsHarmless [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	self shouldnt: [ sender close ] raise: Error
]

{ #category : 'asserting' }
MIDISenderTest >> testCloseUnopenedIsHarmless [

	MIDISender new close
]

{ #category : 'asserting' }
MIDISenderTest >> testCloseUnregisters [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	self deny: sender isOpen.
	self assert: MIDISender openDevices isEmpty
]

{ #category : 'asserting' }
MIDISenderTest >> testInvalidID [
	self assert: (MIDISender new openWithDevice: -1) equals: -1.
	self assert: MIDISender openDevices isEmpty
]

{ #category : 'asserting' }
MIDISenderTest >> testNewInstanceTakesOverDevice [
	| first second |
	first := MIDISender new.
	first openWithDevice: deviceName.
	second := MIDISender new.
	self assertNoError: (second openWithDevice: deviceName).
	self deny: first isOpen.
	self assert: second isOpen.
	self assert: MIDISender openDevices size equals: 1
]

{ #category : 'asserting' }
MIDISenderTest >> testNewSenderIsClosed [
	self deny: MIDISender new isOpen
]

{ #category : 'asserting' }
MIDISenderTest >> testOpenByID [
	| sender id |
	id := PortMidiLibrary uniqueInstance idOfOutputPortNamed: deviceName.
	sender := MIDISender new.
	self assertNoError: (sender openWithDevice: id).
	self assert: sender isOpen

]

{ #category : 'asserting' }
MIDISenderTest >> testOpenByName [
	| sender |
	sender := MIDISender new.
	self assertNoError: (sender openWithDevice: deviceName).
	self assert: sender isOpen.
	self assert: (MIDISender openDevices includes: sender)
]

{ #category : 'asserting' }
MIDISenderTest >> testReopenAfterClose [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	self assertNoError: (MIDISender new openWithDevice: deviceName)

]

{ #category : 'asserting' }
MIDISenderTest >> testReopenSameInstance [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	self assertNoError: (sender openWithDevice: deviceName).
	self assert: sender isOpen.
	self assert: MIDISender openDevices size equals: 1

]

{ #category : 'asserting' }
MIDISenderTest >> testUnknownName [
	self
		assert: (MIDISender new openWithDevice: 'No Such Device')
		equals: -1.
	self assert: MIDISender openDevices isEmpty
]
