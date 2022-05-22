Class {
	#name : #PortMidi,
	#superclass : #FFILibrary,
	#category : #LiveCoding
}

{ #category : #'as yet unclassified' }
PortMidi class >> countDevices [
^ self ffiCall: #(int Pm_CountDevices()) library: '//Users/domenicocipriani/MyStuff/portmidi-master/Release/libportmidi.2.0.3.dylib'
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

{ #category : #'as yet unclassified' }
PortMidi >> countDevices [
^ self ffiCall: #(int Pm_CountDevices()) 
]

{ #category : #'as yet unclassified' }
PortMidi >> getDeviceInfo: aDeviceID [
^ self ffiCall: #(PmDeviceInfo * Pm_GetDeviceInfo (int aDeviceID)) 
]

{ #category : #'as yet unclassified' }
PortMidi >> getDeviceNameid: aDeviceID [
| name type |
name := (self getDeviceInfo: aDeviceID ) name fromCString .
(((self getDeviceInfo: aDeviceID ) input) = 1) ifTrue:  [ type := ' is input' ] ifFalse: [ type := 'is output' ].
^ name , type.
]

{ #category : #'accessing - platform' }
PortMidi >> macModuleName [
	"Returns the name of the PortMidi library for Mac."
	^ 'libportmidi.2.0.3.dylib'
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

{ #category : #'as yet unclassified' }
PortMidi >> writeShortOn: aPointerToAStream for: aPmMessage [
"messages is sent out immediately, so timestamp is 0"
^ self ffiCall: #(PmError Pm_WriteShort (void *aPointerToAStream, 0, int aPmMessage))
]
