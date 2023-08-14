"
Monophonic sequencer. 
"
Class {
	#name : #SequencerMono,
	#superclass : #Sequencer,
	#type : #variable,
	#category : #'LiveCoding-Sequencers'
}

{ #category : #'LiveCoding - sequencer' }
SequencerMono >> isPolySeq [ 
^ false
]
