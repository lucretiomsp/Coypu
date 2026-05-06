Class {
	#name : 'TidalParserTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
TidalParserTest >> testAsTidalNotes [
    | seq |
    seq := 'c4 [e4*3] [g4 b4]' asTidalNotes.
    self assert: seq cycleLengths equals: #(1 3 2).
    self assert: seq notes size equals: 6.
    self assert: seq gates size equals: 6.

]

{ #category : 'tests' }
TidalParserTest >> testParseTidalLeaves [
    self assert: ('bd' parseTidalLeaves) asArray equals: #('bd').
    self assert: ('[sd*3]' parseTidalLeaves) asArray equals: #('sd' 'sd' 'sd').
    self assert: ('[cp [ht lt]]' parseTidalLeaves) asArray equals: #('cp' 'ht' 'lt').
    self assert: ('[~ bd]' parseTidalLeaves) asArray equals: #('~' 'bd').
]

{ #category : 'tests' }
TidalParserTest >> testSplitTopLevelSlots [
    self assert: ('bd sd cp' splitTopLevelSlots) asArray equals: #('bd' 'sd' 'cp').
    self assert: ('bd [sd*3] cp' splitTopLevelSlots) asArray equals: #('bd' '[sd*3]' 'cp').
    self assert: ('bd [cp [ht lt]]' splitTopLevelSlots) asArray equals: #('bd' '[cp [ht lt]]').

]
