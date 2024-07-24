"
##Class
I represent a saved performance of a PerformanceRecorder.

## Responsibility :

Create and store the RecordedCommand called by the PerformanceRecorder.
Visited by the replayer to give them the scripts of the RecordedCommands i store.
Calcul the time of each commands in multiple ways.

## Collaborators:
Instance variable of Performance Recorder.
RecordedCommands in an OrderedCollection, collectionOfCommands.
Visited by replayer to get the scripts of the RecordedCommands.

## Key Messages :

- addInstrument, lastDirtNotes, lastSymbol : used to create a RecordedPerformance
- script[...]forReplayer : used to give the script to the replayer that's visiting
- absoluteTo... : Used to calculate alternative times.

### Example for creating an instance :

```
SavedPerformance new
```

## Internal Representation :

    Instance Variables
	collectionOfCommands:		<OrderedCollection> collection where the RecordedCommands are stored.
			


"
Class {
	#name : 'SavedPerformance',
	#superclass : 'Object',
	#instVars : [
		'collectionOfCommands',
		'doubleRhythms'
	],
	#category : 'CoypuRecorder-savedPerformance',
	#package : 'CoypuRecorder',
	#tag : 'savedPerformance'
}

{ #category : 'calculating' }
SavedPerformance >> absoluteToDelay [
	"Take the time of each commands and return an OrderedCollection with the delay between each of them"

	| delays times |
	times := self times.
	delays := OrderedCollection new.
	collectionOfCommands ifNotEmpty: [ delays addFirst: 0 ].
	1 to: times size - 1 do: [ :i |
		delays add:
			(times at: i + 1) asMilliSeconds - (times at: i) asMilliSeconds
			- (((times at: i + 1) asMilliSeconds - (times at: i) asMilliSeconds)
			% 10) ].

	^ delays
]

{ #category : 'calculating' }
SavedPerformance >> absoluteToRelative [
	"Take the time of each commands and return an OrderedCollection with the relative time from the start of the performance for each of them"

	| times |
	times := self times.
	^ times collect: [ :each |
		  ((each asMilliSeconds - times first asMilliSeconds) - ((each asMilliSeconds - times first asMilliSeconds) % 10)) asString ]
]

{ #category : 'adding' }
SavedPerformance >> add: anObject [

	collectionOfCommands add: anObject
]

{ #category : 'adding' }
SavedPerformance >> addInstrument: anAnnouncement [
	"Add a new RecordedInstrumentCommand in the collectionOfCommands. This message is called when a RythmAnnouncement is announced"

	collectionOfCommands add:
		(RecordedInstrumentCommand new rhythm: anAnnouncement rhythm)
]

{ #category : 'calculating' }
SavedPerformance >> appliesDelay: anAnnouncement [
	" Add the seconds of the delay to the time of the last RecordedCommands
Only called when recording a replay of a Performance."

	collectionOfCommands last time:
		(collectionOfCommands last time asTime addMilliSeconds: anAnnouncement delay).
]

{ #category : 'as yet unclassified' }
SavedPerformance >> appliesExtraValues: anAnnouncement [

collectionOfCommands last extraValues: anAnnouncement extraValues
]

{ #category : 'calculating' }
SavedPerformance >> appliesNotes: anAnnouncement [
	" Add the seconds of the delay to the time of the last RecordedCommands
Only called when recording a replay of a Performance."

	collectionOfCommands last notes: anAnnouncement notes.
]

{ #category : 'visiting' }
SavedPerformance >> bodyScripts [
	"Visit every commands in the collectionOfCommands and return a collection of their scripts"

	| scripts |
	scripts := collectionOfCommands collect: [ :each |
		           self visitCommandScript: each ].

	^ scripts
]

{ #category : 'accessing' }
SavedPerformance >> collectionOfCommands [
^	collectionOfCommands
]

{ #category : 'adding' }
SavedPerformance >> collectionOfCommands: anOrderedCollection [

collectionOfCommands := anOrderedCollection 
]

{ #category : 'adding' }
SavedPerformance >> doubleRhythmsAnnounced [
| x y |
					x := collectionOfCommands allButLast last rhythm , ', '
					     , collectionOfCommands last rhythm.
					y := collectionOfCommands last symbol.
					self collectionOfCommands: collectionOfCommands allButLast.
					collectionOfCommands last
						rhythm: x;
						symbol: y
]

{ #category : 'visiting' }
SavedPerformance >> getCommandScript: aString [

^ aString 
]

{ #category : 'visiting' }
SavedPerformance >> getCommandTime: aString [

^ aString
]

{ #category : 'accessing' }
SavedPerformance >> header: aScript [

	aScript addFirst:
		'p := PerformanceRecorder uniqueInstance.' , String cr;
	addFirst: '|p|',String cr.
	^ aScript
]

{ #category : 'initialization' }
SavedPerformance >> initialize [

	collectionOfCommands := OrderedCollection new.
	doubleRhythms := false
]

{ #category : 'adding' }
SavedPerformance >> lastDirtNotes: anAnnouncement [
	"add to the last RecordedInstrumentCommand dirtNotes.
This message is called when a DirtNotesAnnouncement is announced."
	collectionOfCommands last dirtNotes: anAnnouncement newDirtNotes
]

{ #category : 'adding' }
SavedPerformance >> lastSymbol: anAnnouncement [
	"add to the last RecordedInstrumentCommand a Symbol.
This message is called when a SymbolAnnouncement is announced."



			(anAnnouncement symbol includesSubstring: 'once')
				ifTrue: [
					collectionOfCommands add:
						(RecordedInstrumentCommand new symbol: anAnnouncement symbol) ]
				ifFalse: [
				collectionOfCommands last symbol: anAnnouncement symbol ] 
]

{ #category : 'visitors' }
SavedPerformance >> scriptForReplayer: aReplayer [
	"Give a script of every commands in collectionOfCommands to the replayer visiting"

	aReplayer performanceScript:
		((self header:self bodyScripts) collect: [ :each | each , String cr ])
]

{ #category : 'visitors' }
SavedPerformance >> scriptWithDelayTimeForReplayer: aReplayer [
	"Give a script of every command with the delay between each of them in collectionOfCommands to the replayer visiting"

	| delay |
	delay := self absoluteToDelay.

	collectionOfCommands with: delay do: [ :each :d | each delay: d ].
	aReplayer performanceScript:
		((self header:self bodyScripts) collect: [ :each | each , String cr ])
]

{ #category : 'visitors' }
SavedPerformance >> scriptWithRelativeTimeForReplayer: aReplayer [
	"Give a script of every command with their relative time in collectionOfCommands to the replayer visiting"

	| scripts relativetimes |
	relativetimes := self absoluteToRelative.
	scripts := self bodyScripts
		           with: relativetimes
		           collect: [ :each :time |
			           '"//At ' , time
			           , ' milliseconds\\"' , String cr , each ].
	scripts := self header: scripts.
	aReplayer performanceScript:
		(scripts collect: [ :each | each , String cr ])
]

{ #category : 'visitors' }
SavedPerformance >> scriptWithTimeForReplayer: aDisplayer [
	"Give a script of every command with their time in collectionOfCommands to the replayer visiting"

	| scripts |
	scripts := self bodyScripts
		           with: self times
		           collect: [ :each :times |
		           '"#At ' , times print24 , ' :"' , String cr , each ].
	self header: scripts.
	aDisplayer performanceScript:
		(scripts collect: [ :each | each , String cr ])
]

{ #category : 'visiting' }
SavedPerformance >> times [
	"Visit every commands in the collectionOfCommands and return a collection of their times"
	^ collectionOfCommands collect: [ :each |
		  self visitCommandTime: each ]
]

{ #category : 'visiting' }
SavedPerformance >> visitCommandScript: aRecordedCommand [
" visit a RecordedCommand to get its script"
	^ aRecordedCommand getPrint: self
]

{ #category : 'visiting' }
SavedPerformance >> visitCommandTime: aRecordedCommand [
	" visit a RecordedCommand to get its time"
	^ aRecordedCommand getTime: self
]
