"
I represent an instrument created during a performance.
## For the Responsibility part:

I have a rythm attributed.
I can print myself as a line of code in a String.
I have a Symbol which represent the instrument used.
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
(RecordedInstrumentCommand new)
		 								rythm: '16 upbeats';
										symbol: '#bd'
```

Internal Representation and Key Implementation Points.

    Instance Variables
	delay:		<integer> delay between the last RecordedCommand and me.
	time:		<DateAndTime> date and time of my creation.
	rythm: <String> rythm of the instrument.
	symbol: <String> name of the instrument in the superDirt library.


"
Class {
	#name : #RecordedInstrumentCommand,
	#superclass : #RecordedCommand,
	#type : #variable,
	#instVars : [
		'dirtNotes',
		'rythm',
		'symbol',
		'notes'
	],
	#category : #'CoypuRecorder-RecordedCommand'
}

{ #category : #accessing }
RecordedInstrumentCommand >> dirtNotes [

^	dirtNotes
]

{ #category : #accessing }
RecordedInstrumentCommand >> dirtNotes: aDirtNotes [

dirtNotes := aDirtNotes
]

{ #category : #testing }
RecordedInstrumentCommand >> isRecordedInstructionCommand [

	^ false
]

{ #category : #testing }
RecordedInstrumentCommand >> isRecordedInstrumentCommand [

^true
]

{ #category : #accessing }
RecordedInstrumentCommand >> notes [

^notes 
]

{ #category : #accessing }
RecordedInstrumentCommand >> notes: anArrayOfNotes [

notes := anArrayOfNotes
]

{ #category : #printing }
RecordedInstrumentCommand >> print [
	"Print the command in the same way it has been used in the original performance"

	| m |
	rythm ifNil: [
		delay
			ifNotNil: [
				(symbol includesSubstring: 'onceAtSpeed:')
					ifTrue: [
					^ symbol allButFirst , ' atTime: ' , delay asString , '.' ]
					ifFalse: [
					^ symbol allButFirst , 'AtTime: ' , delay asString , '.' ] ]
			ifNil: [ ^ symbol allButFirst , '.' ] ].
	m := rythm.
	notes ifNotNil: [ m := m , notes ].

	symbol
		ifNotNil: [
			m := m , ' to: #' , symbol asString
			     ,
			     (delay
				      ifNotNil: [ ' atTime: ' , delay asString , '.' ]
				      ifNil: [ '.' ]) ]
		ifNil: [
			delay
				ifNotNil: [
					m := ('' join: m substrings allButLast) , ' delayed: '''
					     , m substrings last asString , ''' atTime: '
					     , delay asString , '.' ]
				ifNil: [ "m := m , (delay ifNotNil: [ 'AtTime: ' , delay asString ]) , '.'"
					m :=m , '.' ] ].

	dirtNotes ifNotNil: [
		m := m allButLast , '; ' , 'dirtNotes: ''' , dirtNotes , '''.' ].
	^ m
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> rhythm [
^rythm 
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> rhythm: aRythm [ 

	rythm := aRythm.

]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> symbol [

	^ symbol 
]

{ #category : #'instance creation' }
RecordedInstrumentCommand >> symbol: aSymbol [


	symbol := aSymbol
]
