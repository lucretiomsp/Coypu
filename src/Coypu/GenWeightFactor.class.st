"
I am one rule of the melody brain (Strategy). Given a candidate pitch and the note context I answer a weight: 1 is neutral, more is better, 0 forbids.

A voice multiplies all its factors (GenCompositeFactor); the scores are then sharpened and one pitch is drawn (GenWeightedChooser).

My subclasses are the rules: consonance with the chord and beat strength, the other lanes, melodic motion, bass rules, ascending and descending forms, register and loop closure.
"
Class {
	#name : 'GenWeightFactor',
	#superclass : 'Object',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'math' }
GenWeightFactor >> gaussian: aDistance width: aWidth [
	"A bell curve: 1 at distance 0."

	^ (aDistance squared / (2 * aWidth squared)) negated exp
]

{ #category : 'math' }
GenWeightFactor >> geometricMeanOf: aCollection [
	"One bad value pulls the mean down much harder than in an arithmetic mean: a pitch has to fit all of them."

	aCollection isEmpty ifTrue: [ ^ 1 ].
	^ (aCollection inject: 1 into: [ :product :each | product * each ]) raisedTo: 1.0 / aCollection size
]

{ #category : 'scoring' }
GenWeightFactor >> weightOf: aPitch in: aContext [

	^ self subclassResponsibility
]
