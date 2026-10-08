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

{ #category : 'running' }
MIDISenderTest >> setUp [
	super setUp.
	deviceName := 'IAC Driver Bus 1'.
	(PortMidi deviceIDNamed: deviceName for: MIDISender new) = -1
		ifTrue: [ self skip: deviceName , ' not available' ].
	MIDISender closeAll
]

{ #category : 'running' }
MIDISenderTest >> tearDown [
	MIDISender closeAll.
	super tearDown
]

{ #category : 'running' }
MIDISenderTest >> testCloseAll [
	(MIDISender new) openWithDevice: deviceName.
	MIDISender closeAll.
	self assert: MIDISender openDevices isEmpty
]

{ #category : 'running' }
MIDISenderTest >> testCloseTwiceIsHarmless [

	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	sender close
]

{ #category : 'running' }
MIDISenderTest >> testCloseUnregisters [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	self deny: sender isOpen.
	self assert: MIDISender openDevices isEmpty
]

{ #category : 'running' }
MIDISenderTest >> testNewInstanceTakesOverDevice [
	| first second |
	first := MIDISender new.
	first openWithDevice: deviceName.
	second := MIDISender new.
	self assert: (second openWithDevice: deviceName) equals: 0.
	self deny: first isOpen.
	self assert: second isOpen.
	self assert: MIDISender openDevices size equals: 1
]

{ #category : 'running' }
MIDISenderTest >> testOpenByName [
	| sender |
	sender := MIDISender new.
	self assert: (sender openWithDevice: deviceName) equals: 0.
	self assert: sender isOpen.
	self assert: (MIDISender openDevices includes: sender)
]

{ #category : 'running' }
MIDISenderTest >> testReopenAfterClose [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	sender close.
	self assert: (MIDISender new openWithDevice: deviceName) equals: 0
]

{ #category : 'running' }
MIDISenderTest >> testReopenSameInstance [
	| sender |
	sender := MIDISender new.
	sender openWithDevice: deviceName.
	self assert: (sender openWithDevice: deviceName) equals: 0.
	self assert: MIDISender openDevices size equals: 1
]

{ #category : 'running' }
MIDISenderTest >> testUnknownName [
	self
		assert: (MIDISender new openWithDevice: 'No Such Device')
		equals: -1.
	self assert: MIDISender openDevices isEmpty
]
