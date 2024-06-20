Extension { #name : #ByteString }

{ #category : #'*CoypuRecorder' }
ByteString >> delayed: aMethodOfInteger atTime: aDelayInMilliseconds [

	(Delay forMilliseconds: aDelayInMilliseconds) wait.

	Object readFromString:'''', self asString ,'''' , aMethodOfInteger
]

{ #category : #'*CoypuRecorder' }
ByteString >> onceAtSpeed: aFloat atTime: aDelayInMilliseconds [

	(Delay forMilliseconds: aDelayInMilliseconds) wait.
	self onceAtSpeed: aFloat
]

{ #category : #'*CoypuRecorder' }
ByteString >> onceAtSpeed: aFloat withNote: aNote atTime: aDelayInMilliseconds [

		(Delay forMilliseconds: aDelayInMilliseconds) wait.
	self onceAtSpeed: aFloat withNote: aNote
]

{ #category : #'*CoypuRecorder' }
ByteString >> onceAtTime: aDelayInMilliseconds [

	(Delay forMilliseconds: aDelayInMilliseconds) wait.
	 self once
]
