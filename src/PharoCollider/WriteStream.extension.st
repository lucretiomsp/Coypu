Extension { #name : #WriteStream }

{ #category : #'*PharoCollider' }
WriteStream >> nextPutAllSignedInt8: aCollection [

	"Append the elements of aCollection to the sequence of objects accessible 
	by the receiver. Answer aCollection."

	aCollection do: [ :v | self nextPut: v asSignedInt8 ].
	^ aCollection
]
