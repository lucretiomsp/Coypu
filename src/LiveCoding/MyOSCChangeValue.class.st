Class {
	#name : #MyOSCChangeValue,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'value'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #accessing }
MyOSCChangeValue >> announcer [

	^ announcer
]

{ #category : #initialization }
MyOSCChangeValue >> initialize [ 
announcer := Announcer new.
]

{ #category : #accessing }
MyOSCChangeValue >> value [ 
^ value
]

{ #category : #accessing }
MyOSCChangeValue >> value: aNumber [

	value := aNumber.
	announcer announce: OSCMsgReceivedAnnouncement  new
]
