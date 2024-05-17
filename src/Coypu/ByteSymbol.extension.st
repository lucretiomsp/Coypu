Extension { #name : #ByteSymbol }

{ #category : #'*Coypu' }
ByteSymbol >> asDirtArray [ 
" convenience method to send messages to SuperDirt"

^ Array with: self.
]

{ #category : #'*Coypu' }
ByteSymbol >> bw: anArrayOfBw [

	"set anArrayOfBw as extra1 of the sequencer in the performance at self"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#Bw.
			anArrayOfBw }
]

{ #category : #'*Coypu' }
ByteSymbol >> extra1: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra1: anArrayWithASymbolAndAnArray
]

{ #category : #'*Coypu' }
ByteSymbol >> extra2: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra2: anArrayWithASymbolAndAnArray
]

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
ByteSymbol >> indexes: aStringOfIndexes [
	"change the sample indexes of a seuquencer in a performance at self key"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra: 
			#Index
			values: aStringOfIndexes asDirtPureNotes  
]

{ #category : #'*Coypu' }
ByteSymbol >> mute [

	" remove the key from the Performance, if any active key in the Performance correspond to the symbol"

	| perf |
	perf := Performance uniqueInstance.
	perf removeKey: self ifAbsent: [ nil ]
]

{ #category : #'*Coypu' }
ByteSymbol >> notes: anArrayOfNotes [

	" change the notes of a Sequencer at self key in a Performance"

	| p |
	p := Performance uniqueInstance.
	(p at: self) notes: anArrayOfNotes
]

{ #category : #'*Coypu' }
ByteSymbol >> number: anArrayOfNumbers [

	" set the extra2 slot of the sequencer in the performance at self key with the values of anArrayOfNumbers and the string #Number - to be used with muultikits"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra2: { 
			#Number.
			anArrayOfNumbers }
]

{ #category : #'*Coypu' }
ByteSymbol >> solo [

	"shorthand for p solo: aKeyInperformance"

	| p |
	p := Performance uniqueInstance.
	p solo: self
]

{ #category : #'*Coypu' }
ByteSymbol >> unsolo [

	"shorthand for p unsolo: aKeyInPerformance"

	| p |
	p := Performance uniqueInstance.
	p unsolo: self
]

{ #category : #'*Coypu' }
ByteSymbol >> x: anArrayOfXs [

	"set anArrayOfX as extra1 of the sequencer in the performance at self
	intended to use for a Modal Bar strike position"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#x.
			anArrayOfXs }
]
