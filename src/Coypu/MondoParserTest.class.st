Class {
	#name : 'MondoParserTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
MondoParserTest >> setUp [

	super setUp.
	Performance uniqueInstance performer: PerformerLocal new
	
]

{ #category : 'tests' }
MondoParserTest >> testAlternationChoice [
	| alt |
	alt := MondoAlternation choices: #('a' 'b' 'c').
	self assert: (alt chooseForCycle: 1 slot: 1) equals: 'a'.
	self assert: (alt chooseForCycle: 2 slot: 1) equals: 'b'.
	self assert: (alt chooseForCycle: 4 slot: 1) equals: 'a'.
]

{ #category : 'tests' }
MondoParserTest >> testAlternationDivisorIsOne [
	"alternation leaves should produce divisor = 1, not the alternation object"
	| seq |
	seq := '<60 70>' asMondoNotes.
	self assert: seq divisors equals: #(1).
]

{ #category : 'tests' }
MondoParserTest >> testAlternationInContext [
	| seq |
	seq := '60 <70 80> 90' asMondoNotes.
	seq resolveCycle: 1.
	self assert: seq notes equals: #(60 70 90).
	seq resolveCycle: 2.
	self assert: seq notes equals: #(60 80 90).
]

{ #category : 'tests' }
MondoParserTest >> testAlternationLCM [
	| seq |
	seq := '<60 70> <80 90 100>' asMondoNotes.
	self assert: seq resolvedCycles size equals: 6
]

{ #category : 'tests' }
MondoParserTest >> testAlternationPeriod [

	| seq |
	seq := '<60 70>' asMondoNotes.
	self assert: seq resolvedCycles size equals: 2.
	self assert: seq resolvedCycles first equals: #( 60 ).
	self assert: (seq resolvedCycles at: 2) equals: #( 70 )
]

{ #category : 'tests' }
MondoParserTest >> testAlternationResolvesNotesAcrossCycles [
	| seq |
	seq := '<60 70 80>' asMondoNotes.
	seq resolveCycle: 1.
	self assert: (seq notes at: 1) equals: 60.
	seq resolveCycle: 2.
	self assert: (seq notes at: 1) equals: 70.
	seq resolveCycle: 3.
	self assert: (seq notes at: 1) equals: 80.
	seq resolveCycle: 4.
	self assert: (seq notes at: 1) equals: 60.  "wraps"
]

{ #category : 'tests' }
MondoParserTest >> testAlternationRestWithSpeed [
	| seq |
	seq := '<c6 ~>*4' asMondoNotes.
	seq resolveCycle: 1.
	self assert: seq gates equals: #(1 0 1 0).
	self assert: (seq notes first) equals: 84.
	seq resolveCycle: 2.
	"speed 4, choices 2 → period collapses; cycle 2 == cycle 1"
	self assert: seq gates equals: #(1 0 1 0)
]

{ #category : 'tests' }
MondoParserTest >> testAlternationSpeed [
	| seq |
	seq := '<60 70>*4' asMondoNotes.
	self assert: seq resolvedCycles size equals: 1.
	self assert: (seq resolvedCycles at: 1) equals: #(60 70 60 70)
]

{ #category : 'tests' }
MondoParserTest >> testAlternationSpeedShift [
	| seq |
	seq := '<60 70>*3' asMondoNotes.
	self assert: seq resolvedCycles size equals: 2.
	self assert: (seq resolvedCycles first) equals: #(60 70 60).
	self assert: (seq resolvedCycles at: 2) equals: #(70 60 70)
]

{ #category : 'tests' }
MondoParserTest >> testAlternationWithRest [
	| seq |
	seq := '<c6 ~>' asMondoNotes.
	seq resolveCycle: 1.
	self assert: (seq gates at: 1) equals: 1.
	self assert: (seq notes at: 1) equals: 84.   "c6 = 84"
	seq resolveCycle: 2.
	self assert: (seq gates at: 1) equals: 0.   "rest, no fire"
]

{ #category : 'tests' }
MondoParserTest >> testAlternationWithSpeed [
	| alt |
	alt := MondoAlternation choices: #('a' 'b' 'c') speed: 3.
	self assert: (alt chooseForCycle: 1 slot: 1) equals: 'a'.
	self assert: (alt chooseForCycle: 1 slot: 2) equals: 'b'.
	self assert: (alt chooseForCycle: 1 slot: 3) equals: 'c'.
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoNotes [
    | seq |
    seq := 'c4 [e4*3] [g4 b4]' asMondoNotes.
    self assert: seq cycleLengths equals: #(3 9 9 9 6 6).
    self assert: seq notes size equals: 6.
    self assert: seq gates size equals: 6.
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoNotesWithAlternation [
	| seq |
	seq := '<60 70>' asMondoNotes.
	seq resolveCycle: 1.
	self assert: (seq notes at: 1) equals: 60.
	seq resolveCycle: 2.
	self assert: (seq notes at: 1) equals: 70.
	seq resolveCycle: 3.
	self assert: (seq notes at: 1) equals: 60
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSounds [

	| seq |
	seq := 'bd [sd:2*3] [cp ht]' asMondoSounds.
	self assert: seq notes size equals: 6.
	self assert: seq notes  equals: #(60 60 60 60 60 60).
	
	self assert: seq cycleLengths equals: #( 3 9 9 9 6 6 )
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsAlternationResolves [

	| seq |
	seq := '<bd cp>' asMondoSounds.
	seq resolveCycle: 1.
	self assert: (seq phaustoGateDestinations first) equals: 'bdTrigger'.
	seq resolveCycle: 2.
	self assert: (seq phaustoGateDestinations first) equals: 'cpTrigger'
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsAlternationWithRest [
	| seq |
	seq := '<bd ~>' asMondoSounds.
	seq resolveCycle: 1.
	self assert: (seq gates at: 1) equals: 1.
	self assert: (seq phaustoGateDestinations at: 1) equals: 'bdTrigger'.
	seq resolveCycle: 2.
	self assert: (seq gates at: 1) equals: 0
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsAlternationWithSpeed [
	| seq |
	seq := '<bd cp>*4' asMondoSounds.
	seq resolveCycle: 1.
	self assert: seq phaustoGateDestinations equals: #('bdTrigger' 'cpTrigger' 'bdTrigger' 'cpTrigger')

]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsDefaultIndex [
    | seq |
    seq := 'bd cp' asMondoSounds.
    self assert: seq notes equals: #(60 60).

]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsMixedFixedAndAlternation [
	| seq |
	seq := 'bd <cp sn>' asMondoSounds.
	seq resolveCycle: 1.
	self assert: seq phaustoGateDestinations equals: #('bdTrigger' 'cpTrigger').
	seq resolveCycle: 2.
	self assert: seq phaustoGateDestinations equals: #('bdTrigger' 'snTrigger')
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsPhaustoDestinations [
    | seq |
    seq := 'bd [sd*3] cp' asMondoSounds.
    self assert: (seq phaustoGateDestinations includes: 'bdTrigger').
    self assert: (seq phaustoGateDestinations includes: 'sdTrigger').
    self assert: (seq phaustoGateDestinations includes: 'cpTrigger').
    self assert: (seq phaustoNoteDestinations includes: 'bdFreq').
    self assert: (seq phaustoNoteDestinations includes: 'sdFreq').
    self assert: (seq phaustoNoteDestinations includes: 'cpFreq').
]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsWithDivisor [
    | seq |
    seq := 'bd sd/4 cp' asMondoSounds.
    self assert: seq divisors equals: #(1 4 1).
    self assert: seq notes size equals: 3.
]

{ #category : 'tests' }
MondoParserTest >> testMondoOverridesDefaults [
	| seq |
	seq := 'c4 [e4*3] [g4 b4]' asMondoNotes.
	self assert: seq cycleLengths equals: #(3 9 9 9 6 6)
]

{ #category : 'tests' }
MondoParserTest >> testNoAlternationSkipsResolution [
	| seq |
	seq := '60 70 80' asMondoNotes.
	self assert: seq resolvedCycles isNil
]

{ #category : 'tests' }
MondoParserTest >> testParseAlternation [
	| leaves leafValue alt |
	leaves := '<bd cp>' parseMondoLeaves.
	self assert: leaves size equals: 1.
	leafValue := leaves first value.
	self assert: leafValue isArray.
	alt := leafValue first.
	self assert: alt class equals: MondoAlternation.
	self assert: alt choices equals: #( 'bd' 'cp' ).
	self assert: alt speed equals: 1.
	self assert: leafValue second equals: 1   "slot index"
]

{ #category : 'tests' }
MondoParserTest >> testParseAlternationWithSpeed [
	| leaves alt |
	leaves := '<bd cp hh>*8' parseMondoLeaves.
	self assert: leaves size equals: 8.   "speed=8 produces 8 leaves"
	alt := leaves first value first.
	self assert: alt choices equals: #('bd' 'cp' 'hh').
	self assert: alt speed equals: 8
]

{ #category : 'tests' }
MondoParserTest >> testParseMondoLeaves [
    self assert: ('bd' parseMondoLeaves) asArray equals: { 'bd' -> 1 }.
    self assert: ('[sd*3]' parseMondoLeaves) asArray equals: { 'sd' -> 1. 'sd' -> 1. 'sd' -> 1 }.
    self assert: ('[cp [ht lt]]' parseMondoLeaves) asArray equals: { 'cp' -> 1. 'ht' -> 1. 'lt' -> 1 }.
    self assert: ('[~ bd]' parseMondoLeaves) asArray equals: { '~' -> 1. 'bd' -> 1 }.
]

{ #category : 'tests' }
MondoParserTest >> testParseMondoLeavesBracketMultiply [
	self assert: ('[sd lt]*3' parseMondoLeaves) asArray
		equals: { 'sd'->1. 'lt'->1. 'sd'->1. 'lt'->1. 'sd'->1. 'lt'->1 }.
	self assert: ('cp [sd lt]*3' parseMondoLeaves) asArray
		equals: { 'cp'->1. 'sd'->1. 'lt'->1. 'sd'->1. 'lt'->1. 'sd'->1. 'lt'->1 }
]

{ #category : 'tests' }
MondoParserTest >> testResolveLookup [
	| seq |
	seq := '<60 70 80>' asMondoNotes.
	seq resolveCycle: 1.
	self assert: (seq notes at: 1) equals: 60.
	seq resolveCycle: 5.
	self assert: (seq notes at: 1) equals: 70
]

{ #category : 'tests' }
MondoParserTest >> testRhythmBuilderInheritsDefaults [
	| seq |
	seq := 8 adowa.
	self assert: seq cycleLengths size equals: 16.
	self assert: (seq cycleLengths allSatisfy: [ :each | each = 16 ]).
	self assert: (seq divisors allSatisfy: [ :each | each = 1 ])
]

{ #category : 'tests' }
MondoParserTest >> testRhythmBuilderPlaysCyclically [
	"A rhythm builder seq with default cycleLengths should produce events when queried"
	| seq events |
	seq := 8 adowa.
	events := seq queryFrom: 0 to: 1 cycle: 1.
	self assert: events notEmpty
]

{ #category : 'tests' }
MondoParserTest >> testSequencerDefaultCycleLengths [
	| seq |
	seq := Sequencer new.
	self assert: seq cycleLengths equals: (Array new: 16 withAll: 16).
	self assert: seq divisors equals: (Array new: 16 withAll: 1)
]

{ #category : 'tests' }
MondoParserTest >> testSplitTopLevelSlots [
    self assert: ('bd sd cp' splitTopLevelSlots) asArray equals: #('bd' 'sd' 'cp').
    self assert: ('bd [sd*3] cp' splitTopLevelSlots) asArray equals: #('bd' '[sd*3]' 'cp').
    self assert: ('bd [cp [ht lt]]' splitTopLevelSlots) asArray equals: #('bd' '[cp [ht lt]]').

]
