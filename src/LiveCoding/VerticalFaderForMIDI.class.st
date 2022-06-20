Class {
	#name : #VerticalFaderForMIDI,
	#superclass : #VerticalFader,
	#instVars : [
		'ccNumber',
		'midiSender'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
VerticalFaderForMIDI class >> newWithCC: aCCNumber forSender: aMIDISender [
" the fader label is also the OSC address"
^ (self new) 
		ccNumber: aCCNumber ;
		midiSender: aMIDISender;
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
VerticalFaderForMIDI >> midiSender [
^ midiSender 
]

{ #category : #accessing }
VerticalFaderForMIDI >> midiSender: aMIDISender [
midiSender  := aMIDISender .
]

{ #category : #'event handling' }
VerticalFaderForMIDI >> mouseMove: anEvent [

| newLocation faderValue|



faderCanMove ifTrue:
[newLocation := Point x: (self center x) y: anEvent position y.
"change the argument"


"move the cursor"
cursor center: newLocation .
faderValue := 50.
midiSender sendCC: ccNumber  withValue: faderValue onChannel: 6

] ifFalse: [ nil] .

"for debug"
]
