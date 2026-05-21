"
Linear playback. Each transport tick advances one step through gates.

If `gates wrap: transportStep` is 1, fire the event at `seq noteIndex` and increment it. Otherwise silent. Notes are consumed independently of gate position.

Default mode. Used by `asDirtNotes` sequencers.
"
Class {
	#name : 'SequencerPlayerLinear',
	#superclass : 'SequencerPlayer',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'playing' }
SequencerPlayerLinear >> playStepOn: aPerformer with: seq at: transportStep [
	(seq gates wrap: transportStep) = 1 ifTrue: [
		aPerformer playEventAt: seq noteIndex in: seq.
		seq noteIndex: seq noteIndex + 1 ].
	^ self
]
