Extension { #name : #String }

{ #category : #'*PharoCollider' }
String >> asPString [

	"SuperCollider pascal format string: a byte (an unsigned int8) giving the length followed by that many bytes."

	| pString |
	pString := ByteArray new: self size + 1.
	pString at: 1 put: self size.
	2 to: (self size + 1) do: [ :i | 
	pString at: i put: (self asByteArray at: i - 1) ].

	^ pString
]
