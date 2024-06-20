Extension { #name : 'BlockClosure' }

{ #category : '*Coypu' }
BlockClosure >> loopFor: aNumber [

^ [aNumber timesRepeat:   self ] fork.
]
