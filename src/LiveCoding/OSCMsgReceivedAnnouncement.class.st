Class {
	#name : #OSCMsgReceivedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'value'
	],
	#classVars : [
		'Values'
	],
	#classInstVars : [
		'value'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #initialization }
OSCMsgReceivedAnnouncement class >> setValue: aNumber [
value := aNumber
]

{ #category : #initialization }
OSCMsgReceivedAnnouncement class >> setValues: anOSCParsedMessage [
|address lastValue|
address := (anOSCParsedMessage at: 1) asSymbol .
lastValue := anOSCParsedMessage at: 2.

Values at: address put: lastValue 
]

{ #category : #initialization }
OSCMsgReceivedAnnouncement class >> value [
^ value
]

{ #category : #initialization }
OSCMsgReceivedAnnouncement class >> values [

	^ Values
]

{ #category : #initialization }
OSCMsgReceivedAnnouncement >> initialize [

	super initialize.
	Values ifNil: [ Values := Dictionary new ]
]

{ #category : #accessing }
OSCMsgReceivedAnnouncement >> value [ 
^ value
]

{ #category : #accessing }
OSCMsgReceivedAnnouncement >> value: aNumber [
value := aNumber 
]
