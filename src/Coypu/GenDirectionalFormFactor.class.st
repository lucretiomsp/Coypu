"
Ascending and descending forms: in scales whose descending form differs (melodic minor, sikah, nahawand...), a pitch that belongs to one form only is used only when the melody moves in that direction. The first note uses the ascending form.
"
Class {
	#name : 'GenDirectionalFormFactor',
	#superclass : 'GenWeightFactor',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'private' }
GenDirectionalFormFactor >> weightFor: aBoolean [

	^ aBoolean
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : 'scoring' }
GenDirectionalFormFactor >> weightOf: aPitch in: aContext [

	| previous |
	previous := aContext previousPitch.
	(previous isNil or: [ aPitch midi > previous midi ]) ifTrue: [
		^ self weightFor: aPitch isAscendingForm ].
	aPitch midi < previous midi ifTrue: [ ^ self weightFor: aPitch isDescendingForm ].
	^ 1
]
