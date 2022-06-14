"
Vertical fader to control values on the client
"
Class {
	#name : #VerticalFader,
	#superclass : #Morph,
	#instVars : [
		'faderAddress',
		'faderCanMove',
		'cursor',
		'minValue',
		'maxValue'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
VerticalFader class >> newWithAddress: anAddress [
" the fader label is also the OSC address"
^ (self new) 
		address: anAddress ;
		minValue: 0;
		maxValue: 1;
		yourself
]

{ #category : #accessing }
VerticalFader >> address: anAddress [
"set address (and labels)"
faderAddress := anAddress 
]

{ #category : #'as yet unclassified' }
VerticalFader >> drawCursor [
"draw the fader cursor"

cursor := EllipseMorph new.
cursor color: Color red.
cursor extent: 400@100.

self addMorph: cursor.
cursor center: self center.
]

{ #category : #'event handling' }
VerticalFader >> handlesMouseDown: anEvent [
^ true
]

{ #category : #'event handling' }
VerticalFader >> handlesMouseMove: anEvent [
^ true
]

{ #category : #'event handling' }
VerticalFader >> handlesMouseUp: anEvent [
^ true
]

{ #category : #initialization }
VerticalFader >> initialize [ 
super initialize. 
self extent: 400@500.
]

{ #category : #accessing }
VerticalFader >> maxValue: aNumber [
maxValue := aNumber asFloat .
]

{ #category : #accessing }
VerticalFader >> minValue: aNumber [
minValue := aNumber asFloat .
]

{ #category : #'event handling' }
VerticalFader >> mouseDown: anEvent [


faderCanMove := true.




]

{ #category : #'as yet unclassified' }
VerticalFader >> mouseMove: anEvent [

| newLocation |

faderCanMove ifTrue:
[newLocation := Point x: (self center x) y: anEvent position y.
cursor center: newLocation .]
ifFalse: [ nil] .

]

{ #category : #'event handling' }
VerticalFader >> mouseUp: anEvent [
faderCanMove := false
]

{ #category : #'as yet unclassified' }
VerticalFader >> openInWindow [

	^self openInWindowLabeled: faderAddress 
]
