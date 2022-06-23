"
I represent the PmEvent structure of the external C library PortMidi.
"
Class {
	#name : #PortMidiEvent,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_MESSAGE',
		'OFFSET_TIMESTAMP'
	],
	#category : #LiveCoding
}

{ #category : #'field definition' }
PortMidiEvent class >> fieldsDesc [
	^ #(
		int message;
		int timestamp;
		)
]

{ #category : #'accessing - structure variables' }
PortMidiEvent >> message [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_MESSAGE
]

{ #category : #'accessing - structure variables' }
PortMidiEvent >> message: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_MESSAGE put: anObject
]

{ #category : #'accessing - structure variables' }
PortMidiEvent >> timestamp [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_TIMESTAMP
]

{ #category : #'accessing - structure variables' }
PortMidiEvent >> timestamp: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_TIMESTAMP put: anObject
]
