"
Note : Abstract class

I represent a line of code used during a performance.

## For the Responsibility part:
I have an instance variable which is the time of my creation.
I can print myself as a line of code in a String.
I can have an instance variable ""delay"" which is the number of seconds between the execution of the last command and me.

## For the Collaborators Part: 
Stored in an orderedCollection which is a variable of SavedPerformance.
Visited by a SavedPerformance.

## Public API and Key Messages

- print : print myself as a line of code.
- getPrint : visited by a SavedPerformance to get my print.
- getTime : visited by a SavedPerformance to get my time.

- I'm an abstract class, create an instance of one of my subclasses instead.

## Internal Representation and Key Implementation Points.

    Instance Variables
	delay:		<integer> delay between the last RecordedCommand and me.
	time:		<DateAndTime> date and time of my creation.


"
Class {
	#name : 'RecordedCommand',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'time',
		'delay'
	],
	#category : 'CoypuRecorder-RecordedCommand',
	#package : 'CoypuRecorder',
	#tag : 'RecordedCommand'
}

{ #category : 'accessing' }
RecordedCommand >> delay: aTimeInSeconds [

delay := aTimeInSeconds
]

{ #category : 'visitor - double dispatching' }
RecordedCommand >> getPrint: aSavedPerformance [
"Visited by a SavedPerformance to get my print"
	^ aSavedPerformance getCommandScript: self print
]

{ #category : 'visitor - double dispatching' }
RecordedCommand >> getTime: aSavedPerformance [
	"Visited by a SavedPerformance to get my time"
	^ aSavedPerformance getCommandTime: self time asTime
]

{ #category : 'initialization' }
RecordedCommand >> initialize [

	super initialize.
	time := DateAndTime now asTime 
]

{ #category : 'types' }
RecordedCommand >> isRecordedInstructionCommand [
	^ self subclassResponsibility
]

{ #category : 'types' }
RecordedCommand >> isRecordedInstrumentCommand [
	^ self subclassResponsibility
]

{ #category : 'printing' }
RecordedCommand >> print [

self subclassResponsibility 
]

{ #category : 'accessing' }
RecordedCommand >> time [

^time 
	
]

{ #category : 'accessing' }
RecordedCommand >> time: aDateAndTime [


	time := aDateAndTime 
]
