"
Vertical fader to control values on the client
"
Class {
	#name : #VerticalFader,
	#superclass : #Morph,
	#instVars : [
		'faderAddress',
		'cursor'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
VerticalFader class >> newWithAddress: anAddress [
" the fader label is also the OSC address"
^ (self new) 
		address: anAddress ;
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

{ #category : #initialization }
VerticalFader >> initialize [ 
super initialize. 
self extent: 400@500.
]

{ #category : #'event handling' }
VerticalFader >> mouseDown: anEvent [

| newLocation |
newLocation := Point x: (self center y) y: anEvent position y.

cursor center: newLocation .

Transcript show: newLocation  ; cr.


]

{ #category : #'as yet unclassified' }
VerticalFader >> openInWindow [

	^self openInWindowLabeled: faderAddress 
]
