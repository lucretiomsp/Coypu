"
Bass rule: at the start of each bar the bass lands on the chord root, 85% of the time. The coin is flipped once per note (GenNoteContext>>flip:probability:); the octave is left to the other rules.
"
Class {
	#name : 'GenRootLandingFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'probability',
		'missWeight'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'initialization' }
GenRootLandingFactor >> initialize [

	super initialize.
	probability := 0.85.
	missWeight := 0.02
]

{ #category : 'accessing' }
GenRootLandingFactor >> missWeight: aNumber [
	"Weight of the other pitches when the bass decided to land on the root."

	missWeight := aNumber
]

{ #category : 'accessing' }
GenRootLandingFactor >> probability: aProbability [

	probability := aProbability
]

{ #category : 'scoring' }
GenRootLandingFactor >> weightOf: aPitch in: aContext [

	(aContext isBarStart and: [ aContext barChord notNil ]) ifFalse: [ ^ 1 ].
	(aContext flip: #rootLanding probability: probability) ifFalse: [ ^ 1 ].
	^ (aContext barChord rootMatches: aPitch)
		  ifTrue: [ 1 ]
		  ifFalse: [ missWeight ]
]
