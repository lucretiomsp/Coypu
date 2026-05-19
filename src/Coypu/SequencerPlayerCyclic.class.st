"
Cycle-based playback for Mondo Syntax sequencers.

Each cycle is [0, 1]. On each tick I compute the current cycle and step-fraction, then call `seq queryFrom:to:cycle:` to get the events in that slice. Onset and note-index both come from the query.

Supports polymetric subdivision (`'c4 [e4*3]'`) and per-event divisors (`'sd/4'` fires every 4th cycle). No `noteIndex` — CoyEvents carry their own index.
"
Class {
	#name : 'SequencerPlayerCyclic',
	#superclass : 'SequencerPlayer',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'playing' }
SequencerPlayerCyclic >> playStepOn: aPerformer with: seq at: transportStep [

	| stepsPerCycle cycleIndex stepInCycle events |

	stepsPerCycle := seq stepsPerCycle.
	cycleIndex := transportStep // stepsPerCycle + 1.
	stepInCycle := transportStep \\ stepsPerCycle.
	cycleIndex = seq lastResolvedCycle ifFalse: [
		seq resolveCycle: cycleIndex ].
	events := seq
		          queryFrom: stepInCycle / stepsPerCycle
		          to: stepInCycle + 1 / stepsPerCycle
		          cycle: cycleIndex.
	events do: [ :ev | aPerformer playEventAt: ev value in: seq ]
]
