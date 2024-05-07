Class {
	#name : #PerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performance',
		'performer'
	],
	#category : #'Coypu-Tests'
}

{ #category : #tests }
PerformanceTest >> playPerformance [

	performance at: #gate put: ((15 rumba notes: #( 10 20 30 ))
			 and: #( 'extra1' #( 40 60 90 ) )
			 and: #( 'extra2' #( 45 65 95 ) )).

	performance play: 60 bpm for: 1 bars.

	self waitASecond
]

{ #category : #tests }
PerformanceTest >> setUp [

	performance := Performance uniqueInstance .

	performance performer: performer


	"self playPerformance"
]

{ #category : #tests }
PerformanceTest >> testAddSequencerAndReplace [

	| p seq1 seq2 |
	p := Performance uniqueInstance .
	seq1 := 16 downbeats.
	seq2 := 16 tumbao.
	p add: seq1.
	p add: seq2.

	self assert: (p includes: seq2) & (p includes: seq1) not equals: true
]

{ #category : #tests }
PerformanceTest >> testAssignMIDIChannelToSequencerAutomatically [

	| perf seq |
	perf := Performance new.
	seq := Sequencer uniqueInstance.
	
	perf at: #midi7 put: seq.

	self assert: seq midiChannel equals: 7
]

{ #category : #tests }
PerformanceTest >> testBwToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth bw: #( 1 2 3 4 ).
	self assert: (p at: #synth) extra1 equals: #( #Bw #( 1 2 3 4 ) )
]

{ #category : #tests }
PerformanceTest >> testDirtNotesToKey [

	| seq |
	seq := 16 downbeats sound: 'arpy' dirtNotes: #(60 61 62 63) to: #aKeyInPerf.

	self assert: seq samplesIndex equals: #(0 1 2 3)
]

{ #category : #tests }
PerformanceTest >> testHexPatternAndDirtSoundsToKey [

	| p |
	p := Performance uniqueInstance.
	'8888' sound: #( 'cp' ) to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.
	self assert: (p at: #synth) soundPattern  equals: #('cp').

]

{ #category : #tests }
PerformanceTest >> testHexPatternAndIndexesToKey [

	| p |
	p := Performance uniqueInstance.
	'8888' index: #( 1 2 3 4 ) to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.
	self assert: (p at: #synth) extra1 equals: #( #Index #( 1 2 3 4 ) ).

]

{ #category : #tests }
PerformanceTest >> testHexPatternAndNotesAbdIndexesToKey [

	| p |
	p := Performance uniqueInstance.
	'8888' notes: #( 48 48 48 48 ) index: #( 1 2 3 4 ) to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #(1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0) asRhythm .
	self assert: (p at: #synth) extra1 equals: #( #Index #( 1 2 3 4 ) ).
	self assert: (p at: #synth) notes equals: #( 48 48 48 48 )
]

{ #category : #tests }
PerformanceTest >> testHexPatternAndNotesAndMidiChToKey [

	| p |
	p := Performance uniqueInstance.
	'000F' notes: #( 48 48 48 48 ) midiCh: 2 to: #synth.
	self assert: (p at: #synth) notes equals: #( 48 48 48 48 ).
	self assert: (p at: #synth) midiChannel equals: 2
]

{ #category : #tests }
PerformanceTest >> testHexPatternAndNotesToKey [

	| p |
	p := Performance uniqueInstance.
	'8888' notes: #( 48 48 48 48 )  to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.

	self assert: (p at: #synth) notes equals: #( 48 48 48 48 )
]

{ #category : #tests }
PerformanceTest >> testHexPatternMidiChToKey [

	| p |
	p := Performance uniqueInstance.
	'0808' midiCh: 2 to: #synth.
	self assert: (p at: #synth) midiChannel equals: 2
]

{ #category : #tests }
PerformanceTest >> testIndexesToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth indexes: #( 1 2 3 4 ).
	self assert: (p at: #synth) extra1 equals: #(#Index #(1 2 3 4)).
]

{ #category : #tests }
PerformanceTest >> testMidiChToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats midiCh: 2 to: #synth.

	self assert: (p at: #synth) midiChannel  equals: 2
]

{ #category : #tests }
PerformanceTest >> testMuteAll [
	| p |
	p := Performance uniqueInstance .
	p at: #kick put: 16 downbeats .
	p at: #snare put: 16 upbeats.
	p at: #ch put: 16 quavers.
	p at: #oh put: 16 semiquavers.

	p muteAll.
	self assert: p isEmpty equals: true
]

{ #category : #tests }
PerformanceTest >> testMuteKey [

	performance at: #kick put: 16 downbeats.
	#kick mute.
	self assert: performance isEmpty equals: true
]

{ #category : #tests }
PerformanceTest >> testNotesAndMidiChToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats notes: #(48 48 48 48) midiCh: 2 to: #synth.
	self assert: (p at: #synth) notes  equals: #(48 48 48 48 ).
	self assert: (p at: #synth) midiChannel equals: 2
]

{ #category : #tests }
PerformanceTest >> testNotesAndModeToKey [

	| p |
	p := Performance uniqueInstance.
	4 breves notes: #( 48 48 48 48 ) mode: #(0 1 2 3) to: #synth.
	self assert: (p at: #synth) notes equals: #( 48 48 48 48 ).
	self assert: (p at: #synth) extra1 equals: #(#Mode #( 0 1 2 3)).
]

{ #category : #tests }
PerformanceTest >> testNotesToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth notes: #( 48 48 48 48 ).
	self assert: ((p at: #synth) notes) equals: #( 48 48 48 48 )
]

{ #category : #tests }
PerformanceTest >> testNumberToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth number: #( 1 2 3 4 ).
	self assert: (p at: #synth) extra2 equals: #( #Number #( 1 2 3 4 ) )
]

{ #category : #tests }
PerformanceTest >> testPerformanceBackup [

| p |
p := Performance uniqueInstance .
16 downbeats to: #kick.
16 upbeats to: #ch.

self assert: p backup equals: p asDictionary 
]

{ #category : #tests }
PerformanceTest >> testPerformanceKeySolo [

	| p |
	p := Performance uniqueInstance.
	p at: #kick put: 16 downbeats.
	p at: #tom put: 32 shiko.
	p at: #oh put: 16 upbeats.
	p at: #snare put: '0240' pattern.
   
  #tom solo.
	self assert:  p keys equals: #( #tom )
]

{ #category : #tests }
PerformanceTest >> testPerformanceKeysSwap [

	| seq1 seq2 p |
	p := Performance new.
	seq1 := 4 downbeats.
	seq2 :=  4 semiquavers.
	p at: #a put: seq1.
	p at: #b put: seq2.
	
	p swap: #a with: #b.
	self assert: ( p at: #b) equals: seq1


]

{ #category : #tests }
PerformanceTest >> testPerformanceSolo [

	| p |
	p := Performance uniqueInstance .
	p at: #kick put: 16 downbeats.
	p at: #tom put: 32 shiko.
	p at: #oh put: 16 upbeats.
	p at: #snare put: '0240' pattern.

	self assert: (p solo: #tom) keys equals: #(#tom)
]

{ #category : #tests }
PerformanceTest >> testRestorePerformance [

| p | 
p := Performance uniqueInstance .
16 downbeats to: #kick.
16 upbeats to: #ch.
p muteAll.
p restore.
self assert: (p at: #kick) equals: 16 downbeats.
 self assert: (p at: #ch) equals: 16 upbeats.
]

{ #category : #tests }
PerformanceTest >> testRhythmAndIndexesToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats index: #( 1 2 3 4 ) to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.
	self assert: (p at: #synth) extra1 equals: #( #Index #( 1 2 3 4 ) )
]

{ #category : #tests }
PerformanceTest >> testRhythmAndNotesAbdIndexesToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats notes: #(48 48 48 48) index: #( 1 2 3 4 ) to: #synth.

	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm.
	self assert: (p at: #synth) extra1 equals: #( #Index #( 1 2 3 4 ) ).
	self assert: (p at: #synth) notes equals: #(48 48 48 48).

]

{ #category : #tests }
PerformanceTest >> testRhythmAndNotesToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats notes: #( 48 48 48 48 ) to: #synth.
	#synth notes: #( 48 48 48 48 ).
	self
		assert: (p at: #synth) gates
		equals: #( 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 ) asRhythm .
	self assert: (p at: #synth) notes equals: #( 48 48 48 48 )
]

{ #category : #tests }
PerformanceTest >> testSequencerPlaysImmediately [

	| perf |
	perf := Performance new.
	16 downbeats to: #kick.
	self assert: (perf at: #kick) equals: 16 downbeats
	
]

{ #category : #tests }
PerformanceTest >> testStringOfHexToPerformance [

	| p |
	p := Performance uniqueInstance.
	'8888' to: #kick.
	self assert: (p at: #kick) equals: '8888' pattern
]

{ #category : #tests }
PerformanceTest >> testUnsoloKeyInPerformance [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #kick.
	16 upbeats to: #ch.
	#ch solo.
	#ch unsolo.
	self assert: (p at: #kick) equals: 16 downbeats.
	self assert: (p at: #ch) equals: 16 upbeats
]

{ #category : #tests }
PerformanceTest >> testUnsoloPerformance [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #kick.
	16 upbeats to: #ch.
	p solo: #ch.
	p unsolo: #ch.
	self assert: (p at: #kick) equals: 16 downbeats.
	self assert: (p at: #ch) equals: 16 upbeats
]

{ #category : #tests }
PerformanceTest >> waitASecond [

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 1) wait
]
