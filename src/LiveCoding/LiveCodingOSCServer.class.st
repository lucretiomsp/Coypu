"
Subcalss of OSCSever for the Announcements
"
Class {
	#name : #LiveCodingOSCServer,
	#superclass : #OSCServer,
	#instVars : [
		'announcer'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #accessing }
LiveCodingOSCServer >> announcer [ 
^ announcer 
]

{ #category : #initialization }
LiveCodingOSCServer >> initialize [ 
super initialize.
	announcer := Announcer new
]

{ #category : #action }
LiveCodingOSCServer >> receive: aByteStream [

	messageQueue flush. "old messages are flushed"
	announcer announce: OSCMsgReceivedAnnouncement new.
	(OSCParser parse: aByteStream) do: [ :eachMessageArray | 
		messageQueue nextPut: eachMessageArray ].
	Delay forMilliseconds: responsePeriod
]
