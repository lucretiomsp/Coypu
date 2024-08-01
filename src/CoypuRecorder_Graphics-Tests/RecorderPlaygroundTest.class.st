Class {
	#name : 'RecorderPlaygroundTest',
	#superclass : 'TestCase',
	#instVars : [
		'recorderPlayground'
	],
	#category : 'CoypuRecorder_Graphics-Tests',
	#package : 'CoypuRecorder_Graphics-Tests'
}

{ #category : 'tests' }
RecorderPlaygroundTest >> filePath [

	| x |
	x := FileLocator home / 'Documents'.
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	^ x
]

{ #category : 'running' }
RecorderPlaygroundTest >> setUp [

	super setUp.

	recorderPlayground := RecorderPlaygroundMock new
]

{ #category : 'tests' }
RecorderPlaygroundTest >> testLoadButton [
	self assert: recorderPlayground lastButtonPressed equals: nil.

	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 3).
	self assert: recorderPlayground lastButtonPressed equals: 'load'.
]

{ #category : 'tests' }
RecorderPlaygroundTest >> testPlayButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 1).
	self assert: recorderPlayground lastButtonPressed equals: 'play'
]

{ #category : 'tests' }
RecorderPlaygroundTest >> testSaveButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 4) .
	self assert: recorderPlayground lastButtonPressed equals: 'save'
]

{ #category : 'tests' }
RecorderPlaygroundTest >> testStopButton [

	self assert: recorderPlayground lastButtonPressed equals: nil.
	BlSpace simulateClickOn: (recorderPlayground toolBar children at: 2).
	self assert: recorderPlayground lastButtonPressed equals: 'stop'
]
