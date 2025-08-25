Class {
	#name : 'CodeDisplayTest',
	#superclass : 'TestCase',
	#category : 'Mooflod-Tests',
	#package : 'Mooflod',
	#tag : 'Tests'
}

{ #category : 'tests' }
CodeDisplayTest >> testCoypuExpressionAsColoredRopedText [

	| expression parsedEpression ropedText tk1 tk2 tk3 tk4 tk5 tk6 tk7|
	expression := '''f08c'' hexBeat , 16  quavers to: #kick'.
	parsedEpression := MfLexer new parse: expression.
	ropedText := parsedEpression asMfRopedText.
	ropedText inspect.
	tk7 := ropedText rope .
   self assert: tk7 attributes equals:  #(text-foreground: Color orange).
]

{ #category : 'tests' }
CodeDisplayTest >> testCoypuExpressionAsMfToken [

	| expression result |
	expression := '''f08c'' hexBeat , 16  quavers to: #kick'.
	result := (MfLexer new parse: expression) tokens.
	self assert: result first class equals: MfQuotedString.
	self assert: (result at: 2) class equals: MfCodeToken.
	self assert: (result at: 3) class equals: MfCodeToken.
	self assert: (result at: 4) class equals: MfNumberToken.
	self assert: (result at: 5) class equals: MfCodeToken.
	self assert: (result at: 6) class equals: MfCodeToken.
	self assert: (result at: 7) class equals: MfSymbolToken
]

{ #category : 'tests' }
CodeDisplayTest >> testIsQuotedString [

self assert: '''test''' isQuotedString equals: true
	
]
