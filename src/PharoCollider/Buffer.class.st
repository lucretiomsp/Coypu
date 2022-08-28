"
Use the buffer to load samples
"
Class {
	#name : #Buffer,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #PharoCollider
}

{ #category : #'meta-object-protocol' }
Buffer class >> read: aStringFilePath [

	| bufNumber instance |
	bufNumber := Random new nextInteger: 999.
	(OSCMessage for: { 
			 'b_allocRead'.
			 bufNumber .
			aStringFilePath. 
			 0.
			 -1 }) sendToAddressString: '127.0.0.1' port: 57110.
	instance := self basicNew.
	instance setNumber: bufNumber.
	^ instance
]

{ #category : #initialization }
Buffer >> number [

	^ number
]

{ #category : #initialization }
Buffer >> setNumber: anInteger [

	number := anInteger
]
