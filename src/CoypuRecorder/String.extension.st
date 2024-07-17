Extension { #name : #String }

{ #category : #'*CoypuRecorder' }
String >> suffixeNumber [
"return the right suffixe between th and rd "
	| suffixe |
	suffixe := 'th'.
	self last asString = '3' ifTrue: [ suffixe := 'rd' ].
	^ suffixe
]
