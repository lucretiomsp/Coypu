"
Vertical Fader to send OSC messages to the audio server.
"
Class {
	#name : #VerticalFaderForOSC,
	#superclass : #VerticalFader,
	#category : #'Coypu-GUI'
}

{ #category : #'instance creation' }
VerticalFaderForOSC class >> new: aStringWithADestinationAndAParameter [

" if the paameter is a number, the fader sends out to MIDI via SuperDirt the cursor value for the control change number assigned"
| parsedString dest param |

parsedString := aStringWithADestinationAndAParameter findBetweenSubstrings: ' '.
dest := (parsedString  at: 1).
param := (parsedString  at: 2). 

param asInteger ifNotNil: [ ((Performance uniqueInstance at: dest) dirtMessage) at: 'ccn' put: param asInteger. param := 'ccv'] ifNil: [ ] .

^ (self new) 
		destination: dest;
		parameter: param;
		
		minValue: 0;
		maxValue: 1 + ( 126 * ((parsedString at: 2) asInteger isNotNil asInteger));
		yourself
]

{ #category : #'instance creation' }
VerticalFaderForOSC class >> new: aStringWithADestinationAndAParameter range: anArrayWirhMinAndMax [
| parsedString  |

parsedString := aStringWithADestinationAndAParameter findBetweenSubstrings: ' '.
^ (self new) 
		destination: (parsedString  at: 1) ;
		parameter: (parsedString  at: 2) ;
		
		minValue: anArrayWirhMinAndMax first;
		maxValue: anArrayWirhMinAndMax second;
		yourself
]

{ #category : #accessing }
VerticalFaderForOSC >> destination [ 
^ destination 
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
VerticalFaderForOSC >> parameter [ 
^ parameter 
]

{ #category : #accessing }
VerticalFaderForOSC >> parameter: aParameter [
parameter := aParameter
]
