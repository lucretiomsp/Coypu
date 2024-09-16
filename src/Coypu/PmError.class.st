Class {
	#name : 'PmError',
	#superclass : 'FFIEnumeration',
	#classVars : [
		'pmBadData',
		'pmBadPtr',
		'pmBufferMaxSize',
		'pmGotData',
		'pmInterfaceNotSupoorted',
		'pmInvalidDeviceId',
		'pmNameConflict',
		'pmNoData',
		'pmNoError',
		'pmNotImplemented'
	],
	#category : 'Coypu',
	#package : 'Coypu'
}

{ #category : 'enum declaration' }
PmError class >> enumDecl [
	^ #(
	pmNoError 0
	pmNoData 1
	pmGotData 2
	pmInvalidDeviceId 3 
	pmBadPtr 4
	pmBadData 5
	pmBufferMaxSize 6 
	pmNotImplemented 7
	pmInterfaceNotSupoorted 8 
	pmNameConflict 9)
]
