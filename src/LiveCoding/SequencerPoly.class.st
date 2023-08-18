"
Polyphonic Sequencer
"
Class {
	#name : #SequencerPoly,
	#superclass : #Sequencer,
	#type : #variable,
	#instVars : [
		'dirtMessages'
	],
	#category : #'LiveCoding-Sequencers'
}

{ #category : #converting }
SequencerPoly >> asPolySeq [ 
^ self
]

{ #category : #'LiveCoding - sequencer' }
SequencerPoly >> isPolySeq [ 
^ true
]
