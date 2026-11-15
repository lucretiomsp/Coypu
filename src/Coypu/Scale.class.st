"
A Scale is an Array of Musical Intervals in Number of Seminotes.
Sending the name of the desired Scale to the Scale class returns the desired class
"
Class {
	#name : 'Scale',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'root'
	],
	#category : 'Coypu-ScalesAndChords',
	#package : 'Coypu',
	#tag : 'ScalesAndChords'
}

{ #category : 'creating - withoutRoot' }
Scale class >> aeolian [ 
"Aeolian. From SuperCollider Scale.aeolian"
	^ #( 0 2 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> aeolian: aMidiNoteNumber [ 
"Aeolian. From SuperCollider Scale.aeolian"
	^ #( 0 2 3 5 7 8 10 ) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> aeolianHex [

"Hex Aeolian, hexatonic mode with no tritone. From SuperCollider Scale.hexAeolian"
	^ #( 0 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> ahirbhairav [ 
	"Ahirbhairav, raga mode. From SuperCollider Scale.ahirbhairav"
	^ #( 0 1 4 5 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> ahirbhairav: aMidiNoteNumber [ 
	"Ahirbhairav, raga mode. From SuperCollider Scale.ahirbhairav"
	^ #( 0 1 4 5 7 9 10 ) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> ajam [ 

	"Ajam, Arabic maqam of the ajam family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.ajam"
	^ #( 0 2 4 5 7 9 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> ajam: aMidiNoteNumber [ 

	"Ajam, Arabic maqam of the ajam family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.ajam"
	^ #( 0 2 4 5 7 9 11 ) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> atharKurd [ 

	"Athar Kurd, Arabic maqam of the nawa athar family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.atharKurd"
	^ #( 0 1 3 6 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> atharKurd: aMidiNoteNumber [ 

	"Athar Kurd, Arabic maqam of the nawa athar family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.atharKurd"
	^ #( 0 1 3 6 7 8 11 )+ aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> augmented [

	^  #( 0 3 4 7 8 11 )
]

{ #category : 'creating - withRoot' }
Scale class >> augmented: aMidiNoteNumber [
	^ #(0 3 4  7 8 11) + aMidiNoteNumber

]

{ #category : 'creating - withoutRoot' }
Scale class >> bahirav [

"Bhairav, raga mode. From SuperCollider Scale.bhairav"
	^ #( 0 1 4 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> bartok [

"Bartok. From SuperCollider Scale.bartok"
	^ #( 0 2 4 5 7 8 10 ) 
]

{ #category : 'creating - withoutRoot' }
Scale class >> bartok: aMidiNoteNumber [ 

"Bartok. From SuperCollider Scale.bartok"
	^ #( 0 2 4 5 7 8 10 ) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> bastanikar [

	"Bastanikar, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.bastanikar"
	^ #( 0 1.5 3.5 5 6.5 7.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> bayati [

"Bayati, Arabic maqam of the bayati family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.bayati"
	^ #( 0 1.5 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> bebop [
	^ #(0 2 4 5 7 9 10 11)
]

{ #category : 'creating - withRoot' }
Scale class >> bebop: aMidiNoteNumber [
	^ #(0 2 4 5 7 9 10 11)  + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> blues [
	^ #(0 3 5 6 7 10)
]

{ #category : 'creating - withRoot' }
Scale class >> blues: aMidiNoteNumber [

	^ #(0 3 5 6 7 10) + aMidiNoteNumber
]

{ #category : 'creating - withRoot' }
Scale class >> blues: aMidiNoteNumber octaves: numberOfOctaves [

	| x scale|
	scale := #(0 3 5 6 7 10).
	x  := OrderedCollection  new.
	(1 to: numberOfOctaves ) do: [ :i | x addAll: (scale + (aMidiNoteNumber * i) ) ].
	^  x
]

{ #category : 'creating - withoutRoot' }
Scale class >> chines [ 
	"Chinese, a mode of hirajoshi. From SuperCollider Scale.chinese"
	^ #( 0 4 6 7 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> chromatic [
	^ #(0 1 2 3 4 5 6 7 8 9 10 11)
]

{ #category : 'creating - withRoot' }
Scale class >> chromatic: aMidiNoteNumber [
	^ #(0 1 2 3 4 5 6 7 8 9 10 11) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> diminished [

"Diminished. From SuperCollider Scale.diminished"
	^ #( 0 1 3 4 6 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> domenico [

	^ #( 0 2 8 9 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> dorian [ 
^ #( 0 2 3 5 7 9 10 )

]

{ #category : 'creating - withoutRoot' }
Scale class >> dorianHex [
	"Hex Dorian, hexatonic mode with no tritone. From SuperCollider Scale.hexDorian"
	^ #( 0 2 3 5 7 10 ) 
]

{ #category : 'creating - withoutRoot' }
Scale class >> egyptian [

"Egyptian, another mode of the major pentatonic. From SuperCollider Scale.egyptian"
	^ #( 0 2 5 7 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> enigmatic [
	^ #(0 1 4 6 8 10 11)
]

{ #category : 'creating - withRoot' }
Scale class >> enigmatic: aMidiNoteNumber [
	^ #(0 1 4 6 8 10 11) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> farahfaza [

"Farahfaza, Arabic maqam of the nahawand family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.farahfaza"
	^ #( 0 2 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> flamenco [

	^ #(0 1 4 5 7 8 11) 
]

{ #category : 'creating - withRoot' }
Scale class >> flamenco: aMidiNoteNumber [

	^ self flamenco + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> gong [ 
"Gong, Han Chinese pentatonic scale. From SuperCollider Scale.gong"
	^ #( 0 2 4 7 9 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> gypsy [
	^ #(0 2 3 6 7 8 10)
]

{ #category : 'creating - withRoot' }
Scale class >> gypsy: aMidiNoteNumber [

	^ #(0 2 3 6 7 8 10) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> harmonicMajor [

"Harmonic Major. From SuperCollider Scale.harmonicMajor"
	^ #( 0 2 4 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> harmonicMinor [

"Harmonic Minor. From SuperCollider Scale.harmonicMinor"
	^ #( 0 2 3 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> hijJaz [

"Hijaz, Arabic maqam of the hijaz family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.hijaz"
	^ #( 0 1 4 5 7 8.5 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> hijJazDesc [

	"Hijaz Descending, Arabic maqam of the hijaz family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.hijazDesc"
	^ #( 0 1 4 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> hijazKar [ 

	"hijazKar, Arabic maqam of the hijazKar family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.hijazKar"
	^ #( 0 1 4 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> hirajoshi [
	" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
	^ #( 0 4 6 7 11)
]

{ #category : 'creating - withRoot' }
Scale class >> hirajoshi: aMidiNoteNumber [
	" a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto."
	^ #( 0 4 6 7 11) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> insen [
	"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
	
	^ #(0 1 5 7 10 )

]

{ #category : 'creating - withRoot' }
Scale class >> insen: aMidiNoteNumber [
	"a tuning scale adapted from shamisen music by Yatsuhashi Kengyō for tuning of the koto. It only differs from the hirajoshi scale by one note."
	^ #(0 1 5 7 10 ) + aMidiNoteNumber

]

{ #category : 'creating - withoutRoot' }
Scale class >> istrian [
	^ #(0 1 3 4 6)
]

{ #category : 'creating - withRoot' }
Scale class >> istrian: aMidiNoteNumber [
	^ #(0 1 3 4 6) + aMidiNoteNumber 
]

{ #category : 'accessing' }
Scale class >> list [

	| methods dicList |
	dicList := Dictionary new.
	methods := (self  class selectorsInProtocol: 'creating - withoutRoot')
		           reject: [ :i | i includesSubstring: ':' ].

	methods do: [ :i | dicList add: i -> (self class  >> i) comments" first" ].

	^ methods
]

{ #category : 'creating - withoutRoot' }
Scale class >> major [ 

	^ #(0 2 4 5 7 9 11)
]

{ #category : 'creating - withoutRoot' }
Scale class >> major6Hex [

"Hex Major 6, hexatonic mode with no tritone. From SuperCollider Scale.hexMajor6"
	^ #( 0 2 4 5 7 9 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> major7Hex [

"Hex Major 7, hexatonic mode with no tritone. From SuperCollider Scale.hexMajor7"
	^ #( 0 2 4 7 9 11 )
]

{ #category : 'accessing - structure variables' }
Scale class >> major: aMidiNoteNumber [ 

	^ #(0 2 4 5 7 9 11 ) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> minor [

	^ #( 0 2 3 5 7 8 10 12  )
]

{ #category : 'accessing - structure variables' }
Scale class >> minor: aMidiNoteNumber [

	^ #(0 2 3 5 7 8 10) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> pentaMajor [

	^ #(0 2 4 7 9 )
]

{ #category : 'creating - withRoot' }
Scale class >> pentaMajor: aMidiNoteNumber [
	
	^ #(0 2 4 7 9) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> pentaMinor [
	^ #(0 3 5 7 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> pentaMinor: aMidiNoteNumber [
	^ #(0 3 5 7 10 ) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> persian [
	^ #(0 1 4 5 6 8 11)
]

{ #category : 'creating - withoutRoot' }
Scale class >> persian: aMidiNoteNumber [
	^ #(0 1 4 5 6 8 11) + aMidiNoteNumber
]

{ #category : 'creating - withoutRoot' }
Scale class >> phrygianHex [ 

"Hex Phrygian, hexatonic mode with no tritone. From SuperCollider Scale.hexPhrygian"
	^ #( 0 1 3 5 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> sakura [
	"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
	^ #(0 1 5 7 8 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> sakura: aMidiNoteNumber [
	"also known as 'in scale' is a traditiona pentatonic scale of Japanese music, specifically for joto and shamisen "
	^ #(0 1 5 7 8 ) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> susHex [ 

"Hex Sus, hexatonic mode with no tritone. From SuperCollider Scale.hexSus"
	^ #( 0 2 5 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> yo [
	" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
	^ #(0 3 5 7 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> yo: aMidiNoteNumber [
	" A pentatonic scale used in much Japanese music including gagaku and shomyo. it does not contain minor notes"
	^ #(0 3 5 7 10 ) + aMidiNoteNumber 
]
