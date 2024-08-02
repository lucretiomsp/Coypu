Extension { #name : 'Character' }

{ #category : '*Coypu' }
Character >> * anInteger [ 
	| result |
	result := self asString * anInteger.
	^ result
]
