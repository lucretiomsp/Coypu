Extension { #name : #IntervalTest }

{ #category : #'*Coypu' }
IntervalTest >> testMapTo [

	self assert: ((0 to: 10) map: 1 to: (10 to: 20)) equals: 11.
	self assert: ((0 to: 10) map: 5 to: (0 to: 100)) equals: 50.

	self assert: ((0 to: 10) map: 20 to: (0 to: 100)) equals: 200.
	self assert: ((0 to: 10) map: -1 to: (0 to: 100)) equals: -10
]
