"
Bass rules for motion: the bass likes repeats, octaves, fifths and fourths, walks by step now and then and seldom jumps anywhere else. Intervals are matched with a small tolerance so microtonal scales behave.
"
Class {
	#name : 'GenBassMotionFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'intervalWeights',
		'otherWeight',
		'tolerance'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'initialization' }
GenBassMotionFactor >> initialize [

	super initialize.
	intervalWeights := {
		                   (0 -> 1.0).
		                   (12 -> 0.9).
		                   (7 -> 0.8).
		                   (5 -> 0.8).
		                   (1 -> 0.45).
		                   (2 -> 0.45).
		                   (3 -> 0.35).
		                   (4 -> 0.35) }.
	otherWeight := 0.15.
	tolerance := 0.3
]

{ #category : 'accessing' }
GenBassMotionFactor >> intervalWeights: aCollectionOfAssociations [
	"Semitones (in either direction) -> weight."

	intervalWeights := aCollectionOfAssociations
]

{ #category : 'scoring' }
GenBassMotionFactor >> weightOf: aPitch in: aContext [

	| previous distance |
	previous := aContext previousPitch ifNil: [ ^ 1 ].
	distance := (aPitch midi - previous midi) abs.
	^ intervalWeights inject: otherWeight into: [ :best :each |
		  best max: each value * (self gaussian: distance - each key width: tolerance) ]
]
