Class {
	#name : 'MfCodeDisplay',
	#superclass : 'Object',
	#instVars : [
		'textElement',
		'fontSize',
		'mcdSize'
	],
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'accessing' }
MfCodeDisplay >> fontSize [ 

^ fontSize
]

{ #category : 'initialization' }
MfCodeDisplay >> initialize [

	super initialize.
	fontSize := 28.
	textElement := BlTextElement new
		               background: Color black;
		               extent: self mcdSize
]

{ #category : 'accessing' }
MfCodeDisplay >> mcdSize [

^ 600 @ 300.
]

{ #category : 'instance creation' }
MfCodeDisplay >> open [

	| cdSpace  |
	
	cdSpace := BlSpace new
		           extent: self mcdSize;
		           title: 'Mooflod Code Display'.
	cdSpace root addChild: self textElement.
	cdSpace show
]

{ #category : 'accessing' }
MfCodeDisplay >> text: aRopedText [

	self textElement text: (aRopedText fontSize: self fontSize)
]

{ #category : 'accessing' }
MfCodeDisplay >> textElement [ 

^ textElement
]
