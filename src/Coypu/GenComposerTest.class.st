"
Tests for GenComposer, the whole pipeline.
"
Class {
	#name : 'GenComposerTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenComposerTest >> composer [

	^ GenComposer new
		  seed: 42;
		  bars: 2;
		  yourself
]

{ #category : 'tests' }
GenComposerTest >> testAFixedScale [

	| piece |
	piece := self composer
		         scale: #dorian root: 2;
		         compose.
	self assert: piece scale key equals: #dorian.
	piece lanes do: [ :lane |
		lane midiNotes do: [ :each | self assert: (#( 2 4 5 7 9 11 0 ) includes: each \\ 12) ] ]
]

{ #category : 'tests' }
GenComposerTest >> testComposeBuildsThreeLanesBottomUp [

	| piece |
	piece := self composer compose.
	self assert: (piece lanes collect: [ :each | each role ]) equals: #( #bass #mid #lead ).
	self assert: piece progression size equals: 2.
	self assert: (piece lanes allSatisfy: [ :each | each length = 32 ]).
	self assert: piece bass identicalTo: piece lanes first
]

{ #category : 'tests' }
GenComposerTest >> testDescendingFormsAreRespected [

	| piece |
	piece := self composer
		         scale: #melodicMinor root: 0;
		         compose.
	piece lanes do: [ :lane |
		| previous |
		previous := nil.
		lane pitches do: [ :each |
			(previous isNil or: [ each midi > previous midi ]) ifTrue: [ self assert: each isAscendingForm ].
			(previous notNil and: [ each midi < previous midi ]) ifTrue: [ self assert: each isDescendingForm ].
			previous := each ] ]
]

{ #category : 'tests' }
GenComposerTest >> testLaneAsSequencer [

	| piece |
	piece := self composer compose.
	piece lanes with: piece sequencers do: [ :lane :seq |
		self assert: seq gates asArray equals: lane gates asArray.
		self assert: seq numberOfGates equals: lane events size.
		self assert: seq notes asArray equals: lane midiNotes asArray.
		self assert: seq durations asArray equals: lane durations asArray ]
]

{ #category : 'tests' }
GenComposerTest >> testLanesOfDifferentLengths [

	| piece |
	piece := self composer
		         length: 13 for: #lead;
		         length: 12 for: #mid;
		         compose.
	self assert: piece lead length equals: 13.
	self assert: piece mid length equals: 12.
	self assert: piece bass length equals: 32
]

{ #category : 'tests' }
GenComposerTest >> testMicrotonalScalesCompose [

	#( #rast #partch_u1 #chromatic24 #hirajoshi ) do: [ :key |
		| piece allowed |
		piece := self composer
			         scale: key root: 4;
			         compose.
		allowed := (piece context pitchesFrom: 0 to: 127) collect: [ :each | each midi ].
		piece lanes do: [ :lane |
			lane midiNotes do: [ :each | self assert: (allowed includes: each) ] ] ]
]

{ #category : 'tests' }
GenComposerTest >> testPrinting [

	| piece |
	piece := self composer
		         scale: #major root: 0;
		         compose.
	self assert: (piece printString beginsWith: 'C Major').
	self assert: (piece bass printString beginsWith: 'bass: ')
]

{ #category : 'tests' }
GenComposerTest >> testRandomRhythmsOnly [

	(self composer
		 worldRhythmAmount: 0;
		 compose) lanes do: [ :lane | self assert: lane rhythm name equals: #random ]
]

{ #category : 'tests' }
GenComposerTest >> testStepArrayAndGates [

	| lane |
	lane := self composer compose lead.
	self assert: lane stepArray size equals: lane length.
	self assert: lane gates size equals: lane length.
	self assert: (lane stepArray select: [ :each | each notNil ]) equals: lane midiNotes.
	self assert: (lane gates inject: 0 into: [ :sum :each | sum + each ]) equals: lane events size
]

{ #category : 'tests' }
GenComposerTest >> testTheBassStartsEveryBarOnTheRootWhenAsked [

	| bass piece |
	bass := GenVoice
		        role: #bass
		        center: 40
		        range: 12
		        maxHold: 4
		        scorer: (GenCompositeFactor withAll: {
					         GenChordConsonanceFactor new.
					         (GenRootLandingFactor new
						          probability: 1;
						          missWeight: 0;
						          yourself).
					         (GenRegisterFactor center: 40 width: 6) }).
	piece := self composer
		         voices: {
				         bass.
				         GenVoice lead };
		         rhythm: (GenRhythmLibrary default at: #fourOnTheFloor) for: #bass;
		         compose.
	1 to: piece progression size do: [ :bar |
		self assert: ((piece progression chordAtBar: bar) rootMatches: (piece bass eventAtStep: bar - 1 * 16 + 1) pitch) ]
]

{ #category : 'tests' }
GenComposerTest >> testTheSameSeedGivesTheSamePiece [

	| first second |
	first := self composer compose.
	second := self composer compose.
	self assert: first scale equals: second scale.
	self assert: first context root equals: second context root.
	self assert: first progression equals: second progression.
	first lanes with: second lanes do: [ :a :b |
		self assert: a midiNotes equals: b midiNotes.
		self assert: a durations equals: b durations ]
]

{ #category : 'tests' }
GenComposerTest >> testVoicesStayInTheirRegisters [

	self composer compose lanes do: [ :lane |
		lane midiNotes do: [ :each |
			self assert: (each between: lane voice lowestMidi and: lane voice highestMidi) ] ]
]

{ #category : 'tests' }
GenComposerTest >> testWorldRhythmsOnly [

	(self composer
		 worldRhythmAmount: 1;
		 compose) lanes do: [ :lane |
		self assert: (GenRhythmLibrary default rhythms anySatisfy: [ :each |
				 (each fittedTo: lane length) = lane rhythm ]) ]
]
