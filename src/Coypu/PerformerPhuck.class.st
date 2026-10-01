Class {
	#name : 'PerformerPhuck',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerPhuck >> playEventAt: anIndex in: aSequencer [
	| vm key gateDur |
	vm := self performance activeDSP.
	key := aSequencer seqKey , '_'.
	gateDur := (aSequencer durations asDirtArray wrap: anIndex)
		* self performance freq
		* (aSequencer gateTimes wrap: anIndex).
	aSequencer extraParams keysAndValuesDo: [ :k :v |
		vm setValue: (v wrap: anIndex) parameter: key , k uncapitalized ].
	vm
		setValue: (aSequencer notes wrap: anIndex) parameter: key , 'note';
		gate: aSequencer seqKey for: gateDur
]

{ #category : 'accessing' }
PerformerPhuck >> playFor: aNumberOfSteps [
	self performance activeDSP ifNil: [
		^ Error signal: 'There must be an active PhuckVM for this performance' ].
	super playFor: aNumberOfSteps
]
