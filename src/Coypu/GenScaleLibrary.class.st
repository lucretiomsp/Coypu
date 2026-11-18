"
I am the registry of scales: the 108 scales of SuperCollider's ScaleInfo with the same keys (twelve-tone, Partch 43-tone just intonation and 24-tone maqamat).

Scales whose melody uses other notes on the way down (melodicMinor, sikah, nahawand, rast, yakah, hijaz) carry their descending form. The separate Desc scales stay available on their own, as in SuperCollider.

I am a lazily created shared instance (Registry and Singleton).

Examples:
	GenScaleLibrary default at: #dorian.
	GenScaleLibrary default randomScale: Random new.
	GenScaleLibrary default keys.
"
Class {
	#name : 'GenScaleLibrary',
	#superclass : 'Object',
	#instVars : [
		'scales',
		'keys'
	],
	#classInstVars : [
		'default'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenScaleLibrary class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : 'initialization' }
GenScaleLibrary class >> reset [
	"Forget the shared instance, for example after editing the definitions."

	default := nil
]

{ #category : 'adding' }
GenScaleLibrary >> add: aScale [

	(scales includesKey: aScale key) ifFalse: [ keys add: aScale key ].
	scales at: aScale key put: aScale.
	^ aScale
]

{ #category : 'adding' }
GenScaleLibrary >> addDefinitions: aCollection tuning: aTuning [
	"Each definition is #( key 'Name' degrees ) or #( key 'Name' degrees descendingDegrees )."

	aCollection do: [ :each |
		self add: (GenScale
				 key: each first
				 name: each second
				 degrees: each third
				 descending: (each size > 3
						  ifTrue: [ each fourth ]
						  ifFalse: [ nil ])
				 tuning: aTuning) ]
]

{ #category : 'accessing' }
GenScaleLibrary >> at: aSymbol [

	^ scales at: aSymbol
]

{ #category : 'accessing' }
GenScaleLibrary >> at: aSymbol ifAbsent: aBlock [

	^ scales at: aSymbol ifAbsent: aBlock
]

{ #category : 'testing' }
GenScaleLibrary >> includesKey: aSymbol [

	^ scales includesKey: aSymbol
]

{ #category : 'initialization' }
GenScaleLibrary >> initialize [

	super initialize.
	scales := Dictionary new.
	keys := OrderedCollection new.
	self
		addDefinitions: self twelveToneDefinitions tuning: GenTuning et12;
		addDefinitions: self partchDefinitions tuning: GenTuning partch;
		addDefinitions: self quarterToneDefinitions tuning: GenTuning et24
]

{ #category : 'accessing' }
GenScaleLibrary >> keys [
	"In definition order."

	^ keys asArray
]

{ #category : 'definitions' }
GenScaleLibrary >> partchDefinitions [
	"SuperCollider ScaleInfo: Partch's otonalities and utonalities, steps of the 43-tone tuning."

	^ #(
		#( #partch_o1 'Partch Otonality 1' #( 0 8 14 20 25 34 ) )
		#( #partch_o2 'Partch Otonality 2' #( 0 7 13 18 27 35 ) )
		#( #partch_o3 'Partch Otonality 3' #( 0 6 12 21 29 36 ) )
		#( #partch_o4 'Partch Otonality 4' #( 0 5 15 23 30 37 ) )
		#( #partch_o5 'Partch Otonality 5' #( 0 10 18 25 31 38 ) )
		#( #partch_o6 'Partch Otonality 6' #( 0 9 16 22 28 33 ) )
		#( #partch_u1 'Partch Utonality 1' #( 0 9 18 23 29 35 ) )
		#( #partch_u2 'Partch Utonality 2' #( 0 8 16 25 30 36 ) )
		#( #partch_u3 'Partch Utonality 3' #( 0 7 14 22 31 37 ) )
		#( #partch_u4 'Partch Utonality 4' #( 0 6 13 20 28 38 ) )
		#( #partch_u5 'Partch Utonality 5' #( 0 5 12 18 25 33 ) )
		#( #partch_u6 'Partch Utonality 6' #( 0 10 15 21 27 34 ) ) )
]

{ #category : 'definitions' }
GenScaleLibrary >> quarterToneDefinitions [
	"SuperCollider ScaleInfo: 24 tones per octave, steps are quarter tones."

	^ #(
		#( #chromatic24 'Chromatic 24' #( 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 ) )
		#( #ajam 'Ajam' #( 0 4 8 10 14 18 22 ) )
		#( #jiharkah 'Jiharkah' #( 0 4 8 10 14 18 21 ) )
		#( #shawqAfza 'Shawq Afza' #( 0 4 8 10 14 16 22 ) )
		#( #sikah 'Sikah' #( 0 3 7 11 14 17 21 ) #( 0 3 7 11 13 17 21 ) )
		#( #sikahDesc 'Sikah Descending' #( 0 3 7 11 13 17 21 ) )
		#( #huzam 'Huzam' #( 0 3 7 9 15 17 21 ) )
		#( #iraq 'Iraq' #( 0 3 7 10 13 17 21 ) )
		#( #bastanikar 'Bastanikar' #( 0 3 7 10 13 15 21 ) )
		#( #mustar 'Mustar' #( 0 5 7 11 13 17 21 ) )
		#( #bayati 'Bayati' #( 0 3 6 10 14 16 20 ) )
		#( #karjighar 'Karjighar' #( 0 3 6 10 12 18 20 ) )
		#( #husseini 'Husseini' #( 0 3 6 10 14 17 21 ) )
		#( #nahawand 'Nahawand' #( 0 4 6 10 14 16 22 ) #( 0 4 6 10 14 16 20 ) )
		#( #nahawandDesc 'Nahawand Descending' #( 0 4 6 10 14 16 20 ) )
		#( #farahfaza 'Farahfaza' #( 0 4 6 10 14 16 20 ) )
		#( #murassah 'Murassah' #( 0 4 6 10 12 18 20 ) )
		#( #ushaqMashri 'Ushaq Mashri' #( 0 4 6 10 14 17 21 ) )
		#( #rast 'Rast' #( 0 4 7 10 14 18 21 ) #( 0 4 7 10 14 18 20 ) )
		#( #rastDesc 'Rast Descending' #( 0 4 7 10 14 18 20 ) )
		#( #suznak 'Suznak' #( 0 4 7 10 14 16 22 ) )
		#( #nairuz 'Nairuz' #( 0 4 7 10 14 17 20 ) )
		#( #yakah 'Yakah' #( 0 4 7 10 14 18 21 ) #( 0 4 7 10 14 18 20 ) )
		#( #yakahDesc 'Yakah Descending' #( 0 4 7 10 14 18 20 ) )
		#( #mahur 'Mahur' #( 0 4 7 10 14 18 22 ) )
		#( #hijaz 'Hijaz' #( 0 2 8 10 14 17 20 ) #( 0 2 8 10 14 16 20 ) )
		#( #hijazDesc 'Hijaz Descending' #( 0 2 8 10 14 16 20 ) )
		#( #zanjaran 'Zanjaran' #( 0 2 8 10 14 18 20 ) )
		#( #hijazKar 'Hijaz Kar' #( 0 2 8 10 14 16 22 ) )
		#( #saba 'Saba' #( 0 3 6 8 12 16 20 ) )
		#( #zamzam 'Zamzam' #( 0 2 6 8 14 16 20 ) )
		#( #kurd 'Kurd' #( 0 2 6 10 14 16 20 ) )
		#( #kijazKarKurd 'Kijaz Kar Kurd' #( 0 2 8 10 14 16 22 ) )
		#( #nawaAthar 'Nawa Athar' #( 0 4 6 12 14 16 22 ) )
		#( #nikriz 'Nikriz' #( 0 4 6 12 14 18 20 ) )
		#( #atharKurd 'Athar Kurd' #( 0 2 6 12 14 16 22 ) ) )
]

{ #category : 'accessing' }
GenScaleLibrary >> randomScale: aRandom [

	^ self at: (keys at: (aRandom nextInteger: keys size))
]

{ #category : 'accessing' }
GenScaleLibrary >> scales [
	"In definition order."

	^ keys asArray collect: [ :each | scales at: each ]
]

{ #category : 'accessing' }
GenScaleLibrary >> size [

	^ keys size
]

{ #category : 'definitions' }
GenScaleLibrary >> twelveToneDefinitions [
	"SuperCollider ScaleInfo: twelve tones per octave."

	^ #(
		#( #minorPentatonic 'Minor Pentatonic' #( 0 3 5 7 10 ) )
		#( #majorPentatonic 'Major Pentatonic' #( 0 2 4 7 9 ) )
		#( #ritusen 'Ritusen' #( 0 2 5 7 9 ) )
		#( #egyptian 'Egyptian' #( 0 2 5 7 10 ) )
		#( #kumoi 'Kumai' #( 0 2 3 7 9 ) )
		#( #hirajoshi 'Hirajoshi' #( 0 2 3 7 8 ) )
		#( #iwato 'Iwato' #( 0 1 5 6 10 ) )
		#( #chinese 'Chinese' #( 0 4 6 7 11 ) )
		#( #indian 'Indian' #( 0 4 5 7 10 ) )
		#( #pelog 'Pelog' #( 0 1 3 7 8 ) )
		#( #prometheus 'Prometheus' #( 0 2 4 6 11 ) )
		#( #scriabin 'Scriabin' #( 0 1 4 7 9 ) )
		#( #gong 'Gong' #( 0 2 4 7 9 ) )
		#( #shang 'Shang' #( 0 2 5 7 10 ) )
		#( #jiao 'Jiao' #( 0 3 5 8 10 ) )
		#( #zhi 'Zhi' #( 0 2 5 7 9 ) )
		#( #yu 'Yu' #( 0 3 5 7 10 ) )
		#( #whole 'Whole Tone' #( 0 2 4 6 8 10 ) )
		#( #augmented 'Augmented' #( 0 3 4 7 8 11 ) )
		#( #augmented2 'Augmented 2' #( 0 1 4 5 8 9 ) )
		#( #hexMajor7 'Hex Major 7' #( 0 2 4 7 9 11 ) )
		#( #hexDorian 'Hex Dorian' #( 0 2 3 5 7 10 ) )
		#( #hexPhrygian 'Hex Phrygian' #( 0 1 3 5 8 10 ) )
		#( #hexSus 'Hex Sus' #( 0 2 5 7 9 10 ) )
		#( #hexMajor6 'Hex Major 6' #( 0 2 4 5 7 9 ) )
		#( #hexAeolian 'Hex Aeolian' #( 0 3 5 7 8 10 ) )
		#( #major 'Major' #( 0 2 4 5 7 9 11 ) )
		#( #ionian 'Ionian' #( 0 2 4 5 7 9 11 ) )
		#( #dorian 'Dorian' #( 0 2 3 5 7 9 10 ) )
		#( #phrygian 'Phrygian' #( 0 1 3 5 7 8 10 ) )
		#( #lydian 'Lydian' #( 0 2 4 6 7 9 11 ) )
		#( #mixolydian 'Mixolydian' #( 0 2 4 5 7 9 10 ) )
		#( #aeolian 'Aeolian' #( 0 2 3 5 7 8 10 ) )
		#( #minor 'Natural Minor' #( 0 2 3 5 7 8 10 ) )
		#( #locrian 'Locrian' #( 0 1 3 5 6 8 10 ) )
		#( #harmonicMinor 'Harmonic Minor' #( 0 2 3 5 7 8 11 ) )
		#( #harmonicMajor 'Harmonic Major' #( 0 2 4 5 7 8 11 ) )
		#( #melodicMinor 'Melodic Minor' #( 0 2 3 5 7 9 11 ) #( 0 2 3 5 7 8 10 ) )
		#( #melodicMinorDesc 'Melodic Minor Descending' #( 0 2 3 5 7 8 10 ) )
		#( #melodicMajor 'Melodic Major' #( 0 2 4 5 7 8 10 ) )
		#( #bartok 'Bartok' #( 0 2 4 5 7 8 10 ) )
		#( #hindu 'Hindu' #( 0 2 4 5 7 8 10 ) )
		#( #todi 'Todi' #( 0 1 3 6 7 8 11 ) )
		#( #purvi 'Purvi' #( 0 1 4 6 7 8 11 ) )
		#( #marva 'Marva' #( 0 1 4 6 7 9 11 ) )
		#( #bhairav 'Bhairav' #( 0 1 4 5 7 8 11 ) )
		#( #ahirbhairav 'Ahirbhairav' #( 0 1 4 5 7 9 10 ) )
		#( #superLocrian 'Super Locrian' #( 0 1 3 4 6 8 10 ) )
		#( #romanianMinor 'Romanian Minor' #( 0 2 3 6 7 9 10 ) )
		#( #hungarianMinor 'Hungarian Minor' #( 0 2 3 6 7 8 11 ) )
		#( #neapolitanMinor 'Neapolitan Minor' #( 0 1 3 5 7 8 11 ) )
		#( #enigmatic 'Enigmatic' #( 0 1 4 6 8 10 11 ) )
		#( #spanish 'Spanish' #( 0 1 4 5 7 8 10 ) )
		#( #leadingWhole 'Leading Whole Tone' #( 0 2 4 6 8 10 11 ) )
		#( #lydianMinor 'Lydian Minor' #( 0 2 4 6 7 8 10 ) )
		#( #neapolitanMajor 'Neapolitan Major' #( 0 1 3 5 7 9 11 ) )
		#( #locrianMajor 'Locrian Major' #( 0 2 4 5 6 8 10 ) )
		#( #diminished 'Diminished' #( 0 1 3 4 6 7 9 10 ) )
		#( #diminished2 'Diminished 2' #( 0 2 3 5 6 8 9 11 ) )
		#( #chromatic 'Chromatic' #( 0 1 2 3 4 5 6 7 8 9 10 11 ) ) )
]
