"
Subcalss of OSCSever for the Announcements
"
Class {
	#name : #LiveCodingOSCServer,
	#superclass : #OSCServer,
	#instVars : [
		'announcer',
		'rcvValue'
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

{ #category : #initialization }
LiveCodingOSCServer >> rcvValue [
^ rcvValue 
]

{ #category : #action }
LiveCodingOSCServer >> receive: aByteStream [

	"messageQueue flush."

	"old messages are flushed"

	(OSCParser parse: aByteStream) do: [ :eachMessageArray | 
		messageQueue nextPut: eachMessageArray ].
	"OSCMsgReceivedAnnouncement setValue: (messageQueue next at: 2)."
	OSCMsgReceivedAnnouncement setValues: messageQueue next.
	"announcer announce: OSCMsgReceivedAnnouncement new."
	self setValue: (Random new nextInteger: 910).
	"OSCMsgReceivedAnnouncement setValue: (messageQueue next at: 2)."
	Delay forMilliseconds: responsePeriod
]

{ #category : #initialization }
LiveCodingOSCServer >> setValue: aFloat [

	rcvValue := aFloat.
	 announcer announce: OSCMsgReceivedAnnouncement new
]
