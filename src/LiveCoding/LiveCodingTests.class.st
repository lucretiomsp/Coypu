Class {
	#name : #LiveCodingTests,
	#superclass : #TestCase,
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
LiveCodingTests >> testPerformanceSolo [

	| p |
	p := Performance new.
	p at: #kick put: 16 downbeats.
	p at: #tom put: 32 shiko.
	p at: #oh put: 16 upbeats.
	p at: #snare put: '0240' pattern.

	self assert: (p solo: #tom) keys equals: #tom
]
