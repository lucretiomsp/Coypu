Class {
	#name : #VerticalFaderForKyma,
	#superclass : #VerticalFader,
	#category : #'LiveCoding-GUI'
}

{ #category : #'event handling' }
VerticalFaderForKyma >> mouseMove: anEvent [

	| newLocation mappedY cursorY faderBottom range |
	range := maxValue - minValue.
	
	faderCanMove
		ifTrue: [ 
			faderBottom := self extent y + self position y.
			cursorY := anEvent position y.
			newLocation := Point x: self center x y: cursorY.
			cursor center: newLocation.
			"map cursorY to value from 0 to 1"
			mappedY := (((((cursorY min: faderBottom) - faderBottom) abs min:
				            self extent y) / self extent y) * range) + minValue.
			mappedY toKyma: faderAddress ]
		ifFalse: [ "for debug" nil ]
]
