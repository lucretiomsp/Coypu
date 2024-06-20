Class {
	#name : 'PerformanceRecorderTest',
	#superclass : 'TestCase',
	#instVars : [
		'performanceRecorder'
	],
	#category : 'CoypuRecorder-Tests-Tests',
	#package : 'CoypuRecorder-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
PerformanceRecorderTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : 'running' }
PerformanceRecorderTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder displayVisualizer: false.
	performanceRecorder performer: PerformerSuperDirt new
]

{ #category : 'tests' }
PerformanceRecorderTest >> testActiveDSP [

	| grooveBox |
	performanceRecorder activeDSP: 'grooveBox'.

	self denyEmpty: self commands.

	self
		assert: self commands last print
		equals: 'p activeDSP: grooveBox.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testFreq [


	performanceRecorder freq: 138 bpm.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p freq: 138 bpm.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testMute [



	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p mute: #bb.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testPlay [



	performanceRecorder play.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p play.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testPlayFor [



	performanceRecorder playFor: 12 bars.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p playFor: 12 bars.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testRestore [



	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	performanceRecorder restore.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p restore.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testSameAPIThanPerformance [

	| api |
	api := PerformanceRecorder selectors. "ici on pourra filtrer"
	Performance selectors do: [ :s | self assert: (api includes: s) ]
]

{ #category : 'tests' }
PerformanceRecorderTest >> testSolo [


	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p solo: #bb.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testStop [



	16 upbeats to: #bb.
	performanceRecorder stop.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p stop.'
]

{ #category : 'tests' }
PerformanceRecorderTest >> testUnsolo [



	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	performanceRecorder unsolo: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p unsolo: #bb.'
]
