"
Play the slound on SuperDirt with the computer keyboard
"
Class {
	#name : #KeyboardToSuperDirt,
	#superclass : #KeyboardToOSC,
	#instVars : [
		'sound'
	],
	#category : #'Coypu-KeyboardControl'
}

{ #category : #'instance creation' }
KeyboardToSuperDirt class >> new: aStringWithASound [

	^ (self new) 
		sound: aStringWithASound ;
		color: Color darkGray ;
		onColor: Color white;
      offColor: Color darkGray ;
      label: aStringWithASound ;
		yourself
]

{ #category : #'event handling' }
KeyboardToSuperDirt >> keyDown: anEvent [

	| bundle |
	key := (self keyAsMIDINoteNumber: anEvent) -48.
	"key = 60 ifTrue: [ self color: Color yellow ]."
	" if the key pressed corresponds to a MIDI note"
	bundle := OSCBundle for: {OSCMessage for: { '/dirt/play' . 's' . self sound . 'n' . key}}.
	((key ~= -1) & isHandlingKeyDown) ifTrue: [  bundle sendToAddressString: '127.0.0.1' port: 57120]
]

{ #category : #accessing }
KeyboardToSuperDirt >> sound [

	^ sound
]

{ #category : #accessing }
KeyboardToSuperDirt >> sound: anObject [

	sound := anObject
]
