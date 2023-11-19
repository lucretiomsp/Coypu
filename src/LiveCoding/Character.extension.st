Extension { #name : #Character }

{ #category : #'*LiveCoding' }
Character >> * anInteger [ 
	| result |
	result := self asString * anInteger.
	^ result
]
