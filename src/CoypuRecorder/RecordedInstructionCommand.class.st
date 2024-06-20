"
I represent a message given to the performance recorder during a performance.
## For the Responsibility part:

I can print myself as a line of code in a String.
I have an order which represent the message used.
I can have an instance variable ""delay"" which is the number of seconds between the execution of the last command and me.

## For the Collaborators Part: 

Stored in an orderedCollection which is a variable of SavedPerformance.
Visited by a SavedPerformance.

## Public API and Key Messages

- print : print myself as a line of code.
- getPrint : visited by a SavedPerformance to get my print.
- getTime : visited by a SavedPerformance to get my time.

### Example of creation of an instance :
```
(RecordedOrderCommand new) order: 'freq: 138 bpm.';

```

Internal Representation and Key Implementation Points.

    Instance Variables
	delay:		<integer> delay between the last RecordedCommand and me.
	time:		<DateAndTime> date and time of my creation.
	order: <String> message sent to the PerformanceRecorder.


"
Class {
	#name : #RecordedInstructionCommand,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'order'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

{ #category : #testing }
RecordedInstructionCommand >> isRecordedInstructionCommand [

	^ true
]

{ #category : #testing }
RecordedInstructionCommand >> isRecordedInstrumentCommand [

	^ false
]

{ #category : #accessing }
RecordedInstructionCommand >> order [

	^order
]

{ #category : #accessing }
RecordedInstructionCommand >> order: anOrder [

order := anOrder
]

{ #category : #printing }
RecordedInstructionCommand >> print [
"Print the command into the same way it has been used in the original performance"
	| p |
	p := 'p ' , self order asString.
	delay ifNotNil: [
		p := (p includesSubstring: ':')
			     ifFalse: [ p allButLast , 'AtTime: ' , delay asString , '.' ]
			     ifTrue: [ p allButLast , ' atTime: ' , delay asString , '.' ] ].
	^ p
]
