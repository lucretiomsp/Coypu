Class {
	#name : #CoreMidiServices,
	#superclass : #FFILibrary,
	#category : #LiveCoding
}

{ #category : #'accessing - platform' }
CoreMidiServices >> getNumberOfDevices [
^ self ffiCall: #(int MIDIGetNumberOfDevices()) 
]

{ #category : #'accessing - platform' }
CoreMidiServices >> macModuleName [
^ '/system/library/frameworks/coremidi.framework'
]
