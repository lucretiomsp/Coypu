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
		'trigs'
	],
	#category : #LiveCoding
}

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

{ #category : #accessing }
Sequencer2 >> trigs [

	^ trigs
]
