Extension { #name : 'ByteSymbol' }

{ #category : '*Coypu' }
ByteSymbol >> asDirtArray [ 
" convenience method to send messages to SuperDirt"

^ Array with: self.
]

{ #category : '*Coypu' }
ByteSymbol >> asRhythm [
	"creates a Sequencer with 16 steps of the rhythm with name self. if the rhythm do not exist, an empty sequencer of 16 values is created and a notification is sent"

	| seq |
	seq := 16 rests.
	(Rhythm list includesKey: self) ifTrue: [ seq := 16 perform: self ].
	^ seq
]

{ #category : '*Coypu' }
ByteSymbol >> bw: anArrayOfBw [

	"set anArrayOfBw as extra1 of the sequencer in the performance at self"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#Bw.
			anArrayOfBw }
]

{ #category : '*Coypu' }
ByteSymbol >> extra1: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra1: anArrayWithASymbolAndAnArray
]

{ #category : '*Coypu' }
ByteSymbol >> extra2: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra2: anArrayWithASymbolAndAnArray
]

{ #category : '*Coypu' }
ByteSymbol >> for: anArray [

"creates a Dictionary with the symbol as key and the array as value"
| d |
d := Array with: (self asString)  with: anArray.
^ d


"
d := Dictionary new.
d add: self -> anArray.
^ d
"
]

{ #category : '*Coypu' }
ByteSymbol >> indexes: aStringOfIndexes [
	"change the sample indexes of a seuquencer in a performance at self key"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra: 
			#Index
			values: aStringOfIndexes asDirtPureNotes  
]

{ #category : '*Coypu' }
ByteSymbol >> mute [
	" remove the key from the Performance, if any active key in the Performance correspond to the symbol"

	| perf |
	perf := Performance uniqueInstance uniqueInstance.
	perf removeKey: self ifAbsent: [ nil ]
]

{ #category : '*Coypu' }
ByteSymbol >> notes: anArrayOfNotes [

	" change the notes of a Sequencer at self key in a Performance"

	| p |
	p := Performance uniqueInstance.
	(p at: self) notes: anArrayOfNotes
]

{ #category : '*Coypu' }
ByteSymbol >> number: anArrayOfNumbers [

	" set the extra2 slot of the sequencer in the performance at self key with the values of anArrayOfNumbers and the string #Number - to be used with muultikits"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra2: { 
			#Number.
			anArrayOfNumbers }
]

{ #category : '*Coypu' }
ByteSymbol >> ritmo [ 	
	"creates a Sequencer with 16 steps of the named rhythm - alias of rhythm for non english speaker :)"

	^ 16 perform: self
]

{ #category : '*Coypu' }
ByteSymbol >> solo [
	"shorthand for p solo: aKeyInperformance"

	Performance uniqueInstance solo: self
]

{ #category : '*Coypu' }
ByteSymbol >> swapWith: aSymbol [
	"swap the current sequencer sound to the sound represented by a symbol . or viceversa! please refer to Coypu performer for connecting sequencer names to actual audio server sounds"

	| p |
	p := Performance uniqueInstance.
	(p includesKey: self) ifTrue: [
		(p at: self) to: aSymbol.
		p mute: self ] ifFalse: [ (p at:  aSymbol) to: self. p mute: aSymbol. ]
]

{ #category : '*Coypu' }
ByteSymbol >> to: aSymbol [
<onTheFlyEssentials>
	^ self asRhythm to: aSymbol
]

{ #category : '*Coypu' }
ByteSymbol >> unsolo [
	"shorthand for p unsolo: aKeyInPerformance"


	Performance uniqueInstance unsolo: self
]

{ #category : '*Coypu' }
ByteSymbol >> x: anArrayOfXs [

	"set anArrayOfX as extra1 of the sequencer in the performance at self
	intended to use for a Modal Bar strike position"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#x.
			anArrayOfXs }
]
