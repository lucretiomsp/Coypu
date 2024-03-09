Class {
	#name : #PmEvent,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_MESSAGE',
		'OFFSET_TIMESTAMP'
	],
	#category : #Coypu
}

{ #category : #'field definition' }
PmEvent class >> fieldsDesc [ 
^
#(
int message;
int timestamp;
)
]

{ #category : #'accessing - structure variables' }
PmEvent >> message [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_MESSAGE
]

{ #category : #'accessing - structure variables' }
PmEvent >> message: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_MESSAGE put: anObject
]

{ #category : #'accessing - structure variables' }
PmEvent >> timestamp [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_TIMESTAMP
]

{ #category : #'accessing - structure variables' }
PmEvent >> timestamp: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_TIMESTAMP put: anObject
]
