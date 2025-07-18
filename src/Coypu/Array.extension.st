Extension { #name : 'Array' }

{ #category : '*Coypu' }
Array >> * aNumber [
"returns an Array with all the elements of self multiplicated for aNumber"

| result |
result := ( 1to: (self size)) collect: [ :i | (self at: i) * aNumber ].
^ result
]

{ #category : '*Coypu' }
Array >> + aNumber [ 
" sum aNumber to each element of the array"
| result |
result := (1 to: (self size)) collect: [ :i | (self at: i ) + aNumber ].
^ result
]

{ #category : '*Coypu' }
Array >> - aNumber [ 
" sum aNumber to each element of the array"
| result |
result := (1 to: (self size)) collect: [ :i | (self at: i ) - aNumber ].
^ result
]

{ #category : '*Coypu' }
Array >> > aString [
"experimental"
Transcript show: aString; open.
]

{ #category : '*Coypu' }
Array >> @ anArrayWithARootNoteAndAnOctave [

	| x anIntegerRoot anIntegerOctave |
	anIntegerRoot := anArrayWithARootNoteAndAnOctave at: 1.
	anIntegerOctave := anArrayWithARootNoteAndAnOctave at: 2.
	x := OrderedCollection new.
	(0 to: anIntegerOctave) do: [ :i | 
		x addAll: self + (anIntegerRoot + (i * 12)) ].
	^ x
]

{ #category : '*Coypu' }
Array >> and: anArray [

^ Sequencer with: self with: anArray
]

{ #category : '*Coypu' }
Array >> and: anArray and: anotherArray [

^ Sequencer with: self with: anArray with: anotherArray 
]

{ #category : '*Coypu' }
Array >> arp: anArrayOfIntervals [

	"STILL NOT AT ITS BEST"

	"arpeggiate the notes inside the first array "

	| midResult finalResult restsOrGates restsOrGatesArpSize |
	restsOrGates := self collect: [ :i | (i ~= 0) asInteger ].
	restsOrGatesArpSize := restsOrGates times: anArrayOfIntervals size.
	midResult  := OrderedCollection new.
	finalResult := OrderedCollection new.
	anArrayOfIntervals do: [ :i | midResult addAll: self + i ].
	1 to: (midResult  size) do: [ :i | finalResult add: (midResult at: i) * (restsOrGatesArpSize at: i) ].


	^ finalResult asDirtArray
]

{ #category : '*Coypu' }
Array >> asDirtArray [
	"convenience method to send OSC messages to SuperDirt - the same message sent to a Number converts it into an array with just that number as element"

	^ self
]

{ #category : '*Coypu' }
Array >> asDirtArrayOfValues [
	"convenience method to send values to extra aparmeters of a Sequencer"

	^ self
]

{ #category : '*Coypu' }
Array >> asMonoSeq [

	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"

	"duration now expressed in number of steps"

	| numberOfNotes |
	numberOfNotes := Array new: self trigs withAll: 60.
	^ SequencerMono new
		  gates: self;
		  notes: numberOfNotes;
		  durations: #( 1 );
		  noteIndex: 0
" duration in steps"

]

{ #category : '*Coypu' }
Array >> asNotes [
	"convert an array of MIDI note numbers into a Sequencer where 0 corresponds to rests"

	| seq allTrigs validTrigs validNotes allValues |
	allTrigs := OrderedCollection new.


	allValues := OrderedCollection new.
	self do: [ :i |
		i isArray
			ifTrue: [
				allTrigs addAll: i.
				allValues addAll: i ]
			ifFalse: [
				allTrigs add: i.
				allValues add: i ] ].
	validTrigs := allTrigs collect: [ :i | i isZero not asInteger ].

	validNotes := allValues reject: [ :i | i = 0 ].
	seq := validTrigs asDirtArray asSeq notes: validNotes asDirtArray.

	^ seq
]

{ #category : '*Coypu' }
Array >> asRhythm [
" convert Array into a Rhythm"
| rhythm |
rhythm := Rhythm new: (self size).
(1 to: ( self size)) do: [ :i | rhythm at: i put: (self at: i) ].
^ rhythm
]

{ #category : '*Coypu' }
Array >> asSeq [
	"returns Sequencer with default note 60nn and default durations = self size / numberOfTrigs and noteIndex = 0"

	| numberOfNotes dur seq gts |
	numberOfNotes := self class new: self trigs withAll: 60.
	"all notes last 1 step by default"
	dur := self class new: self trigs withAll: 1.

	"with an 80% gate Time"
	gts := self class new: self trigs withAll: 0.8.
	seq := SequencerMono new
		       gates: self;
		       notes: numberOfNotes;
		       noteIndex: 1;
		       midiChannel: 1.
	seq numberOfTrigs > 1 ifTrue: [
		dur := self class
			       new: self trigs
			       withAll: self minDurationBetweenGates ].

	seq durations: dur.
	seq gateTimes: gts.
	^ seq
]

{ #category : '*Coypu' }
Array >> asSeries [

"convenience method to create a series of integers incremented by 1"
^ ((self at: 1) rounded to: (self at: 2) rounded) asArray





]

{ #category : '*Coypu' }
Array >> euclidean [
	"generates an euclidean rhythm with (self at: 1) onsets and (self at: 2) pulses. 
algorithm based on the Bresenham approach"

	| onsets pulses slope result previous current announcement |
	announcement := RhythmAnnouncement new rhythm: self asString , ' euclidean'.
	PerformanceRecorder uniqueInstance announce: announcement.
	current := 0.
	onsets := self at: 1.
	pulses := self at: 2.
	slope := onsets / pulses.
	result := OrderedCollection new.
	(0 to: pulses - 1) do: [ :i |
		current := (i * slope) asInteger.
		current ~= previous
			ifTrue: [ result add: 1 ]
			ifFalse: [ result add: 0 ].
		previous := current ].

	^ result asDirtArray asRhythm asSeq
]

{ #category : '*Coypu' }
Array >> fullScale [
	"expands a Scale into the full MIDI keyboard range"

	| fs fsMIDIRange numberOfOctaves |
	numberOfOctaves := 10.

	fs := OrderedCollection new.
	0 to: numberOfOctaves do: [ :i | fs addAll: self + (self size * i) ].
	fsMIDIRange := fs truncateTo: 128.
	^ fsMIDIRange asArray
]

{ #category : '*Coypu' }
Array >> innestedWithTrigs: anotherArray [
" add trigs in self if anotherArray has trigs at indexes where self have not"
(1 to: (self size)) do: [ :i  |  self at: i put: (1 min: ((self at: i) + (anotherArray at: i)))].

^ self
]

{ #category : '*Coypu' }
Array >> into: anotherArray [

	"return a new array with anotherArray at the desired indexes; if the index is out of bound, the last element of another array is collected.
	if the index is 0 a 0 is collected indicating a rest"

	^ self collect: [ :i | i~= 0 ifTrue: [   anotherArray at: (i min: anotherArray size) ] ifFalse: [0]]
]

{ #category : '*Coypu' }
Array >> isSequencer [

	^ false
]

{ #category : '*Coypu' }
Array >> minDurationBetweenGates [

	| onesIndices minDistance |
	"this method finds the minimum duration distance in steps between two gates (1s) in an array""Find all the indices where the value is 1"
 "Find all the indices where the value is 1"
   
    
 
    
    "Find all the indices where the value is 1"
    onesIndices := (1 to: self size) select: [ :i | (self at: i) = 1 ].
    
    "If there are fewer than two ones, return 0 since no distance can be calculated"
    onesIndices size < 2 ifTrue: [ ^ 0 ].
    
    "Initialize minDistance with a large number"
    minDistance := self size.
    
    "Calculate the minimum distance between consecutive ones"
    1 to: onesIndices size - 1 do: [ :i |
        minDistance := minDistance min: (onesIndices at: i + 1) - (onesIndices at: i).
    ].
    
    ^ minDistance

]

{ #category : '*Coypu' }
Array >> numberOfGates [ 
"return number of elements in the array that are greater than 0"
| result size |
result := self select: [ :i | i > 0 ].
size := result size.
^ size
]

{ #category : '*Coypu' }
Array >> of: anotherArray [
" economic implementation of self collect: [:i | anotherArray at: i]"
| result |
result := self collect: [ :i | anotherArray  at: i ].
^ result
]

{ #category : '*Coypu' }
Array >> offset: aNumber [
"offset the rhythm by aNumber of 'steps' wrapping it around its size"
| newArray |
newArray := self class new: (self size).
0 to: ((self size) - 1) do: [ :i | newArray at: ((i + aNumber) modulo: (self size)) put: (self at: i + 1)].
^ newArray .

]

{ #category : '*Coypu' }
Array >> randomOctaves: anInteger [

	| newArray |
	newArray := (1 to: self size) collect: [ :i | 
		            (self at: i)
		            + (12 * (Random new nextInteger: anInteger - 1)) ].
	^ newArray
]

{ #category : '*Coypu' }
Array >> root: anIntegerRoot octaves: anIntegerOctave [
| x |
x := OrderedCollection new.
(0 to: anIntegerOctave) do: [ :i | x addAll: (self + (anIntegerRoot  + (i * 12) ) )].
^ x

]

{ #category : '*Coypu' }
Array >> times: aNumber [
"returns an Array containing aNumber repetition of self"

| newSize newArray  |
newSize := aNumber * self size.
newArray := Array new: newSize.
(1 to: newSize) do: [ :i | newArray  at: i put: (self at: ((i ) modulo: (self size )) ) ].
^ newArray
]

{ #category : '*Coypu' }
Array >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : '*Coypu' }
Array >> toKyma: aString [
	"sends and array of oscmessages with the values of the array to the vcs labels with array indexes"
	
	| array pacaAddress sizeMessage|
	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). 
	sizeMessage := OSCMessage for: { '/vcs/', aString,'Size', '/1' . (self size) asFloat}.
	array := ( 1 to: (self size)) collect: [ :i | OSCMessage for: {'/vcs/', aString, (i asString),'/1'. 	((self 		at: i) asFloat) 	} ].
	(1 to: (array size)) do: [:i | (array at: i) sendToAddressString: pacaAddress port: 8000].
	sizeMessage sendToAddressString: pacaAddress port: 8000. 

"this message alls sends an OSC message called aStringSize"
	
]

{ #category : '*Coypu' }
Array >> trigs [

	"return the number of trigs (value  = 1),  of the array"

	| result |
	result := 0.
	(1 to: self size) do: [ :i | 
		(self  at: i) = 1
			ifTrue: [ result := result + 1 ]
			ifFalse: [ nil ] ].
	^ result
]

{ #category : '*Coypu' }
Array >> wrap: anInteger [

	"inspire by Cmajor language wrap<int> always wrap the index of the array to the array size"

	| result |
	result := self at: anInteger - 1 % self size + 1.
	^ result
]
