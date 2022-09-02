"
SinOsc from SuperCollider with NamedControls for Freq and Gain.
Initially phase is left as constant 
"
Class {
	#name : #SinOsc,
	#superclass : #UGen,
	#instVars : [
		'freq',
		'phase',
		'gain'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #'accessing - structure variables' }
SinOsc >> freq [
	^ freq.
]

{ #category : #accessing }
SinOsc >> freq: anObject [

	freq := anObject
]

{ #category : #accessing }
SinOsc >> gain [
	^ gain
]

{ #category : #accessing }
SinOsc >> gain: anObject [

	gain := anObject
]

{ #category : #'accessing - structure variables' }
SinOsc >> initialize [

	super initialize.
	freq := 440.
	phase := 0.0.
	gain := 0.5.
	numberOfConstants := 1.
	constantValues := 0.0.
]

{ #category : #accessing }
SinOsc >> numberOfConstants [

	^ numberOfConstants
]

{ #category : #accessing }
SinOsc >> numberOfConstants: anInteger [

	numberOfConstants := anInteger asByteArrayOfSize: 4
]

{ #category : #accessing }
SinOsc >> phase [
	^ phase
]

{ #category : #accessing }
SinOsc >> phase: anObject [

	phase := anObject
]
