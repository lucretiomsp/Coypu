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
PerformanceTest >> playPerformance [

	performance at: #gate put: ((15 rumba notes: #( 10 20 30 ))
			 and: #( 'extra1' #( 40 60 90 ) )
			 and: #( 'extra2' #( 45 65 95 ) )).

	performance play: 60 bpm for: 1 bars.

	self waitASecond
]

{ #category : #tests }
PerformanceTest >> setUp [

	performance := Performance basic.
	performer := PerformerMock new.
	performance performer: performer.
	self playPerformance
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendBPMOnPlay [

	self assert: performer bpm equals: 60
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithExtra1 [

	self assert: (performer noteFor: 'gateextra1') equals: 40
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithExtra2 [

	self assert: (performer noteFor: 'gateextra2') equals: 45
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithFirstNote [

	self assert: performer lastGate equals: 'gate'.
	self assert: (performer noteFor: 'gate') equals: 10
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithSecondNote [

	self waitASecond. "Wait another second"

	self assert: (performer noteFor: 'gate') equals: 20
]

{ #category : #tests }
PerformanceTest >> waitASecond [

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 1) wait
]
