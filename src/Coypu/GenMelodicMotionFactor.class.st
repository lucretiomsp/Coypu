"
Melodic motion: steps are preferred, leaps fade out with their size, repeated notes are penalized, and after a leap the line prefers to step back the other way (classic leap recovery).

Steps are counted in scale steps, so a minor third in a pentatonic scale is still a step.
"
Class {
	#name : 'GenMelodicMotionFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'repeatWeight',
		'leapWidth',
		'leapThreshold',
		'recoveryBonus',
		'continuationPenalty'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenMelodicMotionFactor >> continuationPenalty: aNumber [
	"Weight of moving on in the direction of a leap that just happened."

	continuationPenalty := aNumber
]

{ #category : 'initialization' }
GenMelodicMotionFactor >> initialize [

	super initialize.
	repeatWeight := 0.35.
	leapWidth := 4.0.
	leapThreshold := 5.
	recoveryBonus := 2.0.
	continuationPenalty := 0.4
]

{ #category : 'accessing' }
GenMelodicMotionFactor >> leapThreshold: aNumberOfSemitones [
	"From how many semitones a move counts as a leap."

	leapThreshold := aNumberOfSemitones
]

{ #category : 'accessing' }
GenMelodicMotionFactor >> leapWidth: aNumberOfSemitones [
	"How fast leaps fade out."

	leapWidth := aNumberOfSemitones
]

{ #category : 'scoring' }
GenMelodicMotionFactor >> motionFrom: aPitch to: anotherPitch [

	| steps |
	steps := (anotherPitch step - aPitch step) abs.
	(steps = 0 and: [ anotherPitch midi = aPitch midi ]) ifTrue: [ ^ repeatWeight ].
	steps = 1 ifTrue: [ ^ 1 ].
	^ self gaussian: anotherPitch midi - aPitch midi width: leapWidth
]

{ #category : 'accessing' }
GenMelodicMotionFactor >> recoveryBonus: aNumber [

	recoveryBonus := aNumber
]

{ #category : 'scoring' }
GenMelodicMotionFactor >> recoveryOf: aPitch in: aContext [
	"After a leap, a step back the other way is rewarded and going on the same way is penalized."

	| leap previous motion |
	leap := aContext previousInterval.
	leap abs < leapThreshold ifTrue: [ ^ 1 ].
	previous := aContext previousPitch.
	motion := aPitch midi - previous midi.
	(motion sign = leap sign negated and: [ (aPitch step - previous step) abs = 1 ]) ifTrue: [
		^ recoveryBonus ].
	^ motion sign = leap sign
		  ifTrue: [ continuationPenalty ]
		  ifFalse: [ 1 ]
]

{ #category : 'accessing' }
GenMelodicMotionFactor >> repeatWeight: aNumber [

	repeatWeight := aNumber
]

{ #category : 'scoring' }
GenMelodicMotionFactor >> weightOf: aPitch in: aContext [

	| previous |
	previous := aContext previousPitch ifNil: [ ^ 1 ].
	^ (self motionFrom: previous to: aPitch) * (self recoveryOf: aPitch in: aContext)
]
