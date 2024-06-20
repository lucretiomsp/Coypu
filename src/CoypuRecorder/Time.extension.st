Extension { #name : #Time }

{ #category : #'*CoypuRecorder' }
Time >> addMilliSeconds: nMilliSeconds [
	"Answer a Time that is nSeconds after the receiver."

	^ self class seconds: self asMilliSeconds + nMilliSeconds / 1000 asFloat
]
