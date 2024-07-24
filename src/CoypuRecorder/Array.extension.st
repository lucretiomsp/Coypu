Extension { #name : #Array }

{ #category : #'*CoypuRecorder' }
Array >> delayed: aMethodOfInteger atTime: aDelayInMilliseconds [

	(Delay forMilliseconds: aDelayInMilliseconds) wait.

	Object readFromString: self asString , aMethodOfInteger
]
