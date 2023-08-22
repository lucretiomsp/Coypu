"
Special OSC Vertical Fader to use with SuperDirt
"
Class {
	#name : #VerticalFaderForSuperDirt,
	#superclass : #VerticalFaderForOSC,
	#instVars : [
		'dirtMessage'
	],
	#category : #'LiveCoding-GUI'
}

{ #category : #accessing }
VerticalFaderForSuperDirt >> dirtMessage [

	^ dirtMessage
]

{ #category : #accessing }
VerticalFaderForSuperDirt >> dirtMessage: anObject [

	dirtMessage := anObject
]

{ #category : #'event handling' }
VerticalFaderForSuperDirt >> mouseMove: anEvent [

	| newLocation mappedY cursorY faderBottom range faderTop |
	range := maxValue - minValue.
   dirtMessage := OrderedCollection new.
   dirtMessage add: 'dirt/play';add: 's' ; add: self destination; add: parameter ; add: 0.5. 
   dirtMessage add: 'orbit'; add:  (Performance uniqueInstance at: destination asSymbol ) orbit .
	faderCanMove
		ifTrue: [ 
			faderBottom := self extent y + self position y.
			faderTop := self position y.
			cursorY := (anEvent position y min: faderBottom) max: faderTop.
			newLocation := Point x: self center x y: cursorY.
			cursor center: newLocation.
			"map cursorY to value from 0 to 1"
			mappedY := (((cursorY min: faderBottom) - faderBottom) abs min:
				            self extent y) / self extent y * range + minValue.
			dirtMessage at: 5 put: mappedY .
			(OSCMessage for:  dirtMessage  ) sendToAddressString: '127.0.0.1' port: 57120. ]
			ifFalse: [ "for debug" nil ]
]
