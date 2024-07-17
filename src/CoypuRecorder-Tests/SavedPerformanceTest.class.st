Class {
	#name : 'SavedPerformanceTest',
	#superclass : 'TestCase',
	#instVars : [
		'performanceRecorder',
		'replayer'
	],
	#category : 'CoypuRecorder-Tests-Tests',
	#package : 'CoypuRecorder-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
SavedPerformanceTest >> commands [

	^ performanceRecorder savedPerformance collectionOfCommands
]

{ #category : 'running' }
SavedPerformanceTest >> setUp [

	super setUp.
	performanceRecorder := PerformanceRecorder uniqueInstance.

	performanceRecorder performer: PerformerSuperDirt new.
	replayer := PerformanceTextualReplayer new
]

{ #category : 'running' }
SavedPerformanceTest >> tearDown [
	
	performanceRecorder stop.
	super tearDown
]

{ #category : 'tests' }
SavedPerformanceTest >> testAbsoluteToDelay [

	| x |
	self assert: self commands size equals: 1.

	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	(Delay forSeconds: 1) wait.
	performanceRecorder freq: 138 bpm.
	(Delay forSeconds: 1) wait.
	performanceRecorder playFor: 4 bars.
	x := performanceRecorder savedPerformance absoluteToDelay.
	self assert: (x at: 1) equals: 0.
	self assert: (x at: 2) equals: 0.
	self assert: (x at: 3) equals: 0.
	self
		assert:
		(999 < (x at: 4) asInteger and: [ (x at: 4) asInteger < 1050 ])
		equals: true.
	self
		assert:
		(999 < (x at: 5) asInteger and: [ (x at: 5) asInteger < 1050 ])
		equals: true
]

{ #category : 'tests' }
SavedPerformanceTest >> testAbsoluteToRelative [

	| x |
	self assert: self commands size equals: 1.

	16 upbeats to: #bd.
	(Delay forSeconds: 1) wait.
	performanceRecorder freq: 138 bpm.
	(Delay forSeconds: 1) wait.
	performanceRecorder playFor: 4 bars.
	x := performanceRecorder savedPerformance absoluteToRelative.
	self assert: (x at: 2) equals: '0'.
	self
		assert:
		(999 < (x at: 3) asInteger and: [ (x at: 3) asInteger < 1050 ])
		equals: true.
	self
		assert:
		(1999 < (x at: 4) asInteger and: [ (x at: 4) asInteger < 2050 ])
		equals: true
]

{ #category : 'tests' }
SavedPerformanceTest >> testAddInstrument [

	self commands size traceCr.
	16 upbeats to: #bd.

	self denyEmpty: self commands.

	self assert: self commands last rhythm equals: '16 upbeats'
]

{ #category : 'tests' }
SavedPerformanceTest >> testBodyScripts [

	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	performanceRecorder savedPerformance collectionOfCommands
		with:
		(performanceRecorder savedPerformance bodyScripts)
		do: [ :x :y | self assert: x print equals: y ]
]

{ #category : 'tests' }
SavedPerformanceTest >> testDoubleRhythmesCatched [

	16 upbeats , 16 downbeats to: #bass3.

	self denyEmpty: self commands.
	self
		assert: self commands last print
		equals: '16 upbeats, 16 downbeats to: #bass3.'
		
	
]

{ #category : 'tests' }
SavedPerformanceTest >> testLastDirtNotes [



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

{ #category : 'tests' }
SavedPerformanceTest >> testLastSymbol [

	16 upbeats to: #bb.

	self denyEmpty: self commands.

	self assert: self commands last symbol equals: 'bb'
]

{ #category : 'tests' }
SavedPerformanceTest >> testNotesAdded [

	16 upbeats notes: #( 43 45 67 ) to: #bb.

	self denyEmpty: self commands.

	self assert: self commands last notes equals: ' notes: #(43 45 67)'.

]

{ #category : 'tests' }
SavedPerformanceTest >> testNotesNotAddedIfNotCalled [

	16 downbeats to: #bass3.

	self denyEmpty: self commands.

	self assert: self commands last notes equals: nil
]

{ #category : 'tests' }
SavedPerformanceTest >> testOnceCatched [

	'bass3' once.

	self denyEmpty: self commands.

	self assert: self commands last rhythm equals: nil.
	self assert: self commands last symbol equals: ' ''bass3'' once'
]

{ #category : 'tests' }
SavedPerformanceTest >> testRightNumberOfCommandsInSavedPerformance [



	16 upbeats to: #bb.

	performanceRecorder freq: 138 bpm.

	performanceRecorder playFor: 12 bars.

	performanceRecorder stop.

	self denyEmpty: self commands.

	self assert: self commands size equals: 5.
]

{ #category : 'tests' }
SavedPerformanceTest >> testScriptForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScript: performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 6.

	self
		assert: (replayer performanceScript at: 4)
		equals: '16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: 'p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 6)
		equals: 'p playFor: 4 bars.
'
]

{ #category : 'tests' }
SavedPerformanceTest >> testScriptWithDelayTimeForReplayer [

	replayer := PerformanceMusicalReplayer new.
	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScript: performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 6.

	self
		assert: (replayer performanceScript at: 4)
		equals: '16 upbeats to: #bd atTime: 0.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: 'p freq: 138 bpm atTime: 0.
'.
	self
		assert: (replayer performanceScript at: 6)
		equals: 'p playFor: 4 bars atTime: 0.
'
]

{ #category : 'tests' }
SavedPerformanceTest >> testScriptWithRelativeTimeForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScriptWithRelativeTime:
		performanceRecorder savedPerformance.
	" The size of performanceScript is 5 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 6.

	self
		assert: (replayer performanceScript at: 4)
		equals: '"//At 0 milliseconds\\"
16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: '"//At 0 milliseconds\\"
p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 6)
		equals: '"//At 0 milliseconds\\"
p playFor: 4 bars.
'
]

{ #category : 'tests' }
SavedPerformanceTest >> testScriptWithTimeForReplayer [

	self assert: replayer performanceScript isNil equals: true.

	16 upbeats to: #bd.
	performanceRecorder freq: 138 bpm.
	performanceRecorder playFor: 4 bars.

	replayer getScriptWithTime: performanceRecorder savedPerformance.
	" The size of performanceScript is 6 because of the added line of Performance & Performer"
	self assert: replayer performanceScript size equals: 6.

	self
		assert: (replayer performanceScript at: 4)
		equals: '"#At ' , DateAndTime now asTime print24 asString , ' :"
16 upbeats to: #bd.
'.
	self
		assert: (replayer performanceScript at: 5)
		equals: '"#At ' , DateAndTime now asTime print24 asString , ' :"
p freq: 138 bpm.
'.
	self
		assert: (replayer performanceScript at: 6)
		equals: '"#At ' , DateAndTime now asTime print24 asString , ' :"
p playFor: 4 bars.
'
]

{ #category : 'tests' }
SavedPerformanceTest >> testTimes [

	performanceRecorder freq: 138 bpm.
	16 upbeats to: #bd.
	16 downbeats to: #bass3.
	performanceRecorder savedPerformance collectionOfCommands
		with: performanceRecorder savedPerformance times
		do: [ :x :y | self assert: x time asTime equals: y ]
]

{ #category : 'tests' }
SavedPerformanceTest >> testTwoSimpleRhythmsInARowNotCatchedAsDoubleRhythmes [

	16 upbeats.
	16 downbeats to: #bd.

	self
		denyEmpty: self commands;
		assert: self commands allButLast last print equals: '16 upbeats.';
		assert: self commands last print equals: '16 downbeats to: #bd.'
]

{ #category : 'tests' }
SavedPerformanceTest >> testVisitCommandScript [

	16 upbeats to: #bd.

	self
		assert: self commands last print
		equals:
			(performanceRecorder savedPerformance visitCommandScript:
				 self commands last)
]

{ #category : 'tests' }
SavedPerformanceTest >> testVisitCommandTime [

	16 upbeats to: #bd.

	self
		assert: self commands last time asTime
		equals:
			(performanceRecorder savedPerformance visitCommandTime:
				 self commands last)
]
