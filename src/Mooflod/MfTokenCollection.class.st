Class {
	#name : 'MfTokenCollection',
	#superclass : 'Object',
	#instVars : [
		'string',
		'tokens',
		'ropedText'
	],
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'converting' }
MfTokenCollection >> asMfRopedText [

	ropedText := '' asRopedText foreground: Color white.
	self tokens do: [ :i |
		ropedText := ropedText , (i string asRopedText foreground: i color) , (' ' asRopedText foreground: Color white )].
	^ ropedText
]

{ #category : 'initialization' }
MfTokenCollection >> initialize [ 
super initialize.
tokens := Array new.
]

{ #category : 'accessing' }
MfTokenCollection >> tokens [ 

^ tokens
]

{ #category : 'accessing' }
MfTokenCollection >> tokens: anArray [

tokens := anArray 
	
]
