Class {
	#name : #BinaryOpUGen,
	#superclass : #BasicOpUgen,
	#category : #'PharoCollider-UGens'
}

{ #category : #'as yet unclassified' }
BinaryOpUGen >> initailize [
super initialize.
rateNumber := 2. "audio rate by default" 
]
