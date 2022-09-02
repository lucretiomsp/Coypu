"
1537+02:00 LiveCoding4Pharo10.0.image priorSource: 3085015
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
	constantValues := 0.0.
	self numberOfConstants: 1.
]

{ #category : #accessing }
SinOsc >> phase [
	^ phase
]

{ #category : #accessing }
SinOsc >> phase: anObject [

	phase := anObject
]
