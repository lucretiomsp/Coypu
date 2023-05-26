Extension { #name : #ByteSymbol }

{ #category : #'*LiveCoding' }
ByteSymbol >> bw: anArrayOfBw [

	"set anArrayOfBw as extra1 of the sequencer in the performance at self"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#Bw.
			anArrayOfBw }
]

{ #category : #'*LiveCoding' }
ByteSymbol >> extra1: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra1: anArrayWithASymbolAndAnArray
]

{ #category : #'*LiveCoding' }
ByteSymbol >> extra2: anArrayWithASymbolAndAnArray [

	" change the value of extra1 in the Performance at self key"

	| p |
	p := Performance uniqueInstance.

	(p at: self) extra2: anArrayWithASymbolAndAnArray
]

{ #category : #'*LiveCoding' }
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

{ #category : #'*LiveCoding' }
ByteSymbol >> indexes: anArrayOfIndexes [

	"change the sample indexes of a seuquencer in a performance at self key"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#Index.
			anArrayOfIndexes }
]

{ #category : #'*LiveCoding' }
ByteSymbol >> mute [

	" remove the key from the Performance, if any active key in the Performance correspond to the symbol"

	| perf |
	perf := Performance uniqueInstance.
	perf removeKey: self ifAbsent: [ nil ]
]

{ #category : #'*LiveCoding' }
ByteSymbol >> notes: anArrayOfNotes [

	" change the notes of a Sequencer at self key in a Performance"

	| p |
	p := Performance uniqueInstance.
	(p at: self) notes: anArrayOfNotes
]

{ #category : #'*LiveCoding' }
ByteSymbol >> number: anArrayOfNumbers [

	" set the extra2 slot of the sequencer in the performance at self key with the values of anArrayOfNumbers and the string #Number - to be used with muultikits"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra2: { 
			#Number.
			anArrayOfNumbers }
]

{ #category : #'*LiveCoding' }
ByteSymbol >> solo [

	"shorthand for p solo: aKeyInperformance"

	| p |
	p := Performance uniqueInstance.
	p solo: self
]

{ #category : #'*LiveCoding' }
ByteSymbol >> unsolo [

	"shorthand for p unsolo: aKeyInPerformance"

	| p |
	p := Performance uniqueInstance.
	p unsolo: self
]

{ #category : #'*LiveCoding' }
ByteSymbol >> visualizeGates [

	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"

	| colors canvas p seq window morph extent borderWidth markShape |
	p := Performance uniqueInstance.
	seq := p at: self.
	extent := 800 @ 200.
	borderWidth := #( 7 2 4 2 ).
	colors := #( #white #yellow ).
	canvas := RSCanvas new
		          extent: extent;
		          color: #black.
	seq gates doWithIndex:  [ :gate :stepNumber | 
	
		canvas add: (RSBox new
				 size: 38;
				 color: (colors at: gate + 1);
				 border: (RSBorder new
						  color: #blue;
						  width: (borderWidth at: (stepNumber - 1 rem: 4) + 1))) ].

	"RSHorizontalLineLayout on: canvas shapes."
	RSGridLayout new
		lineItemsCount: 16;
		on: canvas shapes.
	markShape := nil.
	canvas newAnimation
		repeat;
		onStepDo: [ | shapeIndex currentShape |
			"shapeIndex := seq gates wrap: seq noteIndex ."
			shapeIndex := p transportStep  - 1 % seq gates size + 1.
			shapeIndex traceCr.
			currentShape := canvas nodes at: shapeIndex .
			markShape ifNil: [ 
				markShape := RSEllipse size: 20.
				markShape color: Color red.
				canvas add: markShape.
				 ].
			markShape position: currentShape position.
			canvas signalUpdate
			 ].
	canvas zoomToFit.
	window := canvas open.
	window setLabel: self asString.
	window extent: 900 @ 260.
]

{ #category : #'*LiveCoding' }
ByteSymbol >> x: anArrayOfXs [

	"set anArrayOfX as extra1 of the sequencer in the performance at self
	intended to use for a Modal Bar strike position"

	| p |
	p := Performance uniqueInstance.
	(p at: self) extra1: { 
			#x.
			anArrayOfXs }
]
