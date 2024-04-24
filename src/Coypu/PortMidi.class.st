"
PortMidi for Pharo, Lucretio's edition
"
Class {
	#name : #PortMidi,
	#superclass : #FFILibrary,
	#instVars : [
		'outStream'
	],
	#category : #'Coypu-MIDI'
}

{ #category : #'as yet unclassified' }
PortMidi class >> countDevices [
^ self ffiCall: #(int Pm_CountDevices()) library: '//Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #writing }
PortMidi class >> createNewPointerForStreamWithType: pointerType [
	"Create a new instance of FFIExternalValueHolder and an instance of this new class to get a pointer for poiterType."
	| midiStream valueHolderClass |
	valueHolderClass := FFIExternalValueHolder ofType: pointerType.
	midiStream := valueHolderClass new.
	^ midiStream tfPointerAddress.
]

{ #category : #'as yet unclassified' }
PortMidi class >> getDeviceInfo: aDeviceID [
^ self ffiCall: #(PmDeviceInfo * Pm_GetDeviceInfo (int aDeviceID)) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'as yet unclassified' }
PortMidi class >> malloc: aSize [
^ self ffiCall: #(void * malloc (size_t aSize)) library: LibC
]

{ #category : #'as yet unclassified' }
PortMidi class >> message: status and: data1 and: data2 [
| result|

result := (((data2 bitShift: 16) bitAnd: 16rFF0000) bitOr: ((data1 bitShift: 8) bitAnd: 16rFF00)) 
          bitOr: (status bitAnd: 16rFF).
^ result
]

{ #category : #'as yet unclassified' }
PortMidi class >> openOutput: aDeviceIntID on: aPortMidiStream [
self ffiCall: 
#(PmError Pm_OpenOutput #(void ** aPortMidiStream, int aDeviceIntID, NULL, int 512, NULL, NULL, int 0))
library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'as yet unclassified' }
PortMidi class >> pm_Initialize [
self ffiCall: #(PmError Pm_Initialize ()) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'system startup' }
PortMidi class >> start [
^ self ffiCall:  #(PtError Pt_Start(int 1, NULL, NULL))
library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'debugging actions' }
PortMidi class >> terminate [
^ self ffiCall: #(PmError Pm_Terminate()) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'as yet unclassified' }
PortMidi class >> traceAllDevices [
	" return an array of MIDI devices"

	| devices |
	devices := (0 to: self countDevices - 1) collect: [ :i |
		           self uniqueInstance getDeviceNameid: i ].
	Transcript
		clear.
	 0 to: self countDevices - 1 do: [ :i | Transcript show: i; tab.
	(self uniqueInstance getDeviceNameid: i) traceCr ].
	
	Transcript	open
]

{ #category : #writing }
PortMidi class >> writeShortOn: aPointerToAStream for: aPmMessage [
"messages is sent out immediately, so timestamp is 0"
^ self ffiCall: #(PmError Pm_WriteShort (void *aPointerToAStream, 0, int aPmMessage))
 library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : #'as yet unclassified' }
PortMidi >> close: aMIDIStream [
	^ self ffiCall: #(PmError Pm_Close(void* aMIDIStream))
]

{ #category : #'accessing - devices' }
PortMidi >> countDevices [
	^ self ffiCall: #(int Pm_CountDevices()) 
]

{ #category : #ioManagement }
PortMidi >> createNewPointerForStreamWithType: pointerType [
	"Create a new instance of FFIExternalValueHolder and an instance of this new class to get a pointer for poiterType."
	| midiStream valueHolderClass |
	valueHolderClass := FFIExternalValueHolder ofType: pointerType.
	midiStream := valueHolderClass new.
	^ midiStream tfPointerAddress.
]

{ #category : #'as yet unclassified' }
PortMidi >> createOutStream [

	outStream  := self class createNewPointerForStreamWithType: 'void**'.
	^ outStream 
]

{ #category : #'accessing - devices' }
PortMidi >> getDeviceInfo: aDeviceID [
	^ self ffiCall: #(PmDeviceInfo * Pm_GetDeviceInfo (int aDeviceID)) 
]

{ #category : #'accessing - devices' }
PortMidi >> getDeviceNameid: aDeviceID [

	| name type |
	name := (self getDeviceInfo: aDeviceID) name bytesFromCString
		        utf8Decoded.
	(self getDeviceInfo: aDeviceID) input = 0
		ifTrue: [ type := ' is OUTPUT' ]
		ifFalse: [ type := 'is INPUT' ].
	^ name , type
]

{ #category : #initialization }
PortMidi >> initialize [ 
	outStream  := 99.
]

{ #category : #'accessing - platform' }
PortMidi >> macModuleName [
	"Returns the name of the PortMidi library for Mac."
	^ 'libportmidi.2.0.3.dylib'
]

{ #category : #'as yet unclassified' }
PortMidi >> message: status and: data1 and: data2 [
	
	| result|
	result := (((data2 bitShift: 16) bitAnd: 16rFF0000) bitOr: ((data1 bitShift: 8) bitAnd: 16rFF00)) 
          bitOr: (status bitAnd: 16rFF).
	^ result
]

{ #category : #'as yet unclassified' }
PortMidi >> openOutput: aDeviceIntID [ 
	self ffiCall: 
#(PmError Pm_OpenOutput #(void ** outStream, int aDeviceIntID, NULL, int 0, NULL, NULL, int 0))
]

{ #category : #'as yet unclassified' }
PortMidi >> openOutput: aDeviceIntID on: aPortMidiStream [
	self ffiCall: 
#(PmError Pm_OpenOutput #(void ** aPortMidiStream, int aDeviceIntID, NULL, int 0, NULL, NULL, int 0))
]

{ #category : #'as yet unclassified' }
PortMidi >> outStream [ 
	^ outStream
]

{ #category : #'as yet unclassified' }
PortMidi >> playNote: aNoteNumber onChannel: aMIDIChannel [
	" play aNoteNumber on channel aChannel for a standard duration of 250 ms"
	| noteOn noteOff channel|
	channel := aMIDIChannel -1.
	noteOn := self message: 144 + aMIDIChannel and: aNoteNumber  and: 100.
	noteOff := self message: 128 + aMIDIChannel and: aNoteNumber  and: 100.


]

{ #category : #'as yet unclassified' }
PortMidi >> pm_Initialize [
	self ffiCall: #(PmError Pm_Initialize ()) 
]

{ #category : #'as yet unclassified' }
PortMidi >> start [
	^ self ffiCall:  #(PtError Pt_Start(int 1, NULL, NULL))
]

{ #category : #'as yet unclassified' }
PortMidi >> terminate [
	^ self ffiCall: #(PmError Pm_Terminate()) 
]

{ #category : #writing }
PortMidi >> writeOn: aPointerToStream event: aBuffer length: aLength [
	^ self ffiCall: #(PmError Pm_Write(void * aPointerToStream, PmEvent* aBuffer, int aLength))
]

{ #category : #'as yet unclassified' }
PortMidi >> writeShortOn: aPointerToAStream for: aPmMessage [
	"messages is sent out immediately, so timestamp is 0"
	^ self ffiCall: #(PmError Pm_WriteShort (void *aPointerToAStream, int -1, int aPmMessage))
]
