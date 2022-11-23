Class {
	#name : #PureUGen,
	#superclass : #UGen,
	#category : #'PharoCollider-UGens'
}

{ #category : #writeDefinition }
PureUGen >> optimizeGraph [ 

super performDeadCodeElimination
]
