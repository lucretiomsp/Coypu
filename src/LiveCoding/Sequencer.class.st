"
A Sequencer contains gates, notes, duration and a noteIndex. extra1 and extra2 controls can be added.
The Sequencer is the basi unit to play a Performance.
It is conceived as a Digital Audio Workstation track.
"
Class {
	#name : #Sequencer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'seqKey',
		'extra1String',
		'extra2String',
		'extra1',
		'extra2',
		'notes',
		'durations',
		'noteIndex',
		'gates',
		'visualGroup'
	],
	#category : #'LiveCoding-Sequencers'
}

{ #category : #combination }
Sequencer >> , anotherSequencer [

	"combine the gates of two sequencers, returns an array"

	| newGates newNotes newDurations notes1 notes2 |
	notes1 := self notes.
	notes2 := anotherSequencer notes.
	newGates := self gates , anotherSequencer gates.
	newDurations := self durations , anotherSequencer durations.
	newNotes := notes1 , notes2.
	^ self class new
		  gates: newGates;
		  notes: newNotes;
		  durations: newDurations;
		  noteIndex: 0
]

{ #category : #comparing }
Sequencer >> < anotherArray [
"same as and: but binary!"
" add array of  extravalues to the Sequencer
the first element of the array should be a string - for example 'Index'' - the second element o the array should be an array of numbers - for xample #( 1 2 3)
"
^ Sequencer with: (self at: 1) with: (self at: 2) with: (self at: 3) with: (self at: 4) with: anotherArray .

]

{ #category : #'as yet unclassified' }
Sequencer >> > anArray [

	" change notes in the sequencer - polysemic binary version of notes:"

	notes := anArray
]

{ #category : #modifying }
Sequencer >> allNotes: anInteger [

	"fill sequencer notes with anArray with all equals notenumbers"

	| newNotes |
	newNotes := Array new: self numberOfGates.
	1 to: newNotes size do: [ :i | newNotes at: i put: anInteger ].
	self notes: newNotes.
]

{ #category : #controlling }
Sequencer >> and: anArray and: anotherArray and: aThirdArray [
" add array of  extravalues to the Sequencer
the first element of both arrays should be a string - for example 'Index'' if sending out OSC or an integer value corresponding to CC message if sending out MIDI
- the second element o the array should be an array of numbers - for example #( 1 2 3)
#('Cutoff' #(34 56 78)
"
| seq |
seq := Sequencer new: 7.


(1 to: 4) do:
[:i | seq at: i put: (self at: i)].
seq at: 5 put: anArray.
seq at: 6 put: anotherArray .
seq at: 7 put: aThirdArray.

^ seq.

]

{ #category : #accessing }
Sequencer >> duration [

	^ self durations at: (self noteIndex modulo: self durationsSize)
]

{ #category : #accessing }
Sequencer >> durations [

^ durations
]

{ #category : #accessing }
Sequencer >> durations: anArray [

durations := anArray .
]

{ #category : #accessing }
Sequencer >> durationsSize [

	^ durations size
]

{ #category : #accessing }
Sequencer >> extra1 [

	" returns extra1 if it is defined, otherwise returns a dummy array"

	^ extra1
]

{ #category : #accessing }
Sequencer >> extra1: anArrayWithStringAndArray [

"example #('cutoff' #(99 111 87 56))"
extra1 := anArrayWithStringAndArray .
]

{ #category : #accessing }
Sequencer >> extra1Size [

"return the size of the array of values for extra1"
| values |
values := extra1 at: 2.
	^ extra1 notNil
		  ifTrue: [ ^ values size ]
		  ifFalse: [ ^ 1 ]
]

{ #category : #accessing }
Sequencer >> extra1String: aString [
"allows the definition of extra1 sufffix"
extra1String := aString.
]

{ #category : #accessing }
Sequencer >> extra2 [

	" returns extra1 if it is defined, otherwise returns a dummy array"

	^ extra2
]

{ #category : #accessing }
Sequencer >> extra2: anArrayWithStringAndArray [

	"example #('cutoff' #(99 111 87 56))"

	extra2 := anArrayWithStringAndArray
]

{ #category : #accessing }
Sequencer >> extra2Size [

		"return the size of the array of values for extra2"

	| values |
	values := extra1 at: 2.
	^ extra1 notNil
		  ifTrue: [ ^ values size ]
		  ifFalse: [ ^ 1 ]
]

{ #category : #accessing }
Sequencer >> extra2String: aString [
"allows the definition of extra1 sufffix"
extra2String := aString.
]

{ #category : #accessing }
Sequencer >> gates [

	^ gates
]

{ #category : #modifying }
Sequencer >> gates: aRhythm [

	"change the rhythm inside the sequencer"

	gates := aRhythm
]

{ #category : #accessing }
Sequencer >> gatesSize [

	^ gates size
]

{ #category : #testing }
Sequencer >> isSequencer [

^ true
]

{ #category : #accessing }
Sequencer >> note [

	^ self notes at: (self noteIndex modulo: self notesSize)
]

{ #category : #accessing }
Sequencer >> noteIndex [

	" returns the fourth array of the sequencer if there is one, otherwise returns 0.
noteIndex is used to play the folloowing note in the array. Only if there is a trig in the gates the noteIndex  will be incremented"

^ noteIndex
]

{ #category : #accessing }
Sequencer >> noteIndex: anInteger [

	" returns the fourth array of the sequencer if there is one, otherwise returns 0.
noteIndex is used to play the folloowing note in the array. Only if there is a trig in the gates the noteIndex  will be incremented"

noteIndex := anInteger
]

{ #category : #accessing }
Sequencer >> notes [

	^ notes
]

{ #category : #modifying }
Sequencer >> notes: anArray [

	" change notes in the sequencer"

	notes := anArray
]

{ #category : #'as yet unclassified' }
Sequencer >> notes: anArrayOfNotes durs: anArrayOfDurations [
" change notes in the sequencer"
^ (Sequencer with: (self at: 1) with: anArrayOfNotes with: anArrayOfDurations  with: 0).
]

{ #category : #accessing }
Sequencer >> notesSize [

	^ notes size
]

{ #category : #counting }
Sequencer >> numberOfGates [ 

"return number of elements in the Sequencer gates array that are greater than 0"
| result size |
result := (self gates) select: [ :i | i > 0 ].
size := result size.
^ size
]

{ #category : #accessing }
Sequencer >> offset: aNumber [

	"offset the rhythm inside the sequencerby aNumber of 'steps' wrapping it around its size"

	| rhythm melody |
	rhythm := self gates.
	melody := self notes.
	self gates: (rhythm offset: aNumber).
	self notes: (melody offset: aNumber)
]

{ #category : #progressions }
Sequencer >> progression: anArrayOfIntervals [

	"return a new Sequencer that join together the original sequencer with as many transpositions of self  for as many intervals in anArrayOfIntervals"

	| oldSeq newSeq |
	oldSeq := self.
	newSeq := self.
	(1 to: anArrayOfIntervals size) do: [ :i | 
		newSeq := newSeq , (oldSeq transpose: (anArrayOfIntervals at: i)) ].
	^ newSeq
]

{ #category : #'as yet unclassified' }
Sequencer >> randomCounterPoint [

	" creates aSequencer of trigs randomly counterpointed with self array"

	| newArray |
	newArray := Array new: self gates size.
	1 to: self gates size do: [ :i | 
		(self gates at: i) = 1
			ifTrue: [ newArray at: i put: 0 ]
			ifFalse: [ newArray at: i put: Random new nextTrig ] ].
	^ newArray asSeq
]

{ #category : #accessing }
Sequencer >> seqKey [
^seqKey
]

{ #category : #accessing }
Sequencer >> stepIndex [

	self at: 4 put: self noteIndex + 1
]

{ #category : #replication }
Sequencer >> times: anInteger [

	"returns a sequencer containing anInteger repetition of self"

	| newGates newNotes newDurations |
	newGates := (self gates times: anInteger) asRhythm.
	newNotes := self notes times: anInteger.
	newDurations := self durations times: anInteger.



	^ Sequencer new
		  gates: newGates;
		  notes: newNotes;
		  durations: newDurations;
		  noteIndex: 0
]

{ #category : #'as yet unclassified' }
Sequencer >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : #accessing }
Sequencer >> to: aSymbol with: anArray [

^ 'cicisbeo'

]

{ #category : #modifying }
Sequencer >> transpose: aNumberOfSemitones [

	| melody |
	melody := self notes.
	^ self class new
		  gates: self gates;
		  notes: melody + aNumberOfSemitones;
		  durations: self durations;
		  noteIndex: self noteIndex 
]

{ #category : #'as yet unclassified' }
Sequencer >> trigs [
"return the number of trigs, i.e. gates = 1,  of the sequencer"
| result |
result := 0.
(1 to: (self gates size)) do: [ :i | ((self gates at: i) = 1) ifTrue: [result := result + 1] ifFalse: [ nil]].
^ result.
]

{ #category : #'as yet unclassified' }
Sequencer >> visualGroup [

	^ visualGroup
]

{ #category : #'as yet unclassified' }
Sequencer >> visualGroup: aRSGroup [

	visualGroup := aRSGroup
]

{ #category : #visualization }
Sequencer >> visualizeOn: aRSCanvas [

	"visualize the sequencer on a Roassal canvas"

	| nIndex color red green blue border layout gatesSize minimumRadius |
	nIndex := 0. " to represent noteNumber"
	minimumRadius := self gates size.
	color := Color random.
	gatesSize := 40.
	border := red := Random new nextInteger: 255.
	green := Random new nextInteger: 255.
	blue := Random new nextInteger: 255.
	border := RSBorder new color: (Color r: red g: green b: blue).
	visualGroup := RSGroup new.
	self gates do: [ :g | 
		nIndex := nIndex + 1.
		visualGroup add: (RSCircle new
				 size:
					 3.1 * (80 - (self notes at: (nIndex modulo: self notesSize)));
				 border: border;
		
				 color: color * g) ].
	layout := RSCircleLayout new
		          radius:
			          (Random new
				           nextIntegerBetween: minimumRadius * 2 + 50
				           and: 400);
		          initialAngleInDegree: 270.
	layout on: visualGroup.
	visualGroup translateTo: 0 @ 0.
	aRSCanvas add: visualGroup asShape.
	aRSCanvas signalUpdate
]

{ #category : #random }
Sequencer >> withRandomNotesFrom: anArray root: aRootNote octaves: aNumber [

	"return an array of self size of a random note from anArray of note numbers with root aRootNote, and aNumber octave range"

	| intervals melody |
	intervals := (1 to: self numberOfGates) collect: [ :i | 
		             (anArray at: (Random new nextInteger: anArray size))
		             + ((Random new nextInteger: aNumber + 1) - 1 * 12) ].
	melody := intervals + aRootNote.
	self notes: melody.
	
]
