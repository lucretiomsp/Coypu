Class {
	#name : #SequencerTests,
	#superclass : #TestCase,
	#instVars : [
		'sequencer'
	],
	#category : #'Coypu-Tests'
}

{ #category : #running }
SequencerTests >> setUp [

	sequencer := 8 downbeats.
	

	"Put here a common initialization logic for tests"
]

{ #category : #tests }
SequencerTests >> testAddAssociationForDirtMesage [

| seq |
seq := 16 downbeats sound: 'cp'.
seq add: 'squiz'->#(0 1 2). 

self assert: (seq dirtMessage includesKey: #squiz) equals: true.
self assert: (seq dirtMessage includes: #( 0 1  2) ) equals: true.
]

{ #category : #tests }
SequencerTests >> testArpeggiateArray [

| initial  result|
initial := #(60 61 62 63).
result := #(60 61 62 63 61 62 63 64 62 63 64 65 63 64 65 66).

self assert: (initial arp: #(0 1 2 3)) equals: result
]

{ #category : #tests }
SequencerTests >> testAsPolySeq [

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

{ #category : #tests }
SequencerTests >> testChangeSequencerGatesSize [

	| seq |
	seq := 16 downbeats.
	seq gatesSize: 1.
	self assert: (seq gatesSize) equals: 1
]

{ #category : #tests }
SequencerTests >> testChords: aChordOrAnArrayOfChords [

| polySeq |
polySeq := 4 breves sound: 'superpiano'; chords: 'c-major d-minor e-major'. 

self assert: (polySeq dirtMessage at: 'n') equals: ( 'c-major d-minor e-major' chordsToArrays ).

]

{ #category : #tests }
SequencerTests >> testEuclideanRhythmFromArray [

	| tresillo seq |
	tresillo := #( 3 8) euclidean.
	seq := #( 1 0 0 1 0 0 1 0) asRhythm asSeq.
	self assert: tresillo equals: seq
]

{ #category : #tests }
SequencerTests >> testFlipSequencer [

	| tresillo seq |
	tresillo := #( 3 8 ) euclidean flip.
	seq := #( 0 1 1 0 1 1 0 1 ) asRhythm asSeq .
	self assert: tresillo equals: seq
]

{ #category : #tests }
SequencerTests >> testInitialize [
self assert: (Sequencer new orbit > 0) & (Sequencer new orbit < 12) equals: true
]

{ #category : #tests }
SequencerTests >> testReverse [

| seq |
seq := '000F' hexBeat sound: 'sd cp'; dirtNotes: #(1 2 3) .
self assert: seq reverse gates  equals: #( 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0) asRhythm .
self assert: (seq reverse dirtMessage at: 'n') equals: #( 3 2 1).
self assert: (seq reverse dirtMessage at: 's') equals: #('cp' 'sd').
]

{ #category : #tests }
SequencerTests >> testSequencerArpeggiate [
| seq |
seq := 8 semiquavers .
seq arpeggiate: 'c-minor7 d-minor7'.

self assert: (seq dirtMessage at: 'n') equals: #(0 3 7 10 2 5 9 12) asArray .
]

{ #category : #tests }
SequencerTests >> testSequencerOffset [

| seq1 seq2 result1 result2 |
seq1 := 4 downbeats.
seq2 := 4 downbeats.

result1 := #(0 0 1 0) asSeq .
result2 := #(0 0 0 1) asSeq .

self assert: (seq1 offset: 2) gates  equals: result1 gates.
self assert: (seq2 offset: -1) gates equals: result2 gates.
]

{ #category : #tests }
SequencerTests >> testSequencerSound [

| seq |
seq := 16 downbeats sound: #('bd' 'cp:2').

self assert: seq soundPattern  equals: #('bd' 'cp').
self assert: seq samplesIndex equals: #(0 2).
]

{ #category : #tests }
SequencerTests >> testSequencerToPerformance [

sequencer to: #track.
self assert: (Performance uniqueInstance at: #track) equals: sequencer
]
