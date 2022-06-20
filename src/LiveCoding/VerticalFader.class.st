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

{ #category : #'instance creation' }
VerticalFader class >> newWithAddress: anAddress range: anArrayWithMinAndMax [
" the fader label is also the OSC address"
^ (self new) 
		address: anAddress ;
		minValue: (anArrayWithMinAndMax  at: 1);
		maxValue: (anArrayWithMinAndMax  at: 2);
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
faderCanMove := false.

self extent: 400@500.
self drawCursor .
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

| newLocation mappedY cursorY faderBottom  |

faderCanMove ifTrue:
[
faderBottom := self extent y + self position y.
cursorY := anEvent position y.
newLocation := Point x: (self center x) y: cursorY.
cursor center: newLocation .
mappedY := ((cursorY min: faderBottom )- faderBottom ) abs.
Transcript show: newLocation ; cr.
Transcript show: 'mapped value' , ' ' , mappedY asString ; cr.
] ifFalse: [ nil] .

"for debug"
]

{ #category : #'event handling' }
VerticalFader >> mouseUp: anEvent [
faderCanMove := false
]

{ #category : #'as yet unclassified' }
VerticalFader >> openInWindow [
   
	^ (self openInWindowLabeled: faderAddress ) position: (800@200)
]
