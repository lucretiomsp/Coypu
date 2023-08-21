Extension { #name : #BlockClosure }

{ #category : #'*LiveCoding' }
BlockClosure >> loopFor: aNumber [

^ [aNumber timesRepeat:   self ] fork.
]
