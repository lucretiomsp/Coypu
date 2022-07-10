"
test
"
Class {
	#name : #ObservingBox,
	#superclass : #RSCanvas,
	#instVars : [
		'box'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #accessing }
ObservingBox >> box [
^ box
]

{ #category : #accessing }
ObservingBox >> box: anRSBox [

box := anRSBox 
]

{ #category : #initialization }
ObservingBox >> initialize [

	super initialize.
	self color: #black.
	self box: (RSBox new size: 140; color: #red).
	self add: box.
	self when: RSMouseClick do: [ 
		self box size: (Random new nextInteger: 400).
		self signalUpdate ]
]

{ #category : #subscription }
ObservingBox >> subscribeTo: anAnnouncer [

	| rand |
	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		rand := #( 0 255 ) at: (Random new nextInteger: 2).
		self color: (Color r: rand g: rand b: rand).
		self box size: ((OSCMsgReceivedAnnouncement values at: #'/snareGate') * 400).
		self signalUpdate ]
]
