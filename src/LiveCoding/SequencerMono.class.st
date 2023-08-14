"
Monophonic sequencer. 
"
Class {
	#name : #SequencerMono,
	#superclass : #Sequencer,
	#type : #variable,
	#category : #'LiveCoding-Sequencers'
}

{ #category : #converting }
SequencerMono >> asPolySeq [ 

| polySeq | 
polySeq := SequencerPoly new.
polySeq gates: self gates .
polySeq noteIndex: self noteIndex .
polySeq durations: self durations.
polySeq dirtMessage: self dirtMessage . 

^ polySeq 
]

{ #category : #'LiveCoding - sequencer' }
SequencerMono >> isPolySeq [ 
^ false
]
