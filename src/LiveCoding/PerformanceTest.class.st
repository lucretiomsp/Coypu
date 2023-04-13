Class {
	#name : #PerformanceTest,
	#superclass : #TestCase,
	#instVars : [
		'performance',
		'performer'
	],
	#category : #'LiveCoding-Tests'
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
	performer := PerformerMock new.
	performance performer: performer


	"self playPerformance"
]

{ #category : #tests }
PerformanceTest >> testAddSequencerAndReplace [

	| p seq1 seq2 |
	p := Performance new.
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
	seq := Sequencer new.
	
	perf at: #midi7 put: seq.

	self assert: seq midiChannel equals: 7
]

{ #category : #tests }
PerformanceTest >> testExtra1ToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth extra1: #(#Duty #(0.1 0.3)).
	self assert: (p at: #synth) extra1 equals: #(#Duty #(0.1 0.3))
]

{ #category : #tests }
PerformanceTest >> testExtra2ToKey [

	| p |
	p := Performance uniqueInstance.
	16 downbeats to: #synth.
	#synth extra2: #( #Duty #( 0.1 0.3 ) ).
	self assert: (p at: #synth) extra1 equals: #( #Duty #( 0.1 0.3 ) )
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
PerformanceTest >> testPerformanceSendBPMOnPlay [

	self assert: performer bpm equals: 60
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendDurations [

	self assert: (performer durationFor: 'gate') equals: 1
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithExtra1 [

	self assert: (performer noteFor: 'gateextra1') equals: 40
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithExtra2 [

	self assert: (performer noteFor: 'gateextra2') equals: 45
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithFirstNote [

	self assert: performer lastGate equals: 'gate'.
	self assert: (performer noteFor: 'gate') equals: 10
]

{ #category : #tests }
PerformanceTest >> testPerformanceSendGateWithSecondNote [

	self waitASecond. "Wait another second"

	self assert: (performer noteFor: 'gate') equals: 20
]

{ #category : #tests }
PerformanceTest >> testPerformanceSolo [

	| p |
	p := Performance new.
	p at: #kick put: 16 downbeats.
	p at: #tom put: 32 shiko.
	p at: #oh put: 16 upbeats.
	p at: #snare put: '0240' pattern.

	self assert: (p solo: #tom) keys equals: #tom
]

{ #category : #tests }
PerformanceTest >> testSequencerPlaysImmediately [

	| perf |
	perf := Performance new.
	16 downbeats to: #kick.
	
	self assert: (perf at: #kick) equals: 16 downbeats
	
]

{ #category : #tests }
PerformanceTest >> waitASecond [

	self flag: #TODO. "Change time management"
	(Delay forSeconds: 1) wait
]
