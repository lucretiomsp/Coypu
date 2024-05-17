Class {
	#name : #PerformanceRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder'
	],
	#category : #'CoypuRecorder-Tests-Tests'
}

{ #category : #tests }
PerformanceRecorderTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : #running }
PerformanceRecorderTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt  new
]

{ #category : #tests }
PerformanceRecorderTest >> testFreq [

	self assertEmpty: self commands.

	performanceRecorder freq: 138 bpm.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p freq: 138 bpm.'
]

{ #category : #tests }
PerformanceRecorderTest >> testMute [

	self assertEmpty: self commands.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p mute: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlay [

	self assertEmpty: self commands.

	performanceRecorder play.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p play.'
]

{ #category : #tests }
PerformanceRecorderTest >> testPlayFor [

	self assertEmpty: self commands.

	performanceRecorder playFor: 12 bars.

	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p playFor: 12 bars.'
]

{ #category : #tests }
PerformanceRecorderTest >> testRestore [

	self assertEmpty: self commands.

	16 upbeats to: #bb.
	performanceRecorder mute: #bb.
	performanceRecorder restore.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p restore.'
]

{ #category : #tests }
PerformanceRecorderTest >> testSameAPIThanPerformance [

	| api |
	api := PerformanceRecorder selectors. "ici on pourra filtrer"
	Performance selectors do: [ :s | self assert: (api includes: s) ]
]

{ #category : #tests }
PerformanceRecorderTest >> testSolo [
	self assertEmpty: self commands.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p solo: #bb.'
]

{ #category : #tests }
PerformanceRecorderTest >> testStop [

	self assertEmpty: self commands.

	16 upbeats to: #bb.
	performanceRecorder stop.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p stop.'
]

{ #category : #tests }
PerformanceRecorderTest >> testUnsolo [

	self assertEmpty: self commands.

	16 upbeats to: #bb.
	performanceRecorder solo: #bb.
	performanceRecorder unsolo: #bb.
	self denyEmpty: self commands.

	self assert: self commands last print equals: 'p unsolo: #bb.'
]
