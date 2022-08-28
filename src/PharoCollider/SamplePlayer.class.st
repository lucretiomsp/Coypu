"
Essential SamplePlayer
"
Class {
	#name : #SamplePlayer,
	#superclass : #SynthDefs,
	#instVars : [
		'id',
		'bufferNumber'
	],
	#category : #PharoCollider
}

{ #category : #accessing }
SamplePlayer >> bufferNumber [ 
^ bufferNumber 
]

{ #category : #accessing }
SamplePlayer >> bufferNumber: aBufferNumber [

	bufferNumber := aBufferNumber.
	
(OSCMessage for: { 
			 15.
			 id.
			 'buf'.
			 aBufferNumber  }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #initialization }
SamplePlayer >> initialize [

	super initialize.
	(OSCMessage for:
		 { '/d_load'. '/Users/domenicocipriani/Library/Application Support/SuperCollider/synthdefs/sampy.*' })
		sendToAddressString: '127.0.0.1'
		port: 57110.
	self setId: (Random new nextIntegerBetween: 9 and: 99)
]

{ #category : #playing }
SamplePlayer >> play [

	" third argument is ID"

	(OSCMessage for: { 
			 's_new'.
			 'sampy'.
			 id.
			 0.
			 0 }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #'as yet unclassified' }
SamplePlayer >> rate: aRate [

	(OSCMessage for: { 
			 15.
			 id.
			 'rate'.
			 aRate }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #initialization }
SamplePlayer >> setId: anInteger [

	id := anInteger
]

{ #category : #'as yet unclassified' }
SamplePlayer >> trig [
" triiger the sample"
	(OSCMessage for: { 
			 15.
			 id.
			 't_tr'.
			 1 }) sendToAddressString: '127.0.0.1' port: 57110
]
