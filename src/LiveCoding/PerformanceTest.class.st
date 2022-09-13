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
PerformanceTest >> testPerformanceKeysSwap [

	| seq1 seq2 p |
	p := Performance new.
	seq1 := 4 downbeats.
	seq2 :=  4 semiquavers.
	p at: #a put: seq1.
	p at: #b put: seq2.
	
	p swap: #a with: #b.
	self assert: ( p at: #b) equals: seq1


]

{ #category : #tests }
PerformanceTest >> testPerformanceSendBPMOnPlay [

	self assert: performer bpm equals: 60
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendDurations [

	self assert: (performer durationFor: 'gate') equals: 1
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
PerformanceTest >> testPerformanceSolo [

	| p |
	p := Performance new.
	p at: #kick put: 16 downbeats.
	p at: #tom put: 32 shiko.
	p at: #oh put: 16 upbeats.
	p at: #snare put: '0240' pattern.

	self assert: (p solo: #tom) keys equals: #tom
]

{ #category : #tests }
PerformanceTest >> waitASecond [

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 1) wait
]
