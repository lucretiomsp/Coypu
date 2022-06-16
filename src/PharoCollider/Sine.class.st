"
Basic SineWave with frequency control
"
Class {
	#name : #Sine,
	#superclass : #SynthDefs,
	#category : #PharoCollider
}

{ #category : #'accessing - structure variables' }
Sine >> freq: aFrequency [

(OSCMessage for: { 15 . 99. 'freq' .aFrequency}) sendToAddressString: '127.0.0.1'  port: 57110.
]

{ #category : #initialization }
Sine >> initialize [ 
super initialize.
(OSCMessage for: { '/d_load'  . '/Users/domenicocipriani/Library/Application Support/SuperCollider/synthdefs/sine.*' }) sendToAddressString: '127.0.0.1'  port: 57110.
]

{ #category : #playing }
Sine >> play [

(OSCMessage for:{'s_new'. 'sine'. 99 . 0  . 0}) sendToAddressString: '127.0.0.1'  port: 57110.
]
