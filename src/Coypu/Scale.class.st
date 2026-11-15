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
Scale class >> hindu [ 

"Hindu. From SuperCollider Scale.hindu"
	^ #( 0 2 4 5 7 8 10 )
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
Scale class >> hungarianMinor [

"Hungarian Minor. From SuperCollider Scale.hungarianMinor"
	^ #( 0 2 3 6 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> husseini [

"Husseini, Arabic maqam of the bayati family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.husseini"
	^ #( 0 1.5 3 5 7 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> huzam [ 

"Huzam, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.huzam"
	^ #( 0 1.5 3.5 4.5 7.5 8.5 10.5 )

]

{ #category : 'creating - withoutRoot' }
Scale class >> indian [

	"Indian. From SuperCollider Scale.indian"
	^ #( 0 4 5 7 10 )
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
Scale class >> iraq [ 

"Iraq, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.iraq"
	^ #( 0 1.5 3.5 5 6.5 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> istrian [
	^ #(0 1 3 4 6)
]

{ #category : 'creating - withRoot' }
Scale class >> istrian: aMidiNoteNumber [
	^ #(0 1 3 4 6) + aMidiNoteNumber 
]

{ #category : 'creating - withoutRoot' }
Scale class >> iwato [

"Iwato, a mode of hirajoshi. From SuperCollider Scale.iwato"
	^ #( 0 1 5 6 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> jiao [ 

"Jiao, Han Chinese pentatonic scale. From SuperCollider Scale.jiao"
	^ #( 0 3 5 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> jiharkah [

"Jiharkah, Arabic maqam of the ajam family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.jiharkah"
	^ #( 0 2 4 5 7 9 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> karjighar [

	"Karjighar, Arabic maqam of the bayati family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.karjighar"
	^ #( 0 1.5 3 5 6 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> kijazKarKurd [

"Kijaz Kar Kurd, Arabic maqam of the kurd family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.kijazKarKurd"
	^ #( 0 1 4 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> kumai [

	"Kumai. From SuperCollider Scale.kumoi"
	^ #( 0 2 3 7 9 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> kurd [ 

	"Kurd, Arabic maqam of the kurd family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.kurd"
	^ #( 0 1 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> leadingWhole [

	"Leading Whole Tone, whole tone scale with an added note. From SuperCollider Scale.leadingWhole"
	^ #( 0 2 4 6 8 10 11 )
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

{ #category : 'accessing' }
Scale class >> locrian [ 

^ #( 0 1 3 5 6 8 10 )
]

{ #category : 'accessing' }
Scale class >> locrianMajor [ 

^ #( 0 2 4 5 6 8 10 )
]

{ #category : 'accessing' }
Scale class >> lydian [ 
^ #( 0 2 4 6 7 9 11 )
]

{ #category : 'accessing' }
Scale class >> lydianMinor [ 

^ #( 0 2 4 6 7 8 10 )
]

{ #category : 'accessing' }
Scale class >> mahur [ 

	^ #( 0 2 3.5 5 7 9 11 )
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

{ #category : 'accessing' }
Scale class >> marva [ 
	"Marva, raga mode. From SuperCollider Scale.marva"
	^ #( 0 1 4 6 7 9 11 )
]

{ #category : 'accessing' }
Scale class >> melodicMajor [ 
^ #( 0 2 4 5 7 8 10 )
]

{ #category : 'accessing' }
Scale class >> melodicMinor [ 

	^ #( 0 2 3 5 7 9 11 )
]

{ #category : 'accessing' }
Scale class >> melodicMinorDesc [ 

		^ #( 0 2 3 5 7 8 10 )
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
Scale class >> mixolydian [ 
	^ #( 0 2 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> murassah [ 
"Murassah, Arabic maqam of the nahawand family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.murassah"
	^ #( 0 2 3 5 6 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> mustar [ 

	"Mustar, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.mustar"
	^ #( 0 2.5 3.5 5.5 6.5 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> nahawand [ 

"Nahawand, Arabic maqam of the nahawand family in 24-TET: x.5 is a quarter tone. Ascending form, the descending one is Scale nahawandDesc. From SuperCollider Scale.nahawand"
	^ #( 0 2 3 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> nahawandDesc [ 

"Nahawand, Arabic maqam of the nahawand family in 24-TET: x.5 is a quarter tone. Ascending form, the descending one is Scale nahawandDesc. From SuperCollider Scale.nahawand"
	^ #( 0 2 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> nairuz [ 
"Nairuz, Arabic maqam of the rast family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.nairuz"
	^ #( 0 2 3.5 5 7 8.5 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> nawaAthar [ 

	"Nawa Athar, Arabic maqam of the nawa athar family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.nawaAthar"
	^ #( 0 2 3 6 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> neapolitanMajor [ 
"Neapolitan Major, whole tone scale with an added note. From SuperCollider Scale.neapolitanMajor"
	^ #( 0 1 3 5 7 9 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> neapolitanMinor [ 

"Neapolitan Minor. From SuperCollider Scale.neapolitanMinor"
	^ #( 0 1 3 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> nikriz [ 
"Nikriz, Arabic maqam of the nawa athar family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.nikriz"
	^ #( 0 2 3 6 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch0 [


	"Partch Otonality 6 in Harry Partch 43-tone just intonation: 1/1 8/7 9/7 10/7 11/7 12/7, in semitones rounded to the cent. From SuperCollider Scale.partch_o6"
	^ #( 0 2.31 4.35 6.17 7.82 9.33 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch01 [ 

	"Partch Otonality 1 in Harry Partch 43-tone just intonation: 1/1 9/8 5/4 11/8 3/2 7/4, in semitones rounded to the cent. From SuperCollider Scale.partch_o1"
	^ #( 0 2.04 3.86 5.51 7.02 9.69 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch02 [

"Partch Otonality 2 in Harry Partch 43-tone just intonation: 1/1 10/9 11/9 4/3 14/9 16/9, in semitones rounded to the cent. From SuperCollider Scale.partch_o2"
	^ #( 0 1.82 3.47 4.98 7.65 9.96 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch03 [ 

	"Partch Otonality 3 in Harry Partch 43-tone just intonation: 1/1 11/10 6/5 7/5 8/5 9/5, in semitones rounded to the cent. From SuperCollider Scale.partch_o3"
	^ #( 0 1.65 3.16 5.83 8.14 10.18 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch04 [

"Partch Otonality 4 in Harry Partch 43-tone just intonation: 1/1 12/11 14/11 16/11 18/11 20/11, in semitones rounded to the cent. From SuperCollider Scale.partch_o4"
	^ #( 0 1.51 4.18 6.49 8.53 10.35 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partch05 [

"Partch Otonality 5 in Harry Partch 43-tone just intonation: 1/1 7/6 4/3 3/2 5/3 11/6, in semitones rounded to the cent. From SuperCollider Scale.partch_o5"
	^ #( 0 2.67 4.98 7.02 8.84 10.49 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU1 [

"Partch Utonality 1 in Harry Partch 43-tone just intonation: 1/1 8/7 4/3 16/11 8/5 16/9, in semitones rounded to the cent. From SuperCollider Scale.partch_u1"
	^ #( 0 2.31 4.98 6.49 8.14 9.96 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU2 [

"Partch Utonality 2 in Harry Partch 43-tone just intonation: 1/1 9/8 9/7 3/2 18/11 9/5, in semitones rounded to the cent. From SuperCollider Scale.partch_u2"
	^ #( 0 2.04 4.35 7.02 8.53 10.18 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU3 [

	"Partch Utonality 3 in Harry Partch 43-tone just intonation: 1/1 10/9 5/4 10/7 5/3 20/11, in semitones rounded to the cent. From SuperCollider Scale.partch_u3"
	^ #( 0 1.82 3.86 6.17 8.84 10.35 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU4 [

	"Partch Utonality 4 in Harry Partch 43-tone just intonation: 1/1 11/10 11/9 11/8 11/7 11/6, in semitones rounded to the cent. From SuperCollider Scale.partch_u4"
	^ #( 0 1.65 3.47 5.51 7.82 10.49 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU5 [

	"Partch Utonality 5 in Harry Partch 43-tone just intonation: 1/1 12/11 6/5 4/3 3/2 12/7, in semitones rounded to the cent. From SuperCollider Scale.partch_u5"
	^ #( 0 1.51 3.16 4.98 7.02 9.33 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> partchU6 [ 
	"Partch Utonality 6 in Harry Partch 43-tone just intonation: 1/1 7/6 14/11 7/5 14/9 7/4, in semitones rounded to the cent. From SuperCollider Scale.partch_u6"
	^ #( 0 2.67 4.18 5.83 7.65 9.69 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> pelog [
	"Pelog, heptatonic (seven-note) tuning system used in Indonesian gamelan music, particularly in the traditions of Java and Bali. From SuperCollider Scale.pelog"

	^ #( 0 1 3 7 8 )
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
Scale class >> phrygian [ 

	^ #( 0 1 3 5 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> phrygianHex [ 

"Hex Phrygian, hexatonic mode with no tritone. From SuperCollider Scale.hexPhrygian"
	^ #( 0 1 3 5 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> prometheus [ 

"Prometheus,  hexatonic (six-note) musical scale derived from the mystic chord, a pitch collection made famous by Russian composer Alexander Scriabin in his symphonic poem Prometheus: The Poem of Fire From SuperCollider Scale.prometheus"
	^ #( 0 2 4 6 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> purvi [ 
"Purvi, raga mode. From SuperCollider Scale.purvi"
	^ #( 0 1 4 6 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> rast [ 

	"Rast, Arabic maqam of the rast family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.rast"
	^ #( 0 2 3.5 5 7 9 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> rastDesc [ 

"Rast Descending, Arabic maqam of the rast family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.rastDesc"
	^ #( 0 2 3.5 5 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> ritusen [ 


	"Ritusen, another mode of the major pentatonic. From SuperCollider Scale.ritusen"
	^ #( 0 2 5 7 9 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> romanianMinor [ 

"Romanian Minor. From SuperCollider Scale.romanianMinor"
	^ #( 0 2 3 6 7 9 10 )
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
Scale class >> shang [ 

"Shang, Han Chinese pentatonic scale. From SuperCollider Scale.shang"
	^ #( 0 2 5 7 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> shawqAfza [ 
	"Shawq Afza, Arabic maqam of the ajam family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.shawqAfza"
	^ #( 0 2 4 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> sikah [ 

"Sikah, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. Ascending form, the descending one is Scale sikahDesc. From SuperCollider Scale.sikah"
	^ #( 0 1.5 3.5 5.5 7 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> sikahDesc [ 


"Sikah Descending, Arabic maqam of the sikah family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.sikahDesc"
	^ #( 0 1.5 3.5 5.5 6.5 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> spanish [ 

^ #( 0 1 4 5 7 8 10 ) 
]

{ #category : 'creating - withoutRoot' }
Scale class >> susHex [ 

"Hex Sus, hexatonic mode with no tritone. From SuperCollider Scale.hexSus"
	^ #( 0 2 5 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> suznak [ 

"Suznak, Arabic maqam of the rast family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.suznak"
	^ #( 0 2 3.5 5 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> todi [ 

"Todi, raga mode. From SuperCollider Scale.todi"
	^ #( 0 1 3 6 7 8 11 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> ushaqMashri [ 
	"Ushaq Mashri, Arabic maqam of the nahawand family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.ushaqMashri"
	^ #( 0 2 3 5 7 8.5 10.5 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> whole [ 

"Whole Tone. From SuperCollider Scale.whole"
	^ #( 0 2 4 6 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> yakah [ 

"Yakah, Arabic maqam of the rast family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.yakah"
	^ #( 0 2 3.5 5 7 9 10.5 )
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

{ #category : 'creating - withoutRoot' }
Scale class >> yu [ 

"Yu, Han Chinese pentatonic scale. From SuperCollider Scale.yu"
	^ #( 0 3 5 7 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> zamzam [ 

"Zamzam, Arabic maqam of the saba family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.zamzam"
	^ #( 0 1 3 4 7 8 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> zanjaran [ 

	"Zanjaran, Arabic maqam of the hijaz family in 24-TET: x.5 is a quarter tone. From SuperCollider Scale.zanjaran"
	^ #( 0 1 4 5 7 9 10 )
]

{ #category : 'creating - withoutRoot' }
Scale class >> zhi [ 

"Zhi, Han Chinese pentatonic scale. From SuperCollider Scale.zhi"
	^ #( 0 2 5 7 9 )
]
