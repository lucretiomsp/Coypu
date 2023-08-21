Extension { #name : #OrderedCollection }

{ #category : #'*LiveCoding' }
OrderedCollection >> asDirtArray [ 


"convenience method to send OSC messages to SuperDirt"
^ self asArray
]
