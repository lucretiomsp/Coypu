"
Vertical Fader to control FX on Elektron Syntakt. 
"
Class {
	#name : #VerticalFaderForSuperDirtGlobal,
	#superclass : #VerticalFaderForSuperDirt,
	#category : #'Coypu-GUI'
}

{ #category : #'instance creation' }
VerticalFaderForSuperDirtGlobal class >> new: aStringWithADestinationAndAParameter [

" if the paameter is a number, the fader sends out to MIDI via SuperDirt the cursor value for the control change number assigned"
| parsedString dest param |

parsedString := aStringWithADestinationAndAParameter findBetweenSubstrings: ' '.
dest := (parsedString  at: 1).
param := (parsedString  at: 2) asInteger . 


^ (self new) 
		destination: dest;
		parameter: param;
		
		minValue: 0;
		maxValue: 127;
		yourself
]

{ #category : #'event handling' }
VerticalFaderForSuperDirtGlobal >> mouseMove: anEvent [
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
				
			(OSCBundle for: { OSCMessage for: { '/dirt/play'. 'midichan' . 12.'s' . self destination . 'n' . 0 . 'ccn'. self parameter .'ccv'. mappedY  } }) sendToAddressString: '127.0.0.1' port: 57120. 
			]ifFalse: [ "for debug" nil ]
]
