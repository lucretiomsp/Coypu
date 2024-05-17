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
		'maxValue',
		'cursorColor',
		'destination',
		'parameter'
	],
	#category : #'Coypu-GUI'
}

{ #category : #'instance creation' }
VerticalFader class >> closeAll [

	| fadersInWorld |
	
	fadersInWorld := self  currentWorld submorphs select: [ :i |
		                 i class = FaderWindow  ].
	fadersInWorld do: [ :i | i delete ]
]

{ #category : #'instance creation' }
VerticalFader class >> newWithAddress: anAddress [

	" the fader label is also the OSC address"

	^ self new
		  address: anAddress;
		  extent: 200 @ 600;
		  color: Color random;
		  cursorColor: Color black;
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
VerticalFader >> address [ 
^ faderAddress 
]

{ #category : #accessing }
VerticalFader >> address: anAddress [
"set address (and labels)"
faderAddress := anAddress 
]

{ #category : #accessing }
VerticalFader >> cursorColor [
^ cursorColor
]

{ #category : #accessing }
VerticalFader >> cursorColor: aColor [
cursor color: aColor
]

{ #category : #'as yet unclassified' }
VerticalFader >> drawCursor [
"draw the fader cursor"
| cursorWidth cursorHeight |

cursorHeight := self extent y /5.
cursorWidth := self width.

cursor extent: 400@cursorHeight .

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

	"self extent: 400@500"
	cursor := Morph new extent: 400 @ 300.
	cursor color: Color red.
	self drawCursor
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
"map cursorY to value from 0 to 1"
mappedY := ((((cursorY min: faderBottom )- faderBottom ) abs) min: self extent y) / self extent y.
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

	| faderWidth faderHeight positionLeft positionTop fadersInWorld bgColor |
	fadersInWorld := FaderWindow countFadersInWorld.
	faderWidth := 350.
	faderHeight := self currentWorld height / 2.1.
	positionLeft := self currentWorld width
	                - (faderWidth * (fadersInWorld + 1 modulo: 3)).
	positionTop := (self currentWorld submorphs at: 1) extent y
	               + (faderHeight * (fadersInWorld // 3)).
	bgColor := Color random lighter lighter.
	self color: bgColor.
	self cursorColor: Color black.

	^ ((self openInWindowLabeled: self address) position:
		   positionLeft @ positionTop) extent: faderWidth @ faderHeight
]

{ #category : #'as yet unclassified' }
VerticalFader >> wrappedInWindow [
	"Changed to include the inset margin in the bound calculation."

	| window extent |
	window := FaderWindow new.
	window
		addMorph: self frame: (0@0 extent: 1@1);
		updatePaneColors.
	" calculate extent after adding in case any size related attributes were changed.  Use
	fullBounds in order to trigger re-layout of layout morphs"
	extent := self fullBounds extent +
			(window borderWidth@window labelHeight) + window borderWidth +
			(window class borderWidth * 2 @ (window class borderWidth + 1)). "include inset margin"
	window extent: extent.
	^ window
]
