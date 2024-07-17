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

	| announcement isInKeys |
	isInKeys := false.
	(PerfTypeMooflod - Old)  uniqueInstance keysDo: [ :k |
		k = aSymbol ifTrue: [
			(PerfTypeMooflod - Old)  uniqueInstance class = PerformanceRecorder ifTrue: [
				(Performance uniqueInstance visualizer patternArray at: k)
					forSequencer: self.
				isInKeys := true.
				((PerfTypeMooflod - Old) uniqueInstance visualizer squareArray at: k)
					changeAnimationTime: (PerfTypeMooflod - Old)  uniqueInstance freq * 4 ] ] ].

	isInKeys ifFalse: [
		(PerfTypeMooflod - Old)  uniqueInstance class = PerformanceRecorder ifTrue: [
			(PerfTypeMooflod - Old) uniqueInstance visualizer addInstrument: aSymbol.
			"aSymbol = 'ht' ifTrue: [ self halt ]."
			(PerfTypeMooflod - Old)  uniqueInstance visualizer level = 1 ifFalse: [
				((PerfTypeMooflod - Old) uniqueInstance visualizer patternArray
					 associationAt: aSymbol) value forSequencer: self ].
			((PerfTypeMooflod - Old) uniqueInstance visualizer squareArray associationAt:
				 aSymbol) value initializeAnimation:
				(PerfTypeMooflod - Old)  uniqueInstance freq * 4 ].
		(PerfTypeMooflod - Old) uniqueInstance visualizer level = 5 ifTrue: [
			(PerfTypeMooflod - Old) uniqueInstance addMasterWidgets ] ].

	self noteIndex: 1.
	self seqKey: aSymbol asString.
	announcement := (self notesSize > 4 and: [
		                 (self notes at: 1) = 60 and: [
			                 (self notes at: 5) = 60 ] ])
		                ifTrue: [ DoubleRhythmAnnouncement new ]
		                ifFalse: [ SymbolAnnouncement new ].
	announcement symbol: self seqKey.
	PerformanceRecorder uniqueInstance announce: announcement.


	"For SuperDirt"
	self dirtMessage at: '_id' put: self seqKey.
	self dirtMessage at: 'orbit' put: self orbit.

	(self dirtMessage includesKey: 's')
		ifFalse: [
		self dirtMessage at: 's' put: aSymbol asString asDirtArray ]
		ifTrue: [  ].

	"For Polyphony"
	seqChords
		ifNil: [ (PerfTypeMooflod - Old)  uniqueInstance at: aSymbol put: self ]
		ifNotNil: [
		(PerfTypeMooflod - Old)  uniqueInstance at: aSymbol put: self asPolySeq ].


	"For PerformerPhaust"
	(PerfTypeMooflod - Old) uniqueInstance performer class = PerformerPhaust ifTrue: [
		self phaustGateDestination: self seqKey , 'Gate'.
		self phaustNoteDestination: self seqKey , 'Note' ]
]
