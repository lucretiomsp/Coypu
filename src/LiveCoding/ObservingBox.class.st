"
test
"
Class {
	#name : #ObservingBox,
	#superclass : #RSCanvas,
	#category : #'LiveCoding-Announcements'
}

{ #category : #initialization }
ObservingBox >> initialize [
| box |
	super initialize.
	
	box := RSBox new size: 140.
self add: box.
self when: RSMouseClick  do:
[ box size: (Random new nextInteger: 400).
	self signalUpdate  ].
]

{ #category : #subscription }
ObservingBox >> subscribeTo: anAnnouncer [

	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		self color: (Color
				 r: (Random new nextInteger: 255)
				 g: (Random new nextInteger: 255)
				 b: (Random new nextInteger: 255)).
				self signalUpdate  ]
]
