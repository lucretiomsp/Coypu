Class {
	#name : 'PerformerPhuck',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerPhuck >> knows: aString [
	(performance activePhuckVM globalTypeOf: aString ifAbsent: [ nil ]) ifNotNil: [ ^ true ].
	self inform: 'Phuck: no global ' , aString.
	^ false
]

{ #category : 'accessing' }
PerformerPhuck >> playCyclicFor: aNumberOfCycles [
	performance activePhuckVM ifNil: [
		^ Error signal: 'There must be an active PhuckVM for this performance' ].
	super playCyclicFor: aNumberOfCycles
]

{ #category : 'accessing' }
PerformerPhuck >> playEventAt: anIndex in: aSequencer [
	| key gateDur |
	key := aSequencer seqKey.
	gateDur := (aSequencer durations asDirtArray wrap: anIndex)
		* performance freq
		* (aSequencer gateTimes wrap: anIndex).
	aSequencer extraParams keysAndValuesDo: [ :k :v |
		self setValue: (v wrap: anIndex) parameter: key , k asString ].
	self setValue: (aSequencer notes wrap: anIndex) parameter: key , 'Note'.
	(self knows: key , 'Gate') ifTrue: [
		performance activePhuckVM trig: key , 'Gate' for: gateDur ]
]

{ #category : 'accessing' }
PerformerPhuck >> playFor: aNumberOfSteps [
	performance activePhuckVM ifNil: [
		^ Error signal: 'There must be an active PhuckVM for this performance' ].
	super playFor: aNumberOfSteps
]

{ #category : 'playing' }
PerformerPhuck >> playNoteFor: aSequencer [
	self playEventAt: aSequencer noteIndex in: aSequencer.
	aSequencer noteIndex: aSequencer noteIndex + 1
]

{ #category : 'accessing' }
PerformerPhuck >> setValue: aNumber parameter: aString [
	(self knows: aString) ifFalse: [ ^ self ].
	performance activePhuckVM setValue: aNumber parameter: aString
]
