"
Abstract Strategy for sequencer playback. Sequencers hold the data; my subclasses decide how each transport tick advances it.

Subclasses implement:
	playStepOn: aPerformer with: aSequencer at: transportStep

Used as an external Strategy (not Sequencer subclasses) to avoid clashing with existing axes like SequencerMono, and to allow new playback modes (Markov, Euclidean, etc.) without touching Sequencer or Performance.

Each Sequencer holds a `player` instance variable. Default is SequencerPlayerLinear; Mondo parsers swap in SequencerPlayerCyclic.
"
Class {
	#name : 'SequencerPlayer',
	#superclass : 'Object',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'playing' }
SequencerPlayer >> playStepOn: aPerformer with: seq at: transportStep [

self subclassResponsibility 
]
