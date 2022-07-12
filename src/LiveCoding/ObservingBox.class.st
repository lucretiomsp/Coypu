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
	
	self color: Color transparent. " #black ".
	self box: (RSBox new
			 size: 140;
			 color: #red).
	self add: box.
	self when: RSMouseClick do: [ 
		self box size: (Random new nextInteger: 400).
		self signalUpdate ]
]

{ #category : #subscription }
ObservingBox >> subscribeTo: anAnnouncer [

	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		| kickG |
		kickG := (OSCMsgReceivedAnnouncement values at: #'/kickGate') * 255.
		"self color: (Color r: kickG g: kickG b: kickG)."
		"(OSCMsgReceivedAnnouncement values at: #'/kickGate') * 255"
		self box size:
			(OSCMsgReceivedAnnouncement values at: #'/snareGate') * 400.
		self signalUpdate ]
]
