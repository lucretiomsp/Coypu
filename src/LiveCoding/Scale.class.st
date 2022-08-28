"
A Scale is an Array of Musical Intervals in Number of Seminotes.
Sending the name of the desired Scale to the Scale class returns the desired class
"
Class {
	#name : #Scale,
	#superclass : #Array,
	#type : #variable,
	#category : #'LiveCoding-ScalesAndChords'
}

{ #category : #'as yet unclassified' }
Scale class >> augmented [
^ (Scale with: #(0 3 4  7 8 11))
]

{ #category : #'as yet unclassified' }
Scale class >> augmented: aMidiNoteNumber [
^ #(0 3 4  7 8 11) + aMidiNoteNumber

]

{ #category : #'as yet unclassified' }
Scale class >> bebop [
^ #(0 2 4 5 7 9 10 11)
]

{ #category : #'as yet unclassified' }
Scale class >> bebop: aMidiNoteNumber [
^ #(0 2 4 5 7 9 10 11)  + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> blues [
^ #(0 3 5 6 7 10)
]

{ #category : #'as yet unclassified' }
Scale class >> blues: aMidiNoteNumber [

^ #(0 3 5 6 7 10) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> blues: aMidiNoteNumber octaves: numberOfOctaves [

| x scale|
scale := #(0 3 5 6 7 10).
x  := OrderedCollection  new.
(1 to: numberOfOctaves ) do: [ :i | x addAll: (scale + (aMidiNoteNumber * i) ) ].
^  x
]

{ #category : #'as yet unclassified' }
Scale class >> chromatic [
^ #(0 1 2 3 4 5 6 7 8 9 10 11)
]

{ #category : #'as yet unclassified' }
Scale class >> chromatic: aMidiNoteNumber [
^ #(0 1 2 3 4 5 6 7 8 9 10 11) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> enigmatic [
^ #(0 1 4 6 8 10 11)
]

{ #category : #'as yet unclassified' }
Scale class >> enigmatic: aMidiNoteNumber [
^ #(0 1 4 6 8 10 11) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> flamenco [

^ #(0 1 4 5 7 8 11) 
]

{ #category : #'as yet unclassified' }
Scale class >> flamenco: aMidiNoteNumber [
^ (self flamenco) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> gypsy [
^ #(0 2 3 6 7 8 10)
]

{ #category : #'as yet unclassified' }
Scale class >> gypsy: aMidiNoteNumber [
^ #(0 2 3 6 7 8 10) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> hirajoshi [
" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
^ #( 0 4 6 7 11)
]

{ #category : #'as yet unclassified' }
Scale class >> hirajoshi: aMidiNoteNumber [
" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
^ #( 0 4 6 7 11) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> insen [
"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
^ #(0 1 5 7 10 )

]

{ #category : #'as yet unclassified' }
Scale class >> insen: aMidiNoteNumber [
"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
^ #(0 1 5 7 10 ) + aMidiNoteNumber

]

{ #category : #'as yet unclassified' }
Scale class >> istrian [
^ #(0 1 3 4 6)
]

{ #category : #'as yet unclassified' }
Scale class >> istrian: aMidiNoteNumber [
^ #(0 1 3 4 6) + aMidiNoteNumber 
]

{ #category : #creating }
Scale class >> major [ 

^ #(0 2 4 5 7 9 11).
]

{ #category : #'accessing - structure variables' }
Scale class >> major: aMidiNoteNumber [ 

^ #(0 2 4 5 7 9 11 ) + aMidiNoteNumber.
]

{ #category : #creating }
Scale class >> minor [ 

^ #(0 2 3 5 7 8 10 12 13 17 20)
]

{ #category : #'accessing - structure variables' }
Scale class >> minor: aMidiNoteNumber [

^ #(0 2 3 5 7 8 10) + aMidiNoteNumber
]

{ #category : #creating }
Scale class >> pentaMajor [
^ #(0 2 4 7 9 )
]

{ #category : #'as yet unclassified' }
Scale class >> pentaMajor: aMidiNoteNumber [
^ #(0 2 4 7 9) + aMidiNoteNumber 
]

{ #category : #creating }
Scale class >> pentaMinor [
^ #(0 3 5 7 10 )
]

{ #category : #'as yet unclassified' }
Scale class >> pentaMinor: aMidiNoteNumber [
^ #(0 3 5 7 10 ) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> persian [
^ #(0 1 4 5 6 8 11)
]

{ #category : #'as yet unclassified' }
Scale class >> persian: aMidiNoteNumber [
^ #(0 1 4 5 6 8 11) + aMidiNoteNumber
]

{ #category : #'as yet unclassified' }
Scale class >> sakura [
"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
^ #(0 1 5 7 8 )
]

{ #category : #'as yet unclassified' }
Scale class >> sakura: aMidiNoteNumber [
"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
^ #(0 1 5 7 8 ) + aMidiNoteNumber 
]

{ #category : #'as yet unclassified' }
Scale class >> yo [
" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
^ #(0 3 5 7 10 )
]

{ #category : #'as yet unclassified' }
Scale class >> yo: aMidiNoteNumber [
" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
^ #(0 3 5 7 10 ) + aMidiNoteNumber 
]
