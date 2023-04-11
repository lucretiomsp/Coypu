Class {
	#name : #VerticalFaderForOSC,
	#superclass : #VerticalFader,
	#instVars : [
		'destination',
		'parameter'
	],
	#category : #'LiveCoding-GUI'
}

{ #category : #'instance creation' }
VerticalFaderForOSC class >> new: anArrayWithDestinationAndParameter [

^ (self new) 
		destination: (anArrayWithDestinationAndParameter at: 1) ;
		parameter: (anArrayWithDestinationAndParameter at: 2) ;
		minValue: 0;
		maxValue: 1;
		yourself
]

{ #category : #accessing }
VerticalFaderForOSC >> destination: aDestination [
destination  := aDestination
]

{ #category : #'event handling' }
VerticalFaderForOSC >> mouseMove: anEvent [

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
			mappedY toLocal: faderAddress ]
		ifFalse: [ "for debug" nil ]
]

{ #category : #accessing }
VerticalFaderForOSC >> parameter: aParameter [
parameter := parameter
]
