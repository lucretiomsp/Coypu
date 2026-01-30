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
