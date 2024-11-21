Extension { #name : 'Dictionary' }

{ #category : '*Coypu' }
Dictionary >> errorKeyNotFound: aKey [

"we also stop the Performance"
self inform: aKey asString , ' bit found in Dictionary'.
"Performance uniqueInstance stop."
	"KeyNotFound signalFor: aKey."
	
]
