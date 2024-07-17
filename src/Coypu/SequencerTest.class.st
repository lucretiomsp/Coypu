Class {
	#name : 'SequencerTest',
	#superclass : 'TestCase',
	#instVars : [
		'sequencer'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
SequencerTest >> setUp [

	sequencer := 8 downbeats.
	

	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
SequencerTest >> testAddAssociationForDirtMesage [

| seq |
seq := 16 downbeats sound: 'cp'.
seq add: 'squiz'->#(0 1 2). 

self assert: (seq dirtMessage includesKey: #squiz) equals: true.
self assert: (seq dirtMessage includes: #( 0 1  2) ) equals: true.
]

{ #category : 'tests' }
SequencerTest >> testAddExtraParamsForKyma [

| seq |
seq := 16 downbeats extra: #Cutoff values: #(300 400 500).
self assert: seq gates  equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm .
self assert: (seq extraParams at: #Cutoff) equals: #(300 400 500).

]

{ #category : 'tests' }
SequencerTest >> testArpeggiateArray [

| initial  result|
initial := #(60 61 62 63).
result := #(60 61 62 63 61 62 63 64 62 63 64 65 63 64 65 66).

self assert: (initial arp: #(0 1 2 3)) equals: result
]

{ #category : 'tests' }
SequencerTest >> testAsPolySeq [

| monoseq polyseq |

monoseq := 16 downbeats.
polyseq  := monoseq asPolySeq.

self assert:  polyseq isPolySeq .   

self assert: polyseq gates equals: monoseq gates.
self assert: polyseq durations  equals: monoseq durations.
self assert: polyseq noteIndex  equals: monoseq noteIndex.
self assert: polyseq dirtMessage  equals: monoseq dirtMessage .
self assert: (polyseq dirtMessage includesKey: 'n') equals: false.

]

{ #category : 'tests' }
SequencerTest >> testChangeSequencerGatesSize [

	| seq |
	seq := 16 downbeats.
	seq gatesSize: 1.
	self assert: (seq gatesSize) equals: 1
]

{ #category : 'tests' }
SequencerTest >> testChords: aChordOrAnArrayOfChords [

| polySeq |
polySeq := 4 breves sound: 'superpiano'; chords: 'c-major d-minor e-major'. 

self assert: (polySeq dirtMessage at: 'n') equals: ( 'c-major d-minor e-major' chordsToArrays ).

]

{ #category : 'tests' }
SequencerTest >> testEuclideanRhythmFromArray [

	| tresillo seq |
	tresillo := #( 3 8) euclidean.
	seq := #( 1 0 0 1 0 0 1 0) asRhythm asSeq.
	self assert: tresillo equals: seq
]

{ #category : 'tests' }
SequencerTest >> testFlipSequencer [

	| tresillo seq |
	tresillo := #( 3 8 ) euclidean flip.
	seq := #( 0 1 1 0 1 1 0 1 ) asRhythm asSeq .
	self assert: tresillo equals: seq
]

{ #category : 'tests' }
SequencerTest >> testInitialize [
self assert: (Sequencer new orbit > 0) & (Sequencer new orbit < 12) equals: true
]

{ #category : 'tests' }
SequencerTest >> testReverse [

| seq |
seq := '000F' hexBeat sound: 'sd cp'; dirtNotes: #(1 2 3) .
self assert: seq reverse gates  equals: #( 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0) asRhythm .
self assert: (seq reverse dirtMessage at: 'n') equals: #( 3 2 1).
self assert: (seq reverse dirtMessage at: 's') equals: #('cp' 'sd').
]

{ #category : 'tests' }
SequencerTest >> testSequencerArpeggiate [
| seq |
seq := 8 semiquavers .
seq arpeggiate: 'c-minor7 d-minor7'.

self assert: (seq dirtMessage at: 'n') equals: #(0 3 7 10 2 5 9 12) asArray .
]

{ #category : 'tests' }
SequencerTest >> testSequencerOffset [

| seq1 seq2 result1 result2 |
seq1 := 4 downbeats.
seq2 := 4 downbeats.

result1 := #(0 0 1 0) asSeq .
result2 := #(0 0 0 1) asSeq .

self assert: (seq1 offset: 2) gates  equals: result1 gates.
self assert: (seq2 offset: -1) gates equals: result2 gates.
]

{ #category : 'tests' }
SequencerTest >> testSequencerSound [

| seq |
seq := 16 downbeats sound: #('bd' 'cp:2').

self assert: seq soundPattern  equals: #('bd' 'cp').
self assert: seq samplesIndex equals: #(0 2).
]

{ #category : 'tests' }
SequencerTest >> testSequencerToPerformance [

sequencer to: #track.
self assert: (Performance uniqueInstance at: #track) equals: sequencer
]
