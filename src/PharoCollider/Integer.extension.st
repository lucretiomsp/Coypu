Extension { #name : #Integer }

{ #category : #'*PharoCollider' }
Integer >> asBitsArray [
	| binaryString bitArray|
	
	binaryString := self radix: 2.
	bitArray := Array new: binaryString size.
	1 to: bitArray size do: [ :i | bitArray at: i put: ((binaryString at: i) digitValue ) ].
	
^ bitArray
]

{ #category : #'*PharoCollider' }
Integer >> asBitsArrayOfSize: anInteger [ 
	
	| bitsArraySized bitsArray|

bitsArray  := self asBitsArray .	
bitsArraySized := OrderedCollection new.
1 to: (anInteger - bitsArray size) do: [ :i | bitsArraySized add: 0 ].
bitsArraySized addAll: bitsArray .


^ bitsArraySized asArray
]

{ #category : #'*PharoCollider' }
Integer >> asSignedInt8 [

	| mask result |
	mask := (2 raisedTo: 8) - 1.
	result :=mask bitAnd: (self abs bitXor: mask) + 1.
	^ result
]
