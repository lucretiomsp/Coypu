"
RoassalCanvas for Lucretio's a/v performance at ESUG2022 Novi Sad
"
Class {
	#name : #EsugVisual,
	#superclass : #RSCanvas,
	#instVars : [
		'shapez',
		'nodez',
		'shapezSize'
	],
	#category : #'LiveCoding-Announcements'
}

{ #category : #initialization }
EsugVisual >> initialize [

	super initialize.

	self color: #black. " transparent"
	self shapezSize ifNil: [ shapezSize := 30 ].
	nodez := 1 to: 5.

	shapez := RSCircle models: nodez.
	shapez size: shapezSize.
	self addAll: shapez.
	RSCircleLayout on: shapez
]

{ #category : #accessing }
EsugVisual >> nodez [

	^ nodez
]

{ #category : #accessing }
EsugVisual >> nodez: anInterval [

	nodez := anInterval
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
EsugVisual >> shapezSize [

	^ shapezSize
]

{ #category : #accessing }
EsugVisual >> shapezSize: anInteger [

	shapezSize := anInteger.
	shapez size: shapezSize.
	 self signalUpdate
]
