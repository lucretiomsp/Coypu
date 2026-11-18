"
Loop closure: the last note of a lane is chosen to lead smoothly back to the first one, so the loop closes without a jump.
"
Class {
	#name : 'GenLoopClosureFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'width'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'initialization' }
GenLoopClosureFactor >> initialize [

	super initialize.
	width := 3.0
]

{ #category : 'scoring' }
GenLoopClosureFactor >> weightOf: aPitch in: aContext [

	| first |
	aContext isLastNote ifFalse: [ ^ 1 ].
	first := aContext firstPitch ifNil: [ ^ 1 ].
	(aPitch step - first step) abs = 1 ifTrue: [ ^ 1 ].
	^ self gaussian: aPitch midi - first midi width: width
]

{ #category : 'accessing' }
GenLoopClosureFactor >> width: aNumberOfSemitones [

	width := aNumberOfSemitones
]
