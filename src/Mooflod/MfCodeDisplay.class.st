Class {
	#name : 'MfCodeDisplay',
	#superclass : 'Object',
	#instVars : [
		'textElement',
		'fontSize',
		'mcdSize',
		'mcdSpace'
	],
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'adding' }
MfCodeDisplay >> addLineOfText: aRopedText [

	| myRoot |
	myRoot := self mcdSpace root.
	myRoot addChild: (BlTextElement new
			 extent: 600 @ 40;
			 background: Color black;
			 text: (aRopedText fontSize: 30)).
	myRoot children size > 10
		ifTrue: [ myRoot removeChildAt: 1 ]
		ifFalse: [ ]
]

{ #category : 'accessing' }
MfCodeDisplay >> fontSize [ 

^ fontSize
]

{ #category : 'initialization' }
MfCodeDisplay >> initialize [

	super initialize.
	fontSize := 28.
	mcdSpace := BlSpace new
		            extent: self mcdSize;
		            title: 'Mooflod Code Display'.
	mcdSpace root background: Color black; layout: BlLinearLayout vertical.

	textElement := BlTextElement new
		               background: Color black;
		               extent: self mcdSize
]

{ #category : 'accessing' }
MfCodeDisplay >> mcdSize [

	^ 950 @ 500
]

{ #category : 'accessing' }
MfCodeDisplay >> mcdSpace [

	^ mcdSpace 
]

{ #category : 'instance creation' }
MfCodeDisplay >> open [


	
	mcdSpace show
]

{ #category : 'accessing' }
MfCodeDisplay >> text: aRopedText [

	self textElement text: (aRopedText fontSize: self fontSize)
]

{ #category : 'accessing' }
MfCodeDisplay >> textElement [ 

^ textElement
]
