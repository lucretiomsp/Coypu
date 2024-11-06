Extension { #name : 'Dictionary' }

{ #category : '*Coypu' }
Dictionary >> errorKeyNotFound: aKey [

"we also stop the Performance"
	KeyNotFound signalFor: aKey.
	Performance uniqueInstance stop.
]
