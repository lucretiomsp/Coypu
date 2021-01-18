Class {
	#name : #OSCMessage,
	#superclass : #OSCPacket,
	#category : #LiveCoding
}

{ #category : #examples }
OSCMessage class >> example1 [
	^self for: {'/example1' . 100}
]

{ #category : #examples }
OSCMessage class >> example2 [
	^self for: {'/example2' . 'tester' . 10.4}
]

{ #category : #examples }
OSCMessage class >> example3 [
	^self for: {'/example3' . 20 . 30 . 'bla'}
]

{ #category : #examples }
OSCMessage class >> exampleBerkeley2 [
	^self for: self exampleBerkeley2Message
]

{ #category : #examples }
OSCMessage class >> exampleBerkeley2Message [
	^{'/foo' . 1000 . -1 . 'hello' . 1.234 . 5.678}
]

{ #category : #examples }
OSCMessage class >> exampleBerkeley3 [
	^self for: self exampleBerkeley3Message
]

{ #category : #examples }
OSCMessage class >> exampleBerkeley3Message [
	^{'/foo' . 1000 . -1 . 'hello' .1.125 . 4.0625 }
]

{ #category : #examples }
OSCMessage class >> exampleSCA [
	^self for: {'a' . 1 . 0.2}
]

{ #category : #examples }
OSCMessage class >> exampleSCDecreaseVolume [
	^self for: {'/sc/mixer/volume' . 1 . 0.2}
]

{ #category : #examples }
OSCMessage class >> exampleSCIncreaseVolume [
	^self for: self increaseVolumeMessage
]

{ #category : #examples }
OSCMessage class >> exampleSCRun [
	"self exampleSCRun sendTo: '10.0.1.2' port: 22"
	^self for: {'/sc/run'}
]

{ #category : #examples }
OSCMessage class >> exampleSCStop [
	^self for: {'/sc/stop'}
]

{ #category : #examples }
OSCMessage class >> increaseVolumeMessage [
	^{'/sc/mixer/volume' . 1 . 1.0}
]

{ #category : #printing }
OSCMessage >> print: someArguments onOSCStream: aStream [

	| someParams |
	self printAddress: someArguments first onOSCStream: aStream.
	"Put the comma, also parameterless messages have one"
	aStream nextPut: 44.
	someParams := someArguments copyFrom: 2 to: someArguments size.
	self	
		printTypesOf: someParams on: aStream;
		printValues: someParams onOSCStream: aStream

]

{ #category : #printing }
OSCMessage >> printAddress: anAddress onOSCStream: aStream [

	anAddress printOnOSCStream: aStream
	

]

{ #category : #printing }
OSCMessage >> printTypesOf: someValues on: aStream [

	|aNullChar|	
	someValues isEmpty ifTrue: [^self].	
	aNullChar := Character value: 0.
	someValues do: [ :each | each printTypeOnOSCStream: aStream ].
	(4 - (aStream position \\ 4)) timesRepeat: [ aStream nextPut: aNullChar ]

]

{ #category : #printing }
OSCMessage >> printValues: someValues onOSCStream: aStream [
	someValues do: [ :each | each printOnOSCStream: aStream ]

]
