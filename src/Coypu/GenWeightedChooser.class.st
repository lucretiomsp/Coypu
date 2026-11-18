"
I draw one candidate from weighted scores. The scores are first sharpened (raised to the power sharpness) so strong candidates win more often; sharpness 1 is a plain weighted draw. Zero weights never win; when everything is zero I fall back to a uniform draw.
"
Class {
	#name : 'GenWeightedChooser',
	#superclass : 'Object',
	#instVars : [
		'random',
		'sharpness'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenWeightedChooser class >> random: aRandom [

	^ self random: aRandom sharpness: 1
]

{ #category : 'instance creation' }
GenWeightedChooser class >> random: aRandom sharpness: aNumber [

	^ self new
		  setRandom: aRandom sharpness: aNumber;
		  yourself
]

{ #category : 'choosing' }
GenWeightedChooser >> choose: candidates weights: weights [

	candidates size = weights size ifFalse: [ ^ self error: 'One weight per candidate, please' ].
	candidates isEmpty ifTrue: [ ^ self error: 'Nothing to choose from' ].
	^ candidates at: (self indexFor: weights)
]

{ #category : 'choosing' }
GenWeightedChooser >> indexFor: weights [

	| sharpened total threshold cumulative |
	sharpened := weights collect: [ :each | self sharpen: each ].
	total := sharpened inject: 0 into: [ :sum :each | sum + each ].
	total <= 0 ifTrue: [ ^ random nextInteger: weights size ].
	threshold := random next * total.
	cumulative := 0.
	sharpened withIndexDo: [ :each :index |
		cumulative := cumulative + each.
		(each > 0 and: [ threshold < cumulative ]) ifTrue: [ ^ index ] ].
	^ sharpened findLast: [ :each | each > 0 ]
]

{ #category : 'initialization' }
GenWeightedChooser >> setRandom: aRandom sharpness: aNumber [

	random := aRandom.
	sharpness := aNumber
]

{ #category : 'choosing' }
GenWeightedChooser >> sharpen: aWeight [

	^ (aWeight max: 0) raisedTo: sharpness
]

{ #category : 'accessing' }
GenWeightedChooser >> sharpness [

	^ sharpness
]
