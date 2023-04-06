Extension { #name : #SmallInteger }

{ #category : #'*LiveCoding' }
SmallInteger >> saw [

	"fill an array of self steps with values representing a sawtooth with range 0 - 1"

	^ (0 to: 1 by: 1 / (self -1)) asArray
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
