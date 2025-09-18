"
Special sequencer fo Mooflod type Performance / should be re-designed
"
Class {
	#name : 'MfSequencer',
	#superclass : 'Sequencer',
	#type : 'variable',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'LiveCoding - Performance' }
MfSequencer >> to: aSymbol [
	" assign sequencer to the performance at aSymbol. if a sound for SuperDirt is not specified, the symbol is used for sound name"

	|  isInKeys |
	isInKeys := false.
	(PerfTypeMooflod ) uniqueInstance keysDo: [ :k |
			

	isInKeys ifFalse: [
			 
									((PerfTypeMooflod ) uniqueInstance visualizer
										 patternArray associationAt: aSymbol) value forSequencer:
										self ].
						((PerfTypeMooflod ) uniqueInstance visualizer squareArray
							 associationAt: aSymbol) value initializeAnimation:
							(PerfTypeMooflod ) uniqueInstance freq * 4 ].
			(PerfTypeMooflod ) uniqueInstance visualizer level = 5
				ifTrue: [   PerfTypeMooflod  uniqueInstance addMasterWidgets ] .

	self noteIndex: 1.
	self seqKey: aSymbol asString.
	


	"For SuperDirt"
	self dirtMessage at: '_id' put: self seqKey.
	self dirtMessage at: 'orbit' put: self orbit.

	(self dirtMessage includesKey: 's')
		ifFalse: [
		self dirtMessage at: 's' put: aSymbol asString asDirtArray ]
		ifTrue: [ ].

	"For Polyphony"
	seqChords
		ifNil: [
		(PerfTypeMooflod ) uniqueInstance at: aSymbol put: self ]
		ifNotNil: [
			(PerfTypeMooflod ) uniqueInstance
				at: aSymbol
				put: self asPolySeq ].


	"For PerformerPhaust"
	(PerfTypeMooflod ) uniqueInstance performer class
	= PerformerPhausto ifTrue: [
			self phaustGateDestination: self seqKey , 'Gate'.
			self phaustNoteDestination: self seqKey , 'Note' ]
]
