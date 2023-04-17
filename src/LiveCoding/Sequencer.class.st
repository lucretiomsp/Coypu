"
A Sequencer contains gates, notes, duration and a noteIndex. extra1 and extra2 controls can be added.
A Sequencer can contain a MIDI channel, as intended to play it on A performance to a MIDI sender
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
		'midiChannel',
		'visualGroup',
		'cycleDurations',
		'chords',
		'soundPattern',
		'samplesIndex'
	],
	#category : #'LiveCoding-Sequencers'
}

{ #category : #combination }
Sequencer >> , anotherSequencer [

	"combine the gates of two sequencers, returns a sequencer"

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

	"same as extra1 but binary!"

	" add array of  extravalues to the Sequencer
the first element of the array should be a string - for example 'Index'' - the second element o the array should be an array of numbers - for xample #( 1 2 3)
"

	^ self extra1: anotherArray 
]

{ #category : #comparing }
Sequencer >> = anotherSequencer [ 
" equality between sequencers"
((self notes = anotherSequencer notes) & (self gates = anotherSequencer gates) & (self durations = anotherSequencer durations) & (self extra1 = anotherSequencer extra1) & (self extra2 = anotherSequencer extra2)) ifTrue: [ ^ true ] ifFalse: [ ^ false ]
]

{ #category : #addNotesToGates }
Sequencer >> > anArrayOfNotesOrANote [

	" change notes in the sequencer - polysemic binary version of notes:"
   anArrayOfNotesOrANote isArray ifTrue:
	[notes := anArrayOfNotesOrANote] ifFalse: [ notes := Array new: self numberOfTrigs  withAll: anArrayOfNotesOrANote  ]
]

{ #category : #modifying }
Sequencer >> allNotes: anInteger [

	"fill sequencer notes with anArray with all equals notenumbers"

	| newNotes |
	newNotes := Array new: self numberOfGates.
	1 to: newNotes size do: [ :i | newNotes at: i put: anInteger ].
	self notes: newNotes.
]

{ #category : #accessing }
Sequencer >> chords [

	^ chords
]

{ #category : #accessing }
Sequencer >> chords: anArrayOfChords [
" for example #('maj' 'min' 'sus4' 'min7')"

	chords := anArrayOfChords 
]

{ #category : #'sequencer - cycles' }
Sequencer >> cycleDurations [
" return the duration of each event in the cycle"
	^ cycleDurations
]

{ #category : #'sequencer - cycles' }
Sequencer >> cycleDurations: anArrayOfFractions [

cycleDurations := anArrayOfFractions 
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

	
		  extra1 := anArrayWithStringAndArray
]

{ #category : #accessing }
Sequencer >> extra1: aSymbol values: anArrayOfValues [

	"example 
	extra1: #cutoff values: #(300 600 800).
	"

   | x1 |
   x1 := Array with: aSymbol with: anArrayOfValues .
	extra1 := x1
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
	values := extra2 at: 2.
	^ extra1 notNil
		  ifTrue: [ ^ values size ]
		  ifFalse: [ ^ 1 ]
]

{ #category : #accessing }
Sequencer >> extra2String: aString [
"allows the definition of extra1 sufffix"
extra2String := aString.
]

{ #category : #'Sequencer - transformation' }
Sequencer >> flip [

	" flip the gates in a Sequener: rests become gates, gates become rests"

	| result |
	result := self gates collect: [ :i | (i ~= 1) asInteger ] .

	^ result asRhythm asSeq.
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

{ #category : #'LiveCoding - sequencer' }
Sequencer >> gatesSize: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
Sequencer >> hasChords [

| result |
result := false.
	self chords isNil
		ifTrue: [ ^ false ]
		ifFalse: [ ^ true ].
		^ result
]

{ #category : #'accessing - sequencer' }
Sequencer >> index [

	^ (self extra1 at: 2)
]

{ #category : #'LiveCoding - sequencer' }
Sequencer >> index: anArrayOfIndexes [ 
	self extra1: #Index values: anArrayOfIndexes 
]

{ #category : #'LiveCoding - performance' }
Sequencer >> index: anArrayOfIndexes to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis to put a sequencer of gates with sample indexes into a performance"
	| p |
	p := Performance uniqueInstance .
	self to: aKeyInPerformance .
	aKeyInPerformance indexes: anArrayOfIndexes 
]

{ #category : #testing }
Sequencer >> isSequencer [

^ true
]

{ #category : #modifying }
Sequencer >> melodyFrom: aScale [

	| array |
	array := self numberOfGates randomNotesFrom: aScale.
	array at: 1 put: (aScale at: 1).
	2 to: array size do: [ :i | 
		((array at: i) rem: 12) = 0 ifTrue: [ 
			array at: i - 1 put: (aScale at: 6) ].
		((array at: i) rem: 12) = 2 ifTrue: [ 
			array at: i - 1 put: (aScale at: 5) ] ].
	"last note is mediante or dominante"
	^ self notes: array
]

{ #category : #accessing }
Sequencer >> midiChannel [ 

^ midiChannel 
]

{ #category : #accessing }
Sequencer >> midiChannel: anIntegerBetween1And16 [

	midiChannel := anIntegerBetween1And16 
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
Sequencer >> notes: anArrayOfNotesOrANote [

	" change notes in the sequencer"

	anArrayOfNotesOrANote isArray
		ifTrue: [ notes := anArrayOfNotesOrANote ]
		ifFalse: [ 
			notes := Array
				         new: self numberOfTrigs
				         withAll: anArrayOfNotesOrANote ]
]

{ #category : #'as yet unclassified' }
Sequencer >> notes: anArrayOfNotes durs: anArrayOfDurations [
" change notes in the sequencer"
^ (Sequencer with: (self at: 1) with: anArrayOfNotes with: anArrayOfDurations  with: 0).
]

{ #category : #'LiveCoding - performance' }
Sequencer >> notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis while declaring a sequencer of gates with its notes and its sample indexes"
	| p |
	p := Performance uniqueInstance .
	self to: aKeyInPerformance .
	aKeyInPerformance notes: anArrayOfNotes .
	aKeyInPerformance indexes: anArrayOfIndexes 
]

{ #category : #'LiveCoding - sequencer' }
Sequencer >> notes: anArrayOfNotes to: aKeyInThePerformance [
	" convenience method to fill keys in performance without using too many parenthesis"
	| p |
	p := Performance uniqueInstance .
	self to: aKeyInThePerformance .
	aKeyInThePerformance notes: anArrayOfNotes  
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

{ #category : #counting }
Sequencer >> numberOfTrigs [

	"return number of elements in the Sequencer gates array that are greater than 0"

	| result size |
	result := self gates select: [ :i | i > 0 ].
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

{ #category : #'sequencer - cycles' }
Sequencer >> playAsCycle [

]

{ #category : #'sequencer - cycles' }
Sequencer >> playAsCycle: aNumberOfCycles on: aMIDISender [

	"playMIDISequenceAt: aRateInSeconds steps: aNumberOfSteps on: aMIDISender"

	"test"

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through athe Performance containing arrays of numbers as values
keys in the Performance represents MIDI channels and must be written as #ch1 #ch2 #ch3 and so on if you want to send noteOn/off or

if you want to send out ccs
"

	| step gateTime |
	"as in early hardware sequencers, default gatetime is 80% of the step duration"
	gateTime := 0. "we dont use it for now"
	step := 0.


	^ [ 
	  aNumberOfCycles timesRepeat: [ 
		  (Delay forSeconds: (Cycle duration)
			   * (self cycleDurations at: (step modulo: self cycleDurations size)))
			  wait.

		  " test if dictionary values is an Array of two arrays or as defined, a sequence"


		  (self gates at: (step modulo: self gatesSize)) = 1 ifTrue: [ 
			  aMIDISender
				  playDrum:
				  (self notes at: (self noteIndex modulo: self notesSize))
				  onChannel: self midiChannel.
			  "advance"
			  self noteIndex: self noteIndex + 1 ].


		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : #'sequencer - playing' }
Sequencer >> playBasicDirtEventAt: anIndex [

	"convenience method to play single events inside a Sequencer / it is possible to select only sound and index"

	| index sound message |
	index := (self samplesIndex wrap: anIndex) asFloat.
	sound := self soundPattern wrap: anIndex.


	(OSCMessage for: { 
			           '/dirt/play'.
			           '_id '.
			           '4'.
			           'cps'.
			           0.56.
			           'cycle'.
			           71.00.
			           'delta'.
			           0.89.
			           'n'.
			           index.
			           'orbit'.
			           5.0.
			           's'.
			           sound })


		sendToAddressString: '127.0.0.1'
		port: 57120.
	^ true
]

{ #category : #'sequencer - playing' }
Sequencer >> playToDirt: aNumberOfSteps rate: aRateInSeconds [

	"play the sequencer to the SuperDirt/SuperCollider synth engine"

	| process step |
	step := 1.

	process := [ 
	           aNumberOfSteps timesRepeat: [ 
		           (Delay forSeconds: aRateInSeconds) wait.
		           (self gates wrap: step) = 1
			           ifTrue: [ 
				           self playBasicDirtEventAt: self noteIndex.
				           "increment note Index"
				           self noteIndex: self noteIndex + 1 ]
			           ifFalse: [ nil ].

		           "step is incremented anyway"
		           step := step + 1 ] ] forkAt: Processor timingPriority.

	^ process
]

{ #category : #printing }
Sequencer >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' with gates: '.
	aStream print: gates.
	aStream nextPutAll: ' with notes: '.
	aStream print: notes.
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
Sequencer >> samplesIndex [

	^ samplesIndex
]

{ #category : #accessing }
Sequencer >> samplesIndex: anArrayOfIntegers [

	samplesIndex := anArrayOfIntegers 
]

{ #category : #accessing }
Sequencer >> seqKey [
^seqKey
]

{ #category : #counting }
Sequencer >> size [

	"polysemic version of numberOfTrigs method!!!!. return the number of elements in the Sequencer gates array that are greater than 0"

	| result size |
	result := self gates select: [ :i | i > 0 ].
	size := result size.
	^ size
]

{ #category : #accessing }
Sequencer >> soundPattern [

	^ soundPattern
]

{ #category : #accessing }
Sequencer >> soundPattern: anArrayOfStrings [

	soundPattern := anArrayOfStrings 
]

{ #category : #accessing }
Sequencer >> sounds: aStringForDirt [

	| soundsAndIndexs sounds indexes |
	soundsAndIndexs := aStringForDirt findBetweenSubstrings: ' '.
	sounds := OrderedCollection new.
	(1 to: soundsAndIndexs size) do: [ :i | 
		sounds add:
			(((soundsAndIndexs at: i) findBetweenSubstrings: ':') at: 1) ].
	indexes := OrderedCollection new.
	(1 to: soundsAndIndexs size) do: [ :i | 
		((soundsAndIndexs at: i) findBetweenSubstrings: ':') size > 1
			ifTrue: [ 
				indexes add:
					(((soundsAndIndexs at: i) findBetweenSubstrings: ':') at: 2)
						asInteger ]
			ifFalse: [ indexes add: 0 ] ].

	self
		soundPattern: sounds asArray ;
		samplesIndex: indexes asArray .
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

{ #category : #'sequencer creation' }
Sequencer >> to: aSymbol [

	"put the sequencer into the active Performance at Symbol as key"

	Performance uniqueInstance at: aSymbol put: self
]

{ #category : #addToPerformance }
Sequencer >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : #printing }
Sequencer >> trace [

gates traceCr .
notes traceCr.
durations traceCr.
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

{ #category : #random }
Sequencer >> withRandomNotesMin: anInteger max: anotherInteger [

	"return an array of self size of a random note from anArray of note numbers with root aRootNote, and aNumber octave range"

	| newNotes |
	newNotes := (1 to: self numberOfGates ) collect: [ :i | 
		            (Random new nextInteger: anotherInteger - anInteger)
		            + anInteger ].
	^ self notes: newNotes
]
