"
I am the Rhythm source slider: with probability worldAmount a lane gets a world rhythm, otherwise a random one (a Strategy made of two Strategies). worldAmount 0 means always random, 1 always world rhythms.
"
Class {
	#name : 'GenBlendedRhythmSource',
	#superclass : 'GenRhythmSource',
	#instVars : [
		'worldSource',
		'randomSource',
		'worldAmount'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'initialization' }
GenBlendedRhythmSource >> initialize [

	super initialize.
	worldSource := GenWorldRhythmSource new.
	randomSource := GenRandomRhythmSource new.
	worldAmount := 0.5
]

{ #category : 'accessing' }
GenBlendedRhythmSource >> randomSource [

	^ randomSource
]

{ #category : 'accessing' }
GenBlendedRhythmSource >> randomSource: aRhythmSource [

	randomSource := aRhythmSource
]

{ #category : 'generating' }
GenBlendedRhythmSource >> rhythmOfSize: aSize random: aRandom [

	^ (aRandom next < worldAmount
		   ifTrue: [ worldSource ]
		   ifFalse: [ randomSource ]) rhythmOfSize: aSize random: aRandom
]

{ #category : 'accessing' }
GenBlendedRhythmSource >> worldAmount [

	^ worldAmount
]

{ #category : 'accessing' }
GenBlendedRhythmSource >> worldAmount: aProbability [

	worldAmount := aProbability
]

{ #category : 'accessing' }
GenBlendedRhythmSource >> worldSource: aRhythmSource [

	worldSource := aRhythmSource
]
