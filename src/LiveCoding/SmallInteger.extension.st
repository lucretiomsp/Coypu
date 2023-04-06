Extension { #name : #SmallInteger }

{ #category : #'*LiveCoding' }
SmallInteger >> saw [
"fill an array of self steps with values representing a sawtooth with range 0 - 1"

^ (0 to: 1 by: 1/self) asArray 
]
