"
a basic sample Player
"
Class {
	#name : #BasicSamplePlayer,
	#superclass : #SynthDefs,
	#instVars : [
		'id',
		'bufferNumber'
	],
	#category : #PharoCollider
}

{ #category : #accessing }
BasicSamplePlayer >> bufferNumber [

	^ bufferNumber
]

{ #category : #accessing }
BasicSamplePlayer >> bufferNumber: aBufferNumber [

	bufferNumber := aBufferNumber.

	(OSCMessage for: { 
			 15.
			 id.
			 'buf'.
			 aBufferNumber }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #'accessing - structure variables' }
BasicSamplePlayer >> gate: oneOrZero [

	(OSCMessage for: { 
			 15.
			 id.
			 'gate'.
			 oneOrZero }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #accessing }
BasicSamplePlayer >> id [ 
^ id
]

{ #category : #initialization }
BasicSamplePlayer >> initialize [

	super initialize.
	(OSCMessage for:
		 { '/d_load'. '/Users/domenicocipriani/Library/Application Support/SuperCollider/synthdefs/basicSampler.*' })
		sendToAddressString: '127.0.0.1'
		port: 57110.
	self setId: (Random new nextIntegerBetween: 9 and: 99)
]

{ #category : #playing }
BasicSamplePlayer >> play [

	" third argument is ID"

	(OSCMessage for: { 
			 's_new'.
			 'basicSampler'.
			 id.
			 0.
			 0 }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #initialization }
BasicSamplePlayer >> setId: anInteger [

	id := anInteger
]
