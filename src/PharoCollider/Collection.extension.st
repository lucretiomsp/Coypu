Extension { #name : #Collection }

{ #category : #'*PharoCollider' }
Collection >> asArryaWithBytesOfSize: anInteger [

	| x c |
	x := self collect: [ :i | i asByteArrayOfSize: 4 ].
	c := OrderedCollection new.

	(1 to: x size) do: [ :j | (x at: j) do: [ :i | c add: i ] ].
	^ c
]
