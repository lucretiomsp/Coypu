Class {
	#name : 'MondoParserTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
MondoParserTest >> testAsTidalNotes [
    | seq |
    seq := 'c4 [e4*3] [g4 b4]' asTidalNotes.
    self assert: seq cycleLengths equals: #(1 3 2).
    self assert: seq notes size equals: 6.
    self assert: seq gates size equals: 6.

]

{ #category : 'tests' }
MondoParserTest >> testAsTidalSounds [
    | seq |
    seq := 'bd [sd:2*3] [cp ht]' asTidalSounds.
    self assert: seq notes size equals: 6.
    self assert: (seq notes at: 1) equals: 0.
    self assert: (seq notes at: 2) equals: 2.
    self assert: seq cycleLengths equals: #(3 9 9 9 6 6).
]

{ #category : 'tests' }
MondoParserTest >> testAsTidalSoundsDefaultIndex [
    | seq |
    seq := 'bd cp' asTidalSounds.
    self assert: seq notes equals: #(0 0).

]

{ #category : 'tests' }
MondoParserTest >> testAsTidalSoundsWithDivisor [
    | seq |
    seq := 'bd sd/4 cp' asTidalSounds.
    self assert: seq divisors equals: #(1 4 1).
    self assert: seq notes size equals: 3.
]

{ #category : 'tests' }
MondoParserTest >> testParseTidalLeaves [
    self assert: ('bd' parseTidalLeaves) asArray equals: #('bd').
    self assert: ('[sd*3]' parseTidalLeaves) asArray equals: #('sd' 'sd' 'sd').
    self assert: ('[cp [ht lt]]' parseTidalLeaves) asArray equals: #('cp' 'ht' 'lt').
    self assert: ('[~ bd]' parseTidalLeaves) asArray equals: #('~' 'bd').
]

{ #category : 'tests' }
MondoParserTest >> testSplitTopLevelSlots [
    self assert: ('bd sd cp' splitTopLevelSlots) asArray equals: #('bd' 'sd' 'cp').
    self assert: ('bd [sd*3] cp' splitTopLevelSlots) asArray equals: #('bd' '[sd*3]' 'cp').
    self assert: ('bd [cp [ht lt]]' splitTopLevelSlots) asArray equals: #('bd' '[cp [ht lt]]').

]
