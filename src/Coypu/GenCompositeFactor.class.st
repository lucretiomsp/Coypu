"
I multiply the weights of my factors (Composite). The whole rule set of a voice is one of me, and I can be nested.
"
Class {
	#name : 'GenCompositeFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'factors'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenCompositeFactor class >> withAll: aCollection [

	^ self new
		  addAll: aCollection;
		  yourself
]

{ #category : 'adding' }
GenCompositeFactor >> add: aFactor [

	^ factors add: aFactor
]

{ #category : 'adding' }
GenCompositeFactor >> addAll: aCollection [

	aCollection do: [ :each | self add: each ]
]

{ #category : 'accessing' }
GenCompositeFactor >> factorOfClass: aClass [
	"To tweak one rule of a voice, e.g. (GenVoice lead scorer factorOfClass: GenMelodicMotionFactor) repeatWeight: 0.1."

	^ factors detect: [ :each | each class = aClass ] ifNone: [ nil ]
]

{ #category : 'accessing' }
GenCompositeFactor >> factors [

	^ factors
]

{ #category : 'initialization' }
GenCompositeFactor >> initialize [

	super initialize.
	factors := OrderedCollection new
]

{ #category : 'scoring' }
GenCompositeFactor >> weightOf: aPitch in: aContext [

	^ factors inject: 1 into: [ :weight :each | weight * (each weightOf: aPitch in: aContext) ]
]
