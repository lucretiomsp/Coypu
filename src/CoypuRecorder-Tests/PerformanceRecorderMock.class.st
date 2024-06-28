Class {
	#name : 'PerformanceRecorderMock',
	#superclass : 'PerformanceRecorder',
	#type : 'variable',
	#category : 'CoypuRecorder-Tests-Tests',
	#package : 'CoypuRecorder-Tests',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
PerformanceRecorderMock >> playFor: aNumberOfSteps [

	savedPerformance add: (RecordedInstructionCommand new instruction:
			 'playFor: ' , (aNumberOfSteps / 16) asString , ' bars.').


]
