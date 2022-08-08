"
Basic SineWave with frequency control
"
Class {
	#name : #Sine,
	#superclass : #SynthDefs,
	#instVars : [
		'id'
	],
	#category : #PharoCollider
}

{ #category : #'accessing - structure variables' }
Sine >> freq: aFrequency [

(OSCMessage for: { 15 . id. 'freq' .aFrequency}) sendToAddressString: '127.0.0.1'  port: 57110.
]

{ #category : #'accessing - structure variables' }
Sine >> gate: oneOrZero [

	(OSCMessage for: { 
			 15.
			 id.
			 'gate'.
			 oneOrZero }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #accessing }
Sine >> id [

	^ id
]

{ #category : #initialization }
Sine >> initialize [ 
super initialize.
(OSCMessage for: { '/d_load'  . '/Users/domenicocipriani/Library/Application Support/SuperCollider/synthdefs/sine.*' }) sendToAddressString: '127.0.0.1'  port: 57110.
self setId: (Random new nextIntegerBetween: 9 and: 99 )
]

{ #category : #'accessing - structure variables' }
Sine >> note: aNoteNumber [

	(OSCMessage for: { 
			 15.
			 id.
			 'note'.
			 aNoteNumber }) sendToAddressString: '127.0.0.1' port: 57110
]

{ #category : #playing }
Sine >> play [
" third argument is ID"
(OSCMessage for:{'s_new'. 'sine'. id . 0  . 0}) sendToAddressString: '127.0.0.1'  port: 57110.
]

{ #category : #initialization }
Sine >> setId: anInteger [
id := anInteger
]
