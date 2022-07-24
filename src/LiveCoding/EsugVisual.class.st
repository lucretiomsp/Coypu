"
RoassalCanvas for Lucretio's a/v performance at ESUG2022 Novi Sad
"
Class {
	#name : #EsugVisual,
	#superclass : #RSCanvas,
	#instVars : [
		'shapez',
		'nodez',
		'shapezSize',
		'shapezColorRed',
		'layoutz'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #'as yet unclassified' }
EsugVisual >> changeLayout: aTypeofLayout [

	" 'grid' 'tree' 'cell' 'horizontalTree' 'cluster'
	             'circle' 'radial' 'sugiyama' "

	| l |
	l := RSLayoutBuilder new.
	l perform: aTypeofLayout asSymbol.
	l on: shapez.
	self signalUpdate .
]

{ #category : #initialization }
EsugVisual >> initialize [

	super initialize.

	self color: #transparent. " transparent"
	self shapezSize ifNil: [ shapezSize := 30 ].
	self shapezColorRed ifNil: [ shapezColorRed := 0 ].
	self nodez ifNil: [ nodez := 1 to: 5 ].
	self layoutz ifNil: [ layoutz := RSCircleLayout new radius: 120 ].



	shapez := RSCircle models: nodez.
	shapez color: (Color r: shapezColorRed g: 0 b: 220).
	shapez size: shapezSize.
	self addAll: shapez.
layoutz on: shapez
]

{ #category : #accessing }
EsugVisual >> layoutz [

	^ layoutz
]

{ #category : #accessing }
EsugVisual >> layoutz: aLayout [

	^ layoutz := aLayout
]

{ #category : #accessing }
EsugVisual >> nodez [

	^ nodez
]

{ #category : #accessing }
EsugVisual >> nodez: anInteger [

	| newShapez |
	nodez := 1 to: anInteger.
	newShapez := RSCircle models: nodez.
	newShapez color: (Color r: shapezColorRed g: 0 b: 220).
	newShapez size: shapezSize.
	shapez add: newShapez.
	layoutz on: shapez.
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> shapez [

	^ shapez
]

{ #category : #accessing }
EsugVisual >> shapez: anRSGroup [

	shapez := anRSGroup 
]

{ #category : #accessing }
EsugVisual >> shapezColorRed [

	^ shapezColorRed
]

{ #category : #accessing }
EsugVisual >> shapezColorRed: anInteger [

	shapezColorRed := anInteger.
	shapez color: (Color r: anInteger g: 0 b: 120).
	self signalUpdate
]

{ #category : #accessing }
EsugVisual >> shapezSize [

	^ shapezSize
]

{ #category : #accessing }
EsugVisual >> shapezSize: anInteger [

	shapezSize := anInteger.
	shapez size: shapezSize.
	 self signalUpdate
]

{ #category : #subscription }
EsugVisual >> subscribeTo: anAnnouncer [

	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		self shapezSize:
			(OSCMsgReceivedAnnouncement values at: #'/kickGate') * 5.
		"self color: (Color r: kickG g: kickG b: kickG)."
		"(OSCMsgReceivedAnnouncement values at: #'/kickGate') * 255"
		self shapezColorRed:
			(OSCMsgReceivedAnnouncement values at: #'/snareGate') * 1
		"self signalUpdate " ]
]
