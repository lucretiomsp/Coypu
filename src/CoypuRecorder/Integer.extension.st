Extension { #name : 'Integer' }

{ #category : '*CoypuRecorder' }
Integer >> delayed: aMethodOfInteger atTime: aDelayInMilliseconds [

	(Delay forMilliseconds: aDelayInMilliseconds) wait.

	Object readFromString:  self asString , aMethodOfInteger
]
