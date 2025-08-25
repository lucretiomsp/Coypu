Class {
	#name : 'MfTokenCollection',
	#superclass : 'Object',
	#instVars : [
		'string',
		'tokens'
	],
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

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
