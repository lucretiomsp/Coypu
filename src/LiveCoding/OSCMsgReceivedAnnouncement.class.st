Class {
	#name : #OSCMsgReceivedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'value'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #accessing }
OSCMsgReceivedAnnouncement >> value [ 
^ value
]

{ #category : #accessing }
OSCMsgReceivedAnnouncement >> value: aNumber [
value := aNumber 
]
