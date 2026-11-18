"
I am the registry of world rhythms (clave, tresillo, bembe...), written as step patterns (Registry and Singleton).

Examples:
	GenRhythmLibrary default at: #tresillo.
	GenRhythmLibrary default randomRhythmOfSize: 16 random: Random new.
"
Class {
	#name : 'GenRhythmLibrary',
	#superclass : 'Object',
	#instVars : [
		'rhythms'
	],
	#classInstVars : [
		'default'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'accessing' }
GenRhythmLibrary class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : 'definitions' }
GenRhythmLibrary class >> definitions [
	"x fires, . rests."

	^ #(
		#( #tresillo 'x..x..x.' )
		#( #habanera 'x..xx.x.' )
		#( #cinquillo 'x.xx.xx.' )
		#( #sonClave 'x..x..x...x.x...' )
		#( #sonClave23 '..x.x...x..x..x.' )
		#( #rumbaClave 'x..x...x..x.x...' )
		#( #bossaNova 'x..x..x...x..x..' )
		#( #shiko 'x...x.x...x.x...' )
		#( #soukous 'x..x..x...xx....' )
		#( #gahu 'x..x..x...x...x.' )
		#( #bembe 'x.x.xx.x.x.x' )
		#( #fumeFume 'x.x.x..x.x..' )
		#( #fourOnTheFloor 'x...x...x...x...' ) )
]

{ #category : 'initialization' }
GenRhythmLibrary class >> reset [

	default := nil
]

{ #category : 'adding' }
GenRhythmLibrary >> add: aRhythm [

	rhythms := rhythms copyWith: aRhythm.
	^ aRhythm
]

{ #category : 'accessing' }
GenRhythmLibrary >> at: aName [

	^ rhythms detect: [ :each | each name = aName ]
]

{ #category : 'initialization' }
GenRhythmLibrary >> initialize [

	super initialize.
	rhythms := self class definitions collect: [ :each |
		           GenRhythm named: each first pattern: each second ]
]

{ #category : 'accessing' }
GenRhythmLibrary >> names [

	^ rhythms collect: [ :each | each name ]
]

{ #category : 'accessing' }
GenRhythmLibrary >> randomRhythmOfSize: aSize random: aRandom [
	"Prefer rhythms that tile the lane exactly (an 8- or 16-step clave on 16 steps, bembe on 12); any rhythm when none does."

	| candidates |
	candidates := self rhythmsTiling: aSize.
	candidates isEmpty ifTrue: [ candidates := rhythms ].
	^ (candidates at: (aRandom nextInteger: candidates size)) fittedTo: aSize
]

{ #category : 'accessing' }
GenRhythmLibrary >> rhythms [

	^ rhythms
]

{ #category : 'accessing' }
GenRhythmLibrary >> rhythmsTiling: aSize [

	^ rhythms select: [ :each | aSize \\ each size = 0 ]
]

{ #category : 'accessing' }
GenRhythmLibrary >> size [

	^ rhythms size
]
