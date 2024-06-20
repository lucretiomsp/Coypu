"
Creates a Vertical Fader to send MIDI COntrol CHange messages to the selected MIDI Channel.
"
Class {
	#name : 'VerticalFaderForMIDI',
	#superclass : 'VerticalFader',
	#instVars : [
		'ccNumber',
		'midiSender',
		'midiChannel',
		'faderLabel',
		'visualization'
	],
	#category : 'Coypu-GUI',
	#package : 'Coypu',
	#tag : 'GUI'
}

{ #category : 'instance creation' }
VerticalFaderForMIDI class >> new: anArray [

	"shortcut to create MIDI faderLabel #(aCCNumber aMIDISender a channel)"

	^ self new
		  color: Color random;
		  ccNumber: (anArray at: 1);
		  midiSender: (anArray at: 2);
		  midiChannel: (anArray at: 3);
		  minValue: 0;
		  maxValue: 127;
		  faderLabel: 'Control Change';
		  openInWindow;
		  yourself
]

{ #category : 'instance creation' }
VerticalFaderForMIDI class >> newWithCC: aCCNumber forSender: aMIDISender [
" the fader label is also the OSC address"
^ (self new) 
		ccNumber: aCCNumber ;
		midiSender: aMIDISender;
		cursorColor: Color red;
		minValue: 0;
		maxValue: 127;
		yourself
]

{ #category : 'instance creation' }
VerticalFaderForMIDI class >> newWithCC: aCCNumber forSender: aMIDISender channel: aMIDIChannel [


	^ self new
		  ccNumber: aCCNumber;
		  midiSender: aMIDISender;
		  midiChannel: aMIDIChannel;
		  minValue: 0;
		  maxValue: 127;
		  yourself
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> ccNumber [

	^ ccNumber 
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> ccNumber: aCCNumber [

	ccNumber := aCCNumber
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> faderLabel [

	^ faderLabel 
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> faderLabel: aString [

	faderLabel := aString
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> midiChannel [ 

	^ midiChannel 
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> midiChannel: aChannelNumber [ 
	midiChannel := aChannelNumber 
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> midiSender [

	^ midiSender 
]

{ #category : 'accessing' }
VerticalFaderForMIDI >> midiSender: aMIDISender [

	midiSender  := aMIDISender
]

{ #category : 'event handling' }
VerticalFaderForMIDI >> mouseMove: anEvent [

	| newLocation mappedY cursorY faderBottom faderTop |
	faderCanMove
		ifTrue: [ 
			faderBottom := self extent y + self position y.
			faderTop := self position y.
			cursorY := (anEvent position y min: faderBottom) max: faderTop.
			newLocation := Point x: self center x y: cursorY.
			cursor center: newLocation.
			"map cursorY to value from 0 to 1"
			mappedY := (((cursorY min: faderBottom) - faderBottom) abs min:
				            self extent y) / self extent y * 127.


			midiSender
				sendCC: ccNumber
				withValue: mappedY asInteger
				onChannel: midiChannel ]

]

{ #category : 'accessing' }
VerticalFaderForMIDI >> visualization: aVisualization [
visualization := aVisualization .
]
