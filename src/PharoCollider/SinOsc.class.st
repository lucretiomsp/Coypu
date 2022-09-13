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
SinOsc >> freq: aFloatOrAUGen [

	"frequency cann be a float or a UGen"

	freq := aFloatOrAUGen.
	aFloatOrAUGen isNumber ifFalse: [ inputs add: aFloatOrAUGen  ] ifTrue: [ ]  
]

{ #category : #accessing }
SinOsc >> gain [
	^ gain
]

{ #category : #accessing }
SinOsc >> gain: aFloatOrAUGen [

	gain := aFloatOrAUGen
]

{ #category : #'accessing - structure variables' }
SinOsc >> initialize [

	super initialize.
	freq := 440.
	phase := 0.0.
	gain := 0.5.
	constantValues := 0.0.
	numberOfConstants :=  1.
]

{ #category : #accessing }
SinOsc >> phase [
	^ phase
]

{ #category : #accessing }
SinOsc >> phase: aFloatOrAUGen [

	phase := aFloatOrAUGen
]
