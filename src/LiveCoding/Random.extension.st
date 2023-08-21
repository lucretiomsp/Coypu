Extension { #name : #Random }

{ #category : #'*LiveCoding' }
Random >> nextIntFromZero: anInteger [
"returns a new random number in the range [0 aNumber]"
^ (self nextInt: (anInteger + 1)) -1.
]

{ #category : #'*LiveCoding' }
Random >> nextTrig [
"return 0 or 1 randomly"
^ self next rounded.
]

{ #category : #'*LiveCoding' }
Random >> sign [ 
"return 1 or -1 "
	| condition  |
	condition := self nextInt: 2.
	(condition = 1) ifTrue: [  ^ 1 ] ifFalse: [ ^ -1] 
	
]
