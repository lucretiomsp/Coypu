Extension { #name : #OSCServer }

{ #category : #'*LiveCoding' }
OSCServer >> lastMessage [
"get the last received OSC message"
	messageQueue := SharedQueue new.
	^ messageQueue next
]
