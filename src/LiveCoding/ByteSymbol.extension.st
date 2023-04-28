Extension { #name : #ByteSymbol }

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
ByteSymbol >> visualizeGates [

	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"

	| colors canvas p seq window morph extent stepNumber borderWidth |
	stepNumber := 1.
	p := Performance uniqueInstance.
	seq := p at: self.
	extent := 800 @ 200.
	borderWidth := #( 7 2 4 2 ).
	colors := #( #white #yellow ).
	canvas := RSCanvas new
		          extent: extent;
		          color: #black.
	seq gates do: [ :i | 
	
		canvas add: (RSBox new
				 size: 38;
				 color: (colors at: i + 1);
				 border: (RSBorder new
						  color: #blue;
						  width: (borderWidth at: (stepNumber - 1 rem: 4) + 1))).
		stepNumber := stepNumber + 1 ].

	"RSHorizontalLineLayout on: canvas shapes."
	RSGridLayout new
		lineItemsCount: 16;
		on: canvas shapes.
	canvas zoomToFit.
	morph := canvas createMorph.
	window := morph openInWindowLabeled: self asString.
	window extent: 900 @ 260.
	morph privateOwner: window
]
