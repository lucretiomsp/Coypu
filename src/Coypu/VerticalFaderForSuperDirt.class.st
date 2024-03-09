"
Special OSC Vertical Fader to use with SuperDirt
"
Class {
	#name : #VerticalFaderForSuperDirt,
	#superclass : #VerticalFaderForOSC,
	#category : #'Coypu-GUI'
}

{ #category : #'event handling' }
VerticalFaderForSuperDirt >> mouseMove: anEvent [
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
				
			(Performance uniqueInstance at: destination ifAbsent: [ ]  ) ifNotNil: [ (Performance uniqueInstance at: destination )  dirtMessage  at: parameter put: mappedY.
			 ] ifNil: [ ] ]
			ifFalse: [ "for debug" nil ]
]
