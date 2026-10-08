Class {
	#name : 'OSCSendTest',
	#superclass : 'TestCase',
	#instVars : [
		'server'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
OSCSendTest >> setUp [
	super setUp.
	[ server := OSCServer listenOnPort: 57120 ]
		on: Error
		do: [ self skip: 'port 57120 busy (SuperCollider running?)' ]
]

{ #category : 'running' }
OSCSendTest >> tearDown [
	server ifNotNil: [ server terminate ].
	super tearDown
]

{ #category : 'tests' }
OSCSendTest >> testToLocalConvertsFractionToFloat [
	(3 / 4) toLocal: 'test'.
	30 milliSeconds wait.
	self assert: server hasMessage.
	self assert: server nextMessage equals: #( '/test' 0.75 )
]

{ #category : 'tests' }
OSCSendTest >> testToLocalSendsAddressAndValue [
	120 toLocal: 'test'.
	30 milliSeconds wait.
	self assert: server hasMessage.
	self assert: server nextMessage equals: #( '/test' 120.0 )
]
