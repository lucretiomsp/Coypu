Extension { #name : #Array }

{ #category : #'*LiveCoding' }
Array >> * aNumber [
"returns an Array with all the elements of self multiplicated for aNumber"

| result |
result := ( 1to: (self size)) collect: [ :i | (self at: i) * aNumber ].
^ result
]

{ #category : #'*LiveCoding' }
Array >> + aNumber [ 
" sum aNumber to each element of the array"
| result |
result := (1 to: (self size)) collect: [ :i | (self at: i ) + aNumber ].
^ result
]

{ #category : #'*LiveCoding' }
Array >> - aNumber [ 
" sum aNumber to each element of the array"
| result |
result := (1 to: (self size)) collect: [ :i | (self at: i ) - aNumber ].
^ result
]

{ #category : #'*LiveCoding' }
Array >> > aString [
"experimental"
Transcript show: aString; open.
]

{ #category : #'*LiveCoding' }
Array >> and: anArray [

^ Sequencer with: self with: anArray
]

{ #category : #'*LiveCoding' }
Array >> and: anArray and: anotherArray [

^ Sequencer with: self with: anArray with: anotherArray 
]

{ #category : #'*LiveCoding' }
Array >> asRhythm [
" convert Array into a Rhythm"
| rhythm |
rhythm := Rhythm new: (self size).
(1 to: ( self size)) do: [ :i | rhythm at: i put: (self at: i) ].
^ rhythm
]

{ #category : #'*LiveCoding' }
Array >> asSeq [

	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"

	"duration now expressed in number of steps"

	^ Sequencer new 
		  gates: self;
		  notes: #( 60 );
		  durations: #( 1 );
		  noteIndex: 0

	" durations formerly in fraction of bar
(Sequencer with: self with: #(60) with: #(0.125) with: 0).
"
]

{ #category : #'*LiveCoding' }
Array >> asSeq2 [

	"returns Sequencer with default note 60nn and default durations 1/16th and noteIndex = 0"

	"duration now expressed in number of steps"
| newSequencer |
newSequencer := Sequencer2 new.
newSequencer gates: self;
		  notes: #( 60 );
		  durations: #( 1 );
		  index: 0.

	" durations formerly in fraction of bar" 
]

{ #category : #'*LiveCoding' }
Array >> innestedWithTrigs: anotherArray [
" add trigs in self if anotherArray has trigs at indexes where self have not"
(1 to: (self size)) do: [ :i  |  self at: i put: (1 min: ((self at: i) + (anotherArray at: i)))].

^ self
]

{ #category : #'*LiveCoding' }
Array >> into: anotherArray [
"return a new array with anotherArray at the desired indexes; if the index is out of bound, the last element of another array is collected"
^ self collect: [ :i | anotherArray  at: (i min: anotherArray size)]
	
]

{ #category : #'*LiveCoding' }
Array >> isSequencer [

	^ false
]

{ #category : #'*LiveCoding' }
Array >> numberOfGates [ 
"return number of elements in the array that are greater than 0"
| result size |
result := self select: [ :i | i > 0 ].
size := result size.
^ size
]

{ #category : #'*LiveCoding' }
Array >> of: anotherArray [
" economic implementation of self collect: [:i | anotherArray at: i]"
| result |
result := self collect: [ :i | anotherArray  at: i ].
^ result
]

{ #category : #'*LiveCoding' }
Array >> offset: aNumber [
"offset the rhythm by aNumber of 'steps' wrapping it around its size"
| newArray |
newArray := self class new: (self size).
0 to: ((self size) - 1) do: [ :i | newArray at: ((i + aNumber) modulo: (self size)) put: (self at: i + 1)].
^ newArray .

]

{ #category : #'*LiveCoding' }
Array >> randomOctaves: anInteger [

	| newArray |
	newArray := (1 to: self size) collect: [ :i | 
		            (self at: i)
		            + (12 * (Random new nextInteger: anInteger - 1)) ].
	^ newArray
]

{ #category : #'*LiveCoding' }
Array >> root: anIntegerRoot octaves: anIntegerOctave [
| x |
x := OrderedCollection new.
(0 to: anIntegerOctave) do: [ :i | x addAll: (self + (anIntegerRoot  + (i * 12) ) )].
^ x

]

{ #category : #'*LiveCoding' }
Array >> times: aNumber [
"returns an Array containing aNumber repetition of self"

| newSize newArray  |
newSize := aNumber * self size.
newArray := Array new: newSize.
(1 to: newSize) do: [ :i | newArray  at: i put: (self at: ((i - 1) modulo: (self size )) ) ].
^ newArray
]

{ #category : #'*LiveCoding' }
Array >> to: aPerformance at: aKey [

aPerformance add: aKey -> self
]

{ #category : #'*LiveCoding' }
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

{ #category : #'*LiveCoding' }
Array >> withIts: anArray [ 
"convenience method to create a Sequence"
| numberOfGates result |

numberOfGates := anArray  size.
result := (1 to: numberOfGates) collect: [ :i | anArray   at: (i modulo: numberOfGates) ].
^ Sequencer with: self with: result
]
