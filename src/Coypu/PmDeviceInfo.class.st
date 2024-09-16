Class {
	#name : 'PmDeviceInfo',
	#superclass : 'FFIStructure',
	#classVars : [
		'OFFSET_INPUT',
		'OFFSET_INTERF',
		'OFFSET_ISVIRTUAL',
		'OFFSET_NAME',
		'OFFSET_OPENED',
		'OFFSET_OUTPUT',
		'OFFSET_STRUCTVERSION'
	],
	#category : 'Coypu',
	#package : 'Coypu'
}

{ #category : 'field definition' }
PmDeviceInfo class >> fieldsDesc [ 
^ #(
int structVersion;
char* interf;
char* name;
int input;
int output;
int opened;
int isVirtual;
)
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> input [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_INPUT
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> input: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_INPUT put: anObject
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> interf [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_INTERF) type: ExternalType char asPointerType
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> interf: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_INTERF put: anObject getHandle.
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> isVirtual [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_ISVIRTUAL
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> isVirtual: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_ISVIRTUAL put: anObject
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> name [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_NAME) type: ExternalType char asPointerType
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> name: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_NAME put: anObject getHandle.
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> opened [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_OPENED
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> opened: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_OPENED put: anObject
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> output [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_OUTPUT
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> output: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_OUTPUT put: anObject
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> structVersion [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_STRUCTVERSION
]

{ #category : 'accessing - structure variables' }
PmDeviceInfo >> structVersion: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_STRUCTVERSION put: anObject
]
