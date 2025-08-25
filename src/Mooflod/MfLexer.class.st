Class {
	#name : 'MfLexer',
	#superclass : 'Object',
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'parsing' }
MfLexer >> parse: aString [

	| tokens result |
	tokens := aString findBetweenSubstrings: ' '.
	result := tokens collect: [ :i | MfCodeToken fromString: i ].
	^ result
]
