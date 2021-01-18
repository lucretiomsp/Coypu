Class {
	#name : #OSCPacket,
	#superclass : #Object,
	#instVars : [
		'byteStream'
	],
	#category : #LiveCoding
}

{ #category : #'access to cache' }
OSCPacket class >> for: somePackets [
	^ self new initializeFor: somePackets 
]

{ #category : #accessing }
OSCPacket >> byteArray [
	^self byteStream binary contents
]

{ #category : #accessing }
OSCPacket >> byteStream [
	^byteStream
]

{ #category : #initialization }
OSCPacket >> initializeFor: somePackets [
	byteStream := 
		(RWBinaryOrTextStream on: '')
			yourself.
	self print: somePackets onOSCStream: byteStream
]

{ #category : #accessing }
OSCPacket >> oSCSize [
	^self byteArray size
]

{ #category : #printing }
OSCPacket >> print: somePackets onOSCStream: aStream [
	self subclassResponsibility
]

{ #category : #action }
OSCPacket >> sendTo: aByteArray port: aPort [ 
	"Take care, A byte array is not a string.
	If you want to send to e.g. '192.168.0.2' 
	sendToAddressString: port: instead
	But use this one if you want to be fast."
	| aSocket |
	Socket initializeNetwork.
	aSocket := Socket newUDP.
	aSocket
		sendUDPData: self byteArray
		toHost: aByteArray
		port: aPort;
		 close;
		 destroy
]

{ #category : #action }
OSCPacket >> sendToAddressString: anAddressString port: aPort [ 
	self 
		sendTo: ((anAddressString findTokens: '.') collect: [:e | e asNumber]) 
				asByteArray
		port: aPort
]

{ #category : #action }
OSCPacket >> sendToYourself [
	self sendTo: NetNameResolver localHostAddress port: 57123
]
