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
