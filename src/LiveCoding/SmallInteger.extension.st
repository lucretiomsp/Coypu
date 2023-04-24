Extension { #name : #SmallInteger }

{ #category : #'*LiveCoding' }
SmallInteger >> saw [

	"fill an array of self steps with values representing a sawtooth with range 0 - 1"

	^ (0 to: 1 by: 1 / (self -1)) asArray
]

{ #category : #'*LiveCoding' }
SmallInteger >> sawCC: aRange [


	"fill an array of self steps with values representing a sawtooth with aRange 1"

   | min max range |
min := aRange at: 1.
max := aRange at: 2.
range := max - min.
	^ (min to: max by: range / (self - 1)) asArray
]

{ #category : #'*LiveCoding' }
SmallInteger >> triangle [

	"return an array of self size with a triangle wave with range 0 -1"

	| increment up down result |
	increment := 1 / (self / 2 - 1).
	up := (0 to: 1 by: increment) asArray.
	down := up reverse.
	result := up , down.
	^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> triangleCC: aRange [

	"return an array of self size with a triangle wave with aRange suited for MIDI ccs"

	| increment range min max up down arrayOfFloats result |
	min := aRange at: 1.
	max := aRange at: 2.
	range := (max - min).
	increment := range / (self / 2 - 1).
	up := (min to: max by: increment) asArray.
	down := up reverse.
	arrayOfFloats  := up , down.
	result := arrayOfFloats collect: [ :i | i rounded ].
	^ result
]
