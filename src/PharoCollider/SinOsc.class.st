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
SinOsc >> gain [
	^ gain
]

{ #category : #'accessing - structure variables' }
SinOsc >> initialize [ 
super initialize.
freq := 440.
phase := 0.0.
gain := 0.5. 
]

{ #category : #accessing }
SinOsc >> phase [
	^ phase
]
