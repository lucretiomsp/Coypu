"
Against the other lanes. Lanes are generated bottom up: the bass first, the mid scored against the bass, the lead against both.

A pitch is scored by its consonance with what each lower lane plays at that step (everything it plays there, when lanes of different lengths drift apart). Roles listed in avoidedDoublings are not doubled: the lead avoids doubling the mid.
"
Class {
	#name : 'GenVoiceInteractionFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'avoidedDoublings',
		'doublingPenalty'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenVoiceInteractionFactor >> avoidDoublingWith: aCollectionOfRoles [

	avoidedDoublings := aCollectionOfRoles asArray
]

{ #category : 'accessing' }
GenVoiceInteractionFactor >> avoidedDoublings [

	^ avoidedDoublings
]

{ #category : 'accessing' }
GenVoiceInteractionFactor >> doublingPenalty: aNumber [

	doublingPenalty := aNumber
]

{ #category : 'initialization' }
GenVoiceInteractionFactor >> initialize [

	super initialize.
	avoidedDoublings := #(  ).
	doublingPenalty := 0.15
]

{ #category : 'scoring' }
GenVoiceInteractionFactor >> weightOf: aPitch against: somePitches role: aRole using: aConsonance [

	| fit |
	somePitches isEmpty ifTrue: [ ^ 1 ].
	fit := self geometricMeanOf: (somePitches collect: [ :each |
			        aConsonance ofInterval: aPitch midi - each midi ]).
	((avoidedDoublings includes: aRole) and: [
		 somePitches anySatisfy: [ :each | each isSamePitchClassAs: aPitch ] ]) ifTrue: [
		^ fit * doublingPenalty ].
	^ fit
]

{ #category : 'scoring' }
GenVoiceInteractionFactor >> weightOf: aPitch in: aContext [

	^ aContext lowerVoiceRoles inject: 1 into: [ :weight :role |
		  weight * (self
			   weightOf: aPitch
			   against: (aContext pitchesOfLowerVoice: role)
			   role: role
			   using: aContext consonance) ]
]
