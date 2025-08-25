Class {
	#name : 'MfLexer',
	#superclass : 'Object',
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'parsing' }
MfLexer >> parse: aString [

	| tokens result arrayOfTokens |
	tokens := aString findBetweenSubstrings: ' '.
	arrayOfTokens := tokens collect: [ :i | MfCodeToken fromString: i ].
	result := MfTokenCollection new tokens: arrayOfTokens .
	^ result
]
