Class {
	#name : #AbstractFunction,
	#superclass : #Object,
	#category : #'PharoCollider-AbstractFunctions'
}

{ #category : #converting }
AbstractFunction >> asUGenInputFor: for [

^ self value: for
]
