"
A Scale is an Array of Musical Intervals in Number of Seminotes.
Sending the name of the desired Scale to the Scale class returns the desired class
"
Class {
	#name : #Scale,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'root'
	],
	#category : #'Coypu-ScalesAndChords'
}

{ #category : #'creating - withoutRoot' }
Scale class >> augmented [

	^  #( 0 3 4 7 8 11 )
]

{ #category : #'creating - withRoot' }
Scale class >> augmented: aMidiNoteNumber [
	^ #(0 3 4  7 8 11) + aMidiNoteNumber

]

{ #category : #'creating - withoutRoot' }
Scale class >> bebop [
	^ #(0 2 4 5 7 9 10 11)
]

{ #category : #'creating - withRoot' }
Scale class >> bebop: aMidiNoteNumber [
	^ #(0 2 4 5 7 9 10 11)  + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> blues [
	^ #(0 3 5 6 7 10)
]

{ #category : #'creating - withRoot' }
Scale class >> blues: aMidiNoteNumber [

	^ #(0 3 5 6 7 10) + aMidiNoteNumber
]

{ #category : #'creating - withRoot' }
Scale class >> blues: aMidiNoteNumber octaves: numberOfOctaves [

	| x scale|
	scale := #(0 3 5 6 7 10).
	x  := OrderedCollection  new.
	(1 to: numberOfOctaves ) do: [ :i | x addAll: (scale + (aMidiNoteNumber * i) ) ].
	^  x
]

{ #category : #'creating - withoutRoot' }
Scale class >> chromatic [
	^ #(0 1 2 3 4 5 6 7 8 9 10 11)
]

{ #category : #'creating - withRoot' }
Scale class >> chromatic: aMidiNoteNumber [
	^ #(0 1 2 3 4 5 6 7 8 9 10 11) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> enigmatic [
	^ #(0 1 4 6 8 10 11)
]

{ #category : #'creating - withRoot' }
Scale class >> enigmatic: aMidiNoteNumber [
	^ #(0 1 4 6 8 10 11) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> flamenco [

	^ #(0 1 4 5 7 8 11) 
]

{ #category : #'creating - withRoot' }
Scale class >> flamenco: aMidiNoteNumber [

	^ self flamenco + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> gypsy [
	^ #(0 2 3 6 7 8 10)
]

{ #category : #'creating - withRoot' }
Scale class >> gypsy: aMidiNoteNumber [

	^ #(0 2 3 6 7 8 10) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> hirajoshi [
	" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
	^ #( 0 4 6 7 11)
]

{ #category : #'creating - withRoot' }
Scale class >> hirajoshi: aMidiNoteNumber [
	" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
	^ #( 0 4 6 7 11) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> insen [
	"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
	
	^ #(0 1 5 7 10 )

]

{ #category : #'creating - withRoot' }
Scale class >> insen: aMidiNoteNumber [
	"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
	^ #(0 1 5 7 10 ) + aMidiNoteNumber

]

{ #category : #'creating - withoutRoot' }
Scale class >> istrian [
	^ #(0 1 3 4 6)
]

{ #category : #'creating - withRoot' }
Scale class >> istrian: aMidiNoteNumber [
	^ #(0 1 3 4 6) + aMidiNoteNumber 
]

{ #category : #'creating - withoutRoot' }
Scale class >> major [ 

	^ #(0 2 4 5 7 9 11)
]

{ #category : #'accessing - structure variables' }
Scale class >> major: aMidiNoteNumber [ 

	^ #(0 2 4 5 7 9 11 ) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> minor [

	^ #( 0 2 3 5 7 8 10 12  )
]

{ #category : #'accessing - structure variables' }
Scale class >> minor: aMidiNoteNumber [

	^ #(0 2 3 5 7 8 10) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> pentaMajor [

	^ #(0 2 4 7 9 )
]

{ #category : #'creating - withRoot' }
Scale class >> pentaMajor: aMidiNoteNumber [
	
	^ #(0 2 4 7 9) + aMidiNoteNumber 
]

{ #category : #'creating - withoutRoot' }
Scale class >> pentaMinor [
	^ #(0 3 5 7 10 )
]

{ #category : #'creating - withoutRoot' }
Scale class >> pentaMinor: aMidiNoteNumber [
	^ #(0 3 5 7 10 ) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> persian [
	^ #(0 1 4 5 6 8 11)
]

{ #category : #'creating - withoutRoot' }
Scale class >> persian: aMidiNoteNumber [
	^ #(0 1 4 5 6 8 11) + aMidiNoteNumber
]

{ #category : #'creating - withoutRoot' }
Scale class >> sakura [
	"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
	^ #(0 1 5 7 8 )
]

{ #category : #'creating - withoutRoot' }
Scale class >> sakura: aMidiNoteNumber [
	"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
	^ #(0 1 5 7 8 ) + aMidiNoteNumber 
]

{ #category : #'creating - withoutRoot' }
Scale class >> yo [
	" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
	^ #(0 3 5 7 10 )
]

{ #category : #'creating - withoutRoot' }
Scale class >> yo: aMidiNoteNumber [
	" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
	^ #(0 3 5 7 10 ) + aMidiNoteNumber 
]
