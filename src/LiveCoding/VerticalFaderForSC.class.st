Class {
	#name : #VerticalFaderForSC,
	#superclass : #VerticalFader,
	#instVars : [
		'destination',
		'parameter'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
VerticalFaderForSC class >> new: anArrayWithDestinationAndParameter [

^ (self new) 
		destination: (anArrayWithDestinationAndParameter at: 1) ;
		parameter: (anArrayWithDestinationAndParameter at: 2) ;
		minValue: 0;
		maxValue: 1;
		yourself
]

{ #category : #accessing }
VerticalFaderForSC >> destination: aDestination [
destination  := aDestination
]

{ #category : #'event handling' }
VerticalFaderForSC >> mouseMove: anEvent [

| newLocation receiver keyword argument|

receiver := destination.
keyword := parameter asSymbol.


faderCanMove ifTrue:
[newLocation := Point x: (self center x) y: anEvent position y.
"change the argument"
argument := anEvent position y.

"move the cursor"
cursor center: newLocation .
receiver perform: keyword withArguments: (Array with: argument )
] ifFalse: [ nil] .

"for debug"
]

{ #category : #accessing }
VerticalFaderForSC >> parameter: aParameter [
parameter := parameter
]
