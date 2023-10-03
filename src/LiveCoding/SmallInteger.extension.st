Extension { #name : #SmallInteger }

{ #category : #'*LiveCoding' }
SmallInteger >> asInt8 [

	| bitArray firsComplement binaryString secondComplementAsString secondComplement result |
	bitArray := self asBitsArrayOfSize: 8.
	firsComplement := (bitArray at: 1) * 128 negated.
	binaryString := String new: 7.
	2 to: 8 do: [ :i | 
	binaryString at: i - 1 put: (bitArray at: i) asCharacterDigit ].
	secondComplementAsString := '2r' , binaryString.
	secondComplement := Smalltalk compiler evaluate:
		                    secondComplementAsString.
	result := firsComplement + secondComplement.
	^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> bars [
	"return number of steps in self bars"
	^ self*16
]

{ #category : #'*LiveCoding' }
SmallInteger >> saw [

	"fill an array of self steps with values representing a sawtooth with range 0 - 1"

	^ (0 to: 1 by: 1 / (self -1)) asDirtArray
]

{ #category : #'*LiveCoding' }
SmallInteger >> sawCC: aRange [

	"fill an array of self steps with values representing a sawtooth with aRange 1"

	| min max range arrayOfFloats result |
	min := aRange at: 1.
	max := aRange at: 2.
	range := max - min.
	arrayOfFloats := (min to: max by: range / (self - 1)) asDirtArray.
	result := arrayOfFloats collect: [ :i | i rounded ].
^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> triangle [

	"return an array of self size with a triangle wave with range 0 -1"

	| increment up down result |
	increment := 1 / (self / 2 - 1).
	up := (0 to: 1 by: increment) asDirtArray.
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
	up := (min to: max by: increment) asDirtArray.
	down := up reverse.
	arrayOfFloats  := up , down.
	result := arrayOfFloats collect: [ :i | i rounded ].
	^ result
]
