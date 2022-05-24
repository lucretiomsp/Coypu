Class {
	#name : #CoreFoundation,
	#superclass : #FFILibrary,
	#classVars : [
		'CFString',
		'CFStringRef'
	],
	#category : #LiveCoding
}

{ #category : #initialization }
CoreFoundation class >> initialize [ 
CFString := #FFIOpaqueObject.
CFStringRef  := #FFIExternalData.
]

{ #category : #'accessing - platform' }
CoreFoundation >> getLength: aString [
^ self ffiCall: #(int CFStringLength (String aString))
]

{ #category : #'accessing - platform' }
CoreFoundation >> macModuleName [
^ '/system/library/frameworks/corefoundation.framework'
]
