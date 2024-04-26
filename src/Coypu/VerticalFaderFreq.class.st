"
VerticalFader to slow down or speed up the Performance speed
"
Class {
	#name : #VerticalFaderFreq,
	#superclass : #VerticalFader,
	#category : #'Coypu-GUI'
}

{ #category : #initialization }
VerticalFaderFreq >> initialize [ 

	super initialize.
	destination := 'BPM'.
	minValue := 55.
	maxValue := 190.

	"cursor postion should be at the current freq"
]

{ #category : #'event handling' }
VerticalFaderFreq >> mouseMove: anEvent [
	" the VerticalFaderForSuperDirt modify the contents of the Sequencer in Performance named as destination"

	| newLocation mappedY cursorY faderBottom range faderTop |
	range := maxValue - minValue.
   
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
Performance uniqueInstance freq: mappedY bpm.
			 ]
			ifFalse: [ "for debug" nil ]
]
