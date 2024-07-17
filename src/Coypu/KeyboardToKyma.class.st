Class {
	#name : 'KeyboardToKyma',
	#superclass : 'KeyboardToOSC',
	#category : 'Coypu-KeyboardControl',
	#package : 'Coypu',
	#tag : 'KeyboardControl'
}

{ #category : 'event handling' }
KeyboardToKyma >> keyDown: anEvent [

	key := self keyAsMIDINoteNumber: anEvent.
	"key = 60 ifTrue: [ self color: Color yellow ]."
	" if the key pressed corresponds to a MIDI note"

	((key ~= -1) & isHandlingKeyDown) 
		ifTrue: [  address toKymaAsNoteOn: key + (octave * 12)]
]

{ #category : 'event handling' }
KeyboardToKyma >> keyUp: anEvent [

	key := self keyAsMIDINoteNumber: anEvent.
	"key = 60 ifTrue: [ self color: Color yellow ]."
	" if the key pressed corresponds to a MIDI note"
	
	((key ~= -1) & isHandlingKeyDown) 
		ifTrue: [  address toKymaAsNoteOff: key + (octave * 12)]
]
