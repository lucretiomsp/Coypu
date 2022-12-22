Extension { #name : #PositionableStream }

{ #category : #'*PharoCollider' }
PositionableStream >> nextInt8Put: int8 [

	"Write a signed integer to the next byte"

	self nextPut: int8 asSignedInt8.
	^ int8
]
