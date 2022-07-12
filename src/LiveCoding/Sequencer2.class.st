"
New sequencer implementation
"
Class {
	#name : #Sequencer2,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'gates',
		'notes',
		'extra1',
		'extra2',
		'gatesSize',
		'notesSize',
		'trigs',
		'durations',
		'index'
	],
	#category : #'LiveCoding-Sequencers'
}

{ #category : #copying }
Sequencer2 >> , anotherSequencer [

	"combine the gates of two sequencers, returns an array"

	| newGates newNotes newDurations notes1 notes2 newSequencer |
	notes1 := self notes.
	notes2 := anotherSequencer notes.
	newGates := self gates , anotherSequencer gates.
	newDurations := self durations , anotherSequencer durations.
	newNotes := notes1 , notes2.

	newSequencer := self class new.
	newSequencer
		notes: newGates;
		gates: newNotes;
		durations: newDurations;
		index: 0
]

{ #category : #comparing }
Sequencer2 >> > anArray [

	" change notes in the sequencer - polysemic binary version of notes:"
| newSequencer |
newSequencer  := self class new.
newSequencer
		  gatesSize:  (self at: 1);
		  notes: anArray;
		  durations: #( 1 );
		  index: 0.
		^ newSequencer 
]

{ #category : #accessing }
Sequencer2 >> durations [

	^ durations
]

{ #category : #accessing }
Sequencer2 >> durations: anArray [

	durations := anArray
]

{ #category : #accessing }
Sequencer2 >> durationsSize [ 
^ self durations size
]

{ #category : #accessing }
Sequencer2 >> extra1 [

	^ extra1
]

{ #category : #accessing }
Sequencer2 >> extra1: anArray [

	extra1 := anArray
]

{ #category : #accessing }
Sequencer2 >> extra2 [

	^ extra2
]

{ #category : #accessing }
Sequencer2 >> extra2: anArray [

	extra2 := anArray
]

{ #category : #accessing }
Sequencer2 >> gates [

	^ gates
]

{ #category : #accessing }
Sequencer2 >> gates: aRhythm [

	gates := aRhythm 
]

{ #category : #accessing }
Sequencer2 >> gatesSize [

	^ gates size
]

{ #category : #accessing }
Sequencer2 >> index [

	^ index
]

{ #category : #accessing }
Sequencer2 >> index: anInteger [
	index := anInteger
]

{ #category : #testing }
Sequencer2 >> isSequencer [ 
^ true
]

{ #category : #accessing }
Sequencer2 >> notes [

	^ notes
]

{ #category : #accessing }
Sequencer2 >> notes: anArray [

	notes := anArray
]

{ #category : #accessing }
Sequencer2 >> notesSize [

	^ notes size
]

{ #category : #'as yet unclassified' }
Sequencer2 >> times: anInteger [

	"returns a sequencer containing anInteger repetition of self"

	| newGates newNotes newDurations newSequencer |
	newGates := (self gates times: anInteger) asRhythm.
	newNotes := self notes times: anInteger.
	newDurations := self durations times: anInteger.

   newSequencer := self class new.

	newSequencer
		 gates: newGates;
		notes: newNotes;
		 durations: newDurations;
		 index: 0.
		^ newSequencer 
]

{ #category : #'as yet unclassified' }
Sequencer2 >> to: aPerformance at: aKey [
"polysemic alternative to add Sequencer to a Performance "
	aPerformance add: aKey -> self
]

{ #category : #accessing }
Sequencer2 >> trigs [

	^ trigs
]
