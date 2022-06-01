Class {
	#name : #KeyboardToKyma,
	#superclass : #KeyboardToOSC,
	#category : #LiveCoding
}

{ #category : #'event handling' }
KeyboardToKyma >> keyDown: anEvent [


key := self keyAsMIDINoteNumber: anEvent.
"key = 60 ifTrue: [ self color: Color yellow ]."
" if the key pressed corresponds to a MIDI note"
((key ~= 0) & isHandlingKeyDown) ifTrue: [  address toKymaAsGate: 0.1 note: key] ifFalse:[nil]
]
