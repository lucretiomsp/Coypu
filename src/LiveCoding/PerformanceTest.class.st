Class {
	#name : #PerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performance',
		'performer'
	],
	#category : #'LiveCoding-Tests'
}

{ #category : #tests }
PerformanceTest >> setUp [ 

	performance := Performance basic.
	performer := PerformerMock new.
	performance performer: performer.

]

{ #category : #tests }
PerformanceTest >> testPerformanceSendBPMOnPlay [

	performance play: 42 bpm for: 1 bars.

	self assert: performer bpm equals: 42
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithFirstNote [

	performance at: #kick put: (15 rumba notes: #( 20 30 40 50 )).

	performance play: 60 bpm for: 1 bars.

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 1) wait.

	self assert: performer lastGate equals: 'kick'.
	self assert: (performer noteFor: 'kick') equals: 20
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithSecondNote [

	performance at: #kick put: (15 rumba notes: #( 20 30 40 50 )).

	performance play: 60 bpm for: 1 bars.

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 2) wait.

	self assert: performer lastGate equals: 'kick'.
	self assert: (performer noteFor: 'kick') equals: 30
]
