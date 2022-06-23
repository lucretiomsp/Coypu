Class {
	#name : #VerticalFaderForMIDI,
	#superclass : #VerticalFader,
	#instVars : [
		'ccNumber',
		'midiSender',
		'midiChannel',
		'faderLabel',
		'visualization'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
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

{ #category : #'instance creation' }
VerticalFaderForMIDI class >> newWithCC: aCCNumber forSender: aMIDISender channel: aMIDIChannel [
" the fader label is also the OSC address"
^ (self new) 
		ccNumber: aCCNumber ;
		midiSender: aMIDISender;
		midiChannel:  aMIDIChannel ;
		minValue: 0;
		maxValue: 127;
		yourself
]

{ #category : #accessing }
VerticalFaderForMIDI >> ccNumber [
^ ccNumber 
]

{ #category : #accessing }
VerticalFaderForMIDI >> ccNumber: aCCNumber [

ccNumber := aCCNumber .
]

{ #category : #accessing }
VerticalFaderForMIDI >> faderLabel [
^ faderLabel 
]

{ #category : #accessing }
VerticalFaderForMIDI >> faderLabel: aString [
faderLabel := aString
]

{ #category : #accessing }
VerticalFaderForMIDI >> midiChannel [ 
^ midiChannel 
]

{ #category : #accessing }
VerticalFaderForMIDI >> midiChannel: aChannelNumber [ 
midiChannel := aChannelNumber 
]

{ #category : #accessing }
VerticalFaderForMIDI >> midiSender [
^ midiSender 
]

{ #category : #accessing }
VerticalFaderForMIDI >> midiSender: aMIDISender [
midiSender  := aMIDISender .
]

{ #category : #'event handling' }
VerticalFaderForMIDI >> mouseMove: anEvent [

| newLocation mappedY cursorY faderBottom  |

faderCanMove ifTrue:
[
faderBottom := self extent y + self position y.
cursorY := anEvent position y.
newLocation := Point x: (self center x) y: cursorY.
cursor center: newLocation .
"map cursorY to value from 0 to 1"
mappedY := (((((cursorY min: faderBottom )- faderBottom ) abs) min: self extent y) / self extent y) * 127.
Transcript show: newLocation ; cr.
visualization clock radius: (mappedY asInteger / 2); update.
midiSender sendCC: ccNumber withValue: (mappedY asInteger ) onChannel: midiChannel 
] ifFalse: [ nil] .

"for debug"
]

{ #category : #'as yet unclassified' }
VerticalFaderForMIDI >> openInWindow [
   
	^ (self openInWindowLabeled: faderLabel ) position: (800@200)
]

{ #category : #accessing }
VerticalFaderForMIDI >> visualization: aVisualization [
visualization := aVisualization .
]
