Extension { #name : #Sequencer }

{ #category : #'*LiveCoding' }
Sequencer >> randomCounterPoint [

	" creates aSequencer of trigs randomly counterpointed with self array"

	| newArray |
	newArray := Array new: self gates size.
	1 to: self gates size do: [ :i | 
		(self gates at: i) = 1
			ifTrue: [ newArray at: i put: 0 ]
			ifFalse: [ newArray at: i put: Random new nextTrig ] ].
	^ newArray asSeq
]
