"
A mock of RecorderPlayground used to do tests
"
Class {
	#name : 'RecorderPlaygroundMock',
	#superclass : 'RecorderPlayground',
	#instVars : [
		'lastButtonPressed'
	],
	#category : 'CoypuRecorder_Graphics-Tests',
	#package : 'CoypuRecorder_Graphics-Tests'
}

{ #category : 'accessing' }
RecorderPlaygroundMock >> lastButtonPressed [

^lastButtonPressed 
	
]

{ #category : 'actions' }
RecorderPlaygroundMock >> load [

	lastButtonPressed := 'load'
]

{ #category : 'actions' }
RecorderPlaygroundMock >> play [

lastButtonPressed := 'play'


]

{ #category : 'actions' }
RecorderPlaygroundMock >> save [

	lastButtonPressed := 'save'
]

{ #category : 'actions' }
RecorderPlaygroundMock >> stop [

	lastButtonPressed := 'stop'
]
