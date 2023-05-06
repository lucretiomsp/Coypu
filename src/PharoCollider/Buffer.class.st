"
Use the buffer to load samples
"
Class {
	#name : #Buffer,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#classInstVars : [
		'number'
	],
	#category : #PharoCollider
}

{ #category : #accessing }
Buffer class >> number [
^ number
]

{ #category : #accessing }
Buffer class >> number: anInteger [

	number := anInteger
]

{ #category : #'meta-object-protocol' }
Buffer class >> read: aStringFilePath [

	| bufNumber instance |
	number
		ifNotNil: [ bufNumber := number + 1 ]
		ifNil: [ bufNumber := 0 ].
	(OSCMessage for: { 
			 'b_allocRead'.
			 bufNumber.
			 aStringFilePath.
			 0.
			 -1 }) sendToAddressString: '127.0.0.1' port: 57110.
	instance := self new.
	instance number: bufNumber.
	
	^ instance
]

{ #category : #initialization }
Buffer >> initialize [ 
super initialize .
self class number
		ifNotNil: [ self class number: self class number + 1 ]
		ifNil: [ self class number: 0 ].
	self number: self class number
]

{ #category : #initialization }
Buffer >> number [

	^ number
]

{ #category : #initialization }
Buffer >> number: anInteger [

	number := anInteger
]
