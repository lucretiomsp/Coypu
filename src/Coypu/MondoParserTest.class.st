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
MondoParserTest >> testAsMondoNotes [
    | seq |
    seq := 'c4 [e4*3] [g4 b4]' asMondoNotes.
    self assert: seq cycleLengths equals: #(3 9 9 9 6 6).
    self assert: seq notes size equals: 6.
    self assert: seq gates size equals: 6.
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
MondoParserTest >> testAsMondoSoundsDefaultIndex [
    | seq |
    seq := 'bd cp' asMondoSounds.
    self assert: seq notes equals: #(60 60).

]

{ #category : 'tests' }
MondoParserTest >> testAsMondoSoundsWithDivisor [
    | seq |
    seq := 'bd sd/4 cp' asMondoSounds.
    self assert: seq divisors equals: #(1 4 1).
    self assert: seq notes size equals: 3.
]

{ #category : 'tests' }
MondoParserTest >> testParseMondoLeaves [
    self assert: ('bd' parseMondoLeaves) asArray equals: { 'bd' -> 1 }.
    self assert: ('[sd*3]' parseMondoLeaves) asArray equals: { 'sd' -> 1. 'sd' -> 1. 'sd' -> 1 }.
    self assert: ('[cp [ht lt]]' parseMondoLeaves) asArray equals: { 'cp' -> 1. 'ht' -> 1. 'lt' -> 1 }.
    self assert: ('[~ bd]' parseMondoLeaves) asArray equals: { '~' -> 1. 'bd' -> 1 }.
]

{ #category : 'tests' }
MondoParserTest >> testSplitTopLevelSlots [
    self assert: ('bd sd cp' splitTopLevelSlots) asArray equals: #('bd' 'sd' 'cp').
    self assert: ('bd [sd*3] cp' splitTopLevelSlots) asArray equals: #('bd' '[sd*3]' 'cp').
    self assert: ('bd [cp [ht lt]]' splitTopLevelSlots) asArray equals: #('bd' '[cp [ht lt]]').

]
