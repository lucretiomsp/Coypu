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

	| colors canvas p seq |
	p := Performance uniqueInstance.
	seq := p at: self.
	colors := #( #white #yellow ).
	canvas := RSCanvas new.
	seq gates do: [ :i | 
		canvas add: (RSBox new
				 size: 80;
				 color: (colors at: i + 1);
				 border: (RSBorder new
						  color: #blue;
						  width: 10)) ].

	RSHorizontalLineLayout on: canvas shapes.
	canvas zoomToFit.
	canvas open
]
