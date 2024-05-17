Class {
	#name : #SavedPerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performanceRecorder',
		'replayer'
	],
	#category : #'CoypuRecorder-Tests-Tests'
}

{ #category : #tests }
SavedPerformanceTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : #running }
SavedPerformanceTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.
	performanceRecorder performer: PerformerSuperDirt new.
	replayer := PerformanceTextualReplayer new
]

{ #category : #tests }
SavedPerformanceTest >> testAbsoluteToDelay [

	| x |
	self assertEmpty: self commands.

	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	(Delay forSeconds: 1) wait.
	performanceRecorder freq: 138 bpm.
	(Delay forSeconds: 1) wait.
	performanceRecorder playFor: 4 bars.
	x := performanceRecorder savedPerformance absoluteToDelay.
	self assert: (x at: 1) equals: 0.
	self assert: (x at: 2) equals: 0.
	self assert: (x at: 3) equals: 1.
	self assert: (x at: 4) equals: 1
]

{ #category : #tests }
SavedPerformanceTest >> testAbsoluteToRelative [

	| x |
	self assertEmpty: self commands.

	16 upbeats to: #bd.
	(Delay forSeconds: 1) wait.
	performanceRecorder freq: 138 bpm.
	(Delay forSeconds: 1) wait.
	performanceRecorder playFor: 4 bars.
	x := performanceRecorder savedPerformance absoluteToRelative.
	self assert: (x at: 1) equals: '0'.
	self assert: (x at: 2) equals: '1'.
	self assert: (x at: 3) equals: '2'
]

{ #category : #tests }
SavedPerformanceTest >> testAddInstrument [

	self assertEmpty: self commands.

	16 upbeats to: #bd.

	self denyEmpty: self commands.

	self assert: self commands last rythm equals: '16 upbeats'
]

{ #category : #tests }
SavedPerformanceTest >> testBodyScripts [

	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	performanceRecorder savedPerformance collectionOfCommands
		with:
		(performanceRecorder savedPerformance bodyScripts)
		do: [ :x :y | self assert: x print equals: y ]
]

{ #category : #tests }
SavedPerformanceTest >> testLastDirtNotes [

	self assertEmpty: self commands.

	16 upbeats
		to: #bd;
		dirtNotes: '4'.
	self denyEmpty: self commands.

	self assert: self commands last dirtNotes equals: '4'.

	8 upbeats
		dirtNotes: '8';
		to: #bass3.

	self assert: self commands last dirtNotes equals: '8'
]

{ #category : #tests }
SavedPerformanceTest >> testLastSymbol [

	self assertEmpty: self commands.

	16 upbeats to: #bb.

	self denyEmpty: self commands.

	self assert: self commands last symbol equals: 'bb'
]

{ #category : #tests }
SavedPerformanceTest >> testRightNumberOfCommandsInSavedPerformance [

	self assertEmpty: self commands.

	16 upbeats to: #bb.

	performanceRecorder freq: 138 bpm.

	performanceRecorder playFor: 12 bars.

	performanceRecorder stop.

	self denyEmpty: self commands.

	self assert: self commands size equals: 4
]

{ #category : #tests }
SavedPerformanceTest >> testScriptForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScript: performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 5.

	self
		assert: (replayer performanceScript at: 3)
		equals: '16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 4)
		equals: 'p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: 'p playFor: 4 bars.
'
]

{ #category : #tests }
SavedPerformanceTest >> testScriptWithDelayTimeForReplayer [

	replayer := PerformanceMusicalReplayer new.
	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScript: performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 5.

	self
		assert: (replayer performanceScript at: 3)
		equals: '16 upbeats to: #bd atTime: 0.
'.
	self
		assert: (replayer performanceScript at: 4)
		equals: 'p freq: 138 bpm atTime: 0.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: 'p playFor: 4 bars atTime: 0.
'
]

{ #category : #tests }
SavedPerformanceTest >> testScriptWithRelativeTimeForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScriptWithRelativeTime:
		performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 5.

	self
		assert: (replayer performanceScript at: 3)
		equals: '"//At the 0th second\\"
16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 4)
		equals: '"//At the 0th second\\"
p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: '"//At the 0th second\\"
p playFor: 4 bars.
'
]

{ #category : #tests }
SavedPerformanceTest >> testScriptWithTimeForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScriptWithTime: performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 5.

	self
		assert: (replayer performanceScript at: 3)
		equals: '"#At ' , DateAndTime now rounded asTime asString , ' :"
16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 4)
		equals: '"#At ' , DateAndTime now rounded asTime asString , ' :"
p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: '"#At ' , DateAndTime now rounded asTime asString , ' :"
p playFor: 4 bars.
'
]

{ #category : #tests }
SavedPerformanceTest >> testTimes [

	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	performanceRecorder savedPerformance collectionOfCommands
		with: performanceRecorder savedPerformance times
		do: [ :x :y | self assert: x time rounded asTime equals: y ]
]

{ #category : #tests }
SavedPerformanceTest >> testVisitCommandScript [

	16 upbeats to: #bd.

	self
		assert: self commands last print
		equals:
			(performanceRecorder savedPerformance visitCommandScript:
				 self commands last)
]

{ #category : #tests }
SavedPerformanceTest >> testVisitCommandTime [

	16 upbeats to: #bd.

	self
		assert: self commands last time rounded asTime
		equals:
			(performanceRecorder savedPerformance visitCommandTime:
				 self commands last)
]
