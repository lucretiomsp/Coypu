"
PortMidi for Pharo, Lucretio's edition
"
Class {
	#name : 'PortMidi',
	#superclass : 'FFILibrary',
	#instVars : [
		'outStream'
	],
	#category : 'Coypu-MIDI',
	#package : 'Coypu',
	#tag : 'MIDI'
}

{ #category : 'logging' }
PortMidi class >> countDevices [
^ self ffiCall: #(int Pm_CountDevices()) library: '//Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'writing' }
PortMidi class >> createNewPointerForStreamWithType: pointerType [
	"Create a new instance of FFIExternalValueHolder and an instance of this new class to get a pointer for poiterType."
	| midiStream valueHolderClass |
	valueHolderClass := FFIExternalValueHolder ofType: pointerType.
	midiStream := valueHolderClass new.
	^ midiStream tfPointerAddress.
]

{ #category : 'logging' }
PortMidi class >> deviceIDNamed: aString [
	"Answer the id of the device named aString, or -1 if none matches."

	^ (0 to: self countDevices - 1)
		  detect: [ :i | (self uniqueInstance getDeviceNameid: i) = aString ]
		  ifNone: [ -1 ]
]

{ #category : 'logging' }
PortMidi class >> deviceIDNamed: aString direction: aDirection [
	"aDirection is 'INPUT' or 'OUTPUT'. Answer the device id, or -1."

	| target |
	target := String streamContents: [ :stream |
		          stream
			          nextPutAll: aString;
			          nextPutAll: ' is ';
			          nextPutAll: aDirection ].
	^ (0 to: self countDevices - 1)
		  detect: [ :i | (self uniqueInstance getDeviceNameid: i) = target ]
		  ifNone: [ -1 ]s
]

{ #category : 'logging' }
PortMidi class >> deviceIDNamed: aString for: aMidiStream [
	"Answer the id of the device named aString in aMidiStream's direction, or -1."

	| target |
	target := String streamContents: [ :stream |
		          stream
			          nextPutAll: aString;
			          nextPutAll: ' is ';
			          nextPutAll: aMidiStream portDirection ].
	^ (0 to: self countDevices - 1)
		  detect: [ :i | (self uniqueInstance getDeviceNameid: i) = target ]
		  ifNone: [ -1 ]
]

{ #category : 'logging' }
PortMidi class >> getDeviceInfo: aDeviceID [
^ self ffiCall: #(PmDeviceInfo * Pm_GetDeviceInfo (int aDeviceID)) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'system startup' }
PortMidi class >> malloc: aSize [
^ self ffiCall: #(void * malloc (size_t aSize)) library: LibC
]

{ #category : 'messages' }
PortMidi class >> message: status and: data1 and: data2 [
| result|

result := (((data2 bitShift: 16) bitAnd: 16rFF0000) bitOr: ((data1 bitShift: 8) bitAnd: 16rFF00)) 
          bitOr: (status bitAnd: 16rFF).
^ result
]

{ #category : 'system startup' }
PortMidi class >> openOutput: aDeviceIntID on: aPortMidiStream [
self ffiCall: 
#(PmError Pm_OpenOutput #(void ** aPortMidiStream, int aDeviceIntID, NULL, int 512, NULL, NULL, int 0))
library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'system startup' }
PortMidi class >> pm_Initialize [
self ffiCall: #(PmError Pm_Initialize ()) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'system startup' }
PortMidi class >> start [
^ self ffiCall:  #(PtError Pt_Start(int 1, NULL, NULL))
library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'debugging actions' }
PortMidi class >> terminate [
^ self ffiCall: #(PmError Pm_Terminate()) library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'logging' }
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

{ #category : 'writing' }
PortMidi class >> writeShortOn: aPointerToAStream for: aPmMessage [
"messages is sent out immediately, so timestamp is 0"
^ self ffiCall: #(PmError Pm_WriteShort (void *aPointerToAStream, 0, int aPmMessage))
 library: '/Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
]

{ #category : 'open/close' }
PortMidi >> close: aMIDIStream [
	^ self ffiCall: #(PmError Pm_Close(void* aMIDIStream))
]

{ #category : 'accessing - devices' }
PortMidi >> countDevices [
	^ self ffiCall: #(int Pm_CountDevices()) 
]

{ #category : 'ioManagement' }
PortMidi >> createNewPointerForStreamWithType: pointerType [
	"Create a new instance of FFIExternalValueHolder and an instance of this new class to get a pointer for poiterType."
	| midiStream valueHolderClass |
	valueHolderClass := FFIExternalValueHolder ofType: pointerType.
	midiStream := valueHolderClass new.
	^ midiStream tfPointerAddress.
]

{ #category : 'initialization' }
PortMidi >> createOutStream [

	outStream  := self class createNewPointerForStreamWithType: 'void**'.
	^ outStream 
]

{ #category : 'accessing - devices' }
PortMidi >> getDeviceInfo: aDeviceID [
	^ self ffiCall: #(PmDeviceInfo * Pm_GetDeviceInfo (int aDeviceID)) 
]

{ #category : 'accessing - devices' }
PortMidi >> getDeviceNameid: aDeviceID [

	| name type |
	name := (self getDeviceInfo: aDeviceID) name bytesFromCString
		        utf8Decoded.
	(self getDeviceInfo: aDeviceID) input = 0
		ifTrue: [ type := ' is OUTPUT' ]
		ifFalse: [ type := ' is INPUT' ].
	^ name , type
]

{ #category : 'initialization' }
PortMidi >> initialize [ 
	outStream  := 99.
]

{ #category : 'accessing - platform' }
PortMidi >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libportmidi.2.0.3.dylib'
]

{ #category : 'accessing - platform' }
PortMidi >> macModuleName [
	"Returns the name of the PortMidi library for Mac."
	^ 'libportmidi.2.0.3.dylib'
]

{ #category : 'messages' }
PortMidi >> message: status and: data1 and: data2 [
	
	| result|
	result := (((data2 bitShift: 16) bitAnd: 16rFF0000) bitOr: ((data1 bitShift: 8) bitAnd: 16rFF00)) 
          bitOr: (status bitAnd: 16rFF).
	^ result
]

{ #category : 'open/close' }
PortMidi >> openOutput: aDeviceIntID [ 
	self ffiCall: 
#(PmError Pm_OpenOutput #(void ** outStream, int aDeviceIntID, NULL, int 0, NULL, NULL, int 0))
]

{ #category : 'open/close' }
PortMidi >> openOutput: aDeviceIntID on: aPortMidiStream [
	self ffiCall: 
#(PmError Pm_OpenOutput #(void ** aPortMidiStream, int aDeviceIntID, NULL, int 0, NULL, NULL, int 0))
]

{ #category : 'accessing - platform' }
PortMidi >> outStream [ 
	^ outStream
]

{ #category : 'messages' }
PortMidi >> playNote: aNoteNumber onChannel: aMIDIChannel [
	" play aNoteNumber on channel aChannel for a standard duration of 250 ms"
	| noteOn noteOff channel|
	channel := aMIDIChannel -1.
	noteOn := self message: 144 + aMIDIChannel and: aNoteNumber  and: 100.
	noteOff := self message: 128 + aMIDIChannel and: aNoteNumber  and: 100.


]

{ #category : 'initialization' }
PortMidi >> pm_Initialize [
	self ffiCall: #(PmError Pm_Initialize ()) 
]

{ #category : 'initialization' }
PortMidi >> start [
	^ self ffiCall:  #(PtError Pt_Start(int 1, NULL, NULL))
]

{ #category : 'initialization' }
PortMidi >> terminate [
	^ self ffiCall: #(PmError Pm_Terminate()) 
]

{ #category : 'writing' }
PortMidi >> writeOn: aPointerToStream event: aBuffer length: aLength [
	^ self ffiCall: #(PmError Pm_Write(void * aPointerToStream, PmEvent* aBuffer, int aLength))
]

{ #category : 'messages' }
PortMidi >> writeShortOn: aPointerToAStream for: aPmMessage [
	"messages is sent out immediately, so timestamp is 0"
	^ self ffiCall: #(PmError Pm_WriteShort (void *aPointerToAStream, int -1, int aPmMessage))
]
