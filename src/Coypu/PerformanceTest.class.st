Class {
	#name : 'PerformanceTest',
	#superclass : 'TestCase',
	#instVars : [
		'perf'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
PerformanceTest >> setUp [
	super setUp.

	perf := Performance uniqueInstance performer: PerformerLocal new.
	perf freq: 220 bpm.
]

{ #category : 'tests' }
PerformanceTest >> testChangeIndexOfSeq [

| p |
p := Performance uniqueInstance .
16 downbeats to: #kick.
#kick index: '1 2 3'.
self assert: (((p at: #kick ) extraParams ) at: #Index) equals: #(1 2 3). 
]

{ #category : 'tests' }
PerformanceTest >> testPlayFor1Bars [

perf playFor: 1 bars.

2 seconds wait.
self assert: perf transportStep equals: 16.
]

{ #category : 'tests' }
PerformanceTest >> testSetBpm [

perf bpm: 240.
self assert: perf freq equals: 1/16.
]
