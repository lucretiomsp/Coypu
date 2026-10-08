Class {
	#name : 'OSCSendTest',
	#superclass : 'TestCase',
	#instVars : [
		'server',
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
OSCSendTest >> playOneBarOf: aSequencer [
	"240 bpm: one step is 62.5 ms, one bar (16 steps) is 1 s"
	aSequencer to: #kick.
	perf playFor: 16.
	1.5 seconds wait
]

{ #category : 'running' }
OSCSendTest >> receivedMessages [
	| messages |
	messages := OrderedCollection new.
	[ server hasMessage ] whileTrue: [ messages add: server nextMessage ].
	^ messages asArray
]

{ #category : 'running' }
OSCSendTest >> setUp [

	super setUp.
	[ server := OSCServer listenOnPort: 57120 ]
		on: Error
		do: [ self skip: 'port 57120 busy (SuperCollider running?)' ].
	perf := Performance uniqueInstance performer: PerformerLocal new.
	perf freq: 280 bpm
]

{ #category : 'running' }
OSCSendTest >> tearDown [

	server ifNotNil: [ server terminate ].
	perf ifNotNil: [ perf stop; muteAll ].
	super tearDown
]

{ #category : 'tests' }
OSCSendTest >> testOneBarOfDownbeatsMessageSequence [
	| oneHit expected |
	self playOneBarOf: 16 downbeats.
	oneHit := { #( '/kickNote' 60.0 ) . #( '/kickGate' 1.0 ) . #( '/kickGate' 0.0 ) }.
	expected := (1 to: 4) flatCollect: [ :i | oneHit ].
	self assert: self receivedMessages equals: expected
]

{ #category : 'tests' }
OSCSendTest >> testOneBarOfDownbeatsTriggersFourKicks [
	| gateOns |
	self playOneBarOf: 16 downbeats.
	gateOns := self receivedMessages select: [ :m | m = #( '/kickGate' 1.0 ) ].
	self assert: gateOns size equals: 4
]

{ #category : 'tests' }
OSCSendTest >> testOneBarSendsSequencerNotes [
	| notes |
	self playOneBarOf: (16 downbeats notes: #( 60 62 64 65 ); yourself).
	notes := (self receivedMessages select: [ :m | m first = '/kickNote' ])
		collect: [ :m | m second ].
	self assert: notes asArray equals: #( 60.0 62.0 64.0 65.0 )
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
