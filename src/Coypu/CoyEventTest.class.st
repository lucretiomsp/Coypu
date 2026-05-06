Class {
	#name : 'CoyEventTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
CoyEventTest >> estInitialization [
    | event |
    event := CoyEvent onset: 1/3 value: 'bd'.
    self assert: event onset equals: 1/3.
    self assert: event value equals: 'bd'.
]

{ #category : 'as yet unclassified' }
CoyEventTest >> testEquality [
    self
        assert: (CoyEvent onset: 1/3 value: 'bd')
        equals: (CoyEvent onset: 1/3 value: 'bd').
]

{ #category : 'as yet unclassified' }
CoyEventTest >> testHash [
    | a b |
    a := CoyEvent onset: 1/3 value: 'bd'.
    b := CoyEvent onset: 1/3 value: 'bd'.
    self assert: a hash equals: b hash.
]

{ #category : 'as yet unclassified' }
CoyEventTest >> testInequalityOnset [
    self
        deny: (CoyEvent onset: 1/3 value: 'bd')
        equals: (CoyEvent onset: 1/4 value: 'bd').

]

{ #category : 'as yet unclassified' }
CoyEventTest >> testInequalityValue [
    self
        deny: (CoyEvent onset: 1/3 value: 'bd')
        equals: (CoyEvent onset: 1/3 value: 'sd').
]

{ #category : 'as yet unclassified' }
CoyEventTest >> testInitializationWithZeroOnset [
    | event |
    event := CoyEvent onset: 0 value: 'sd'.
    self assert: event onset equals: 0.
    self assert: event value equals: 'sd'.

]

{ #category : 'tests' }
CoyEventTest >> testPrintOn [
    | event |
    event := CoyEvent onset: 1/3 value: 'bd'.
    self assert: event printString equals: 'CoyEvent(1/3 -> ''bd'')'.
]
