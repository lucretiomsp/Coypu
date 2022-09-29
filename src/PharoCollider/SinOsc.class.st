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

	"frequency can be a float or a UGen, if it is a UGen, the constant is only phase"

	freq := aFloatOrAUGen.
	aFloatOrAUGen isNumber ifFalse: [ inputs add: aFloatOrAUGen. constants removeKey: 0  ] ifTrue: [ ]  
]

{ #category : #accessing }
SinOsc >> gain [
	^ gain
]

{ #category : #accessing }
SinOsc >> gain: aFloatOrAUGen [

	gain := aFloatOrAUGen.
	aFloatOrAUGen isUGen
		ifTrue: [ inputs add: aFloatOrAUGen ]
		ifFalse: [  ]
]

{ #category : #'accessing - structure variables' }
SinOsc >> initialize [

"initialize ad Super Collider SinOSc at audiorate"
	super initialize.
	calculationRate := 2.
	freq := 440.
	phase := 0.0.
	gain := 0.5.
	uGenName := 'SinOSc'.
	"constants are frequency and phase"
	self constants at: 0 put: 440.0.
	self constants at: 1 put: 0.0.
]

{ #category : #accessing }
SinOsc >> phase [
	^ phase
]

{ #category : #accessing }
SinOsc >> phase: aFloatOrAUGen [

	phase := aFloatOrAUGen.
	aFloatOrAUGen isUGen
		ifTrue: [ inputs add: aFloatOrAUGen ]
		ifFalse: [  ]
]
