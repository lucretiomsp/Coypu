Class {
	#name : #Control,
	#superclass : #UGen,
	#instVars : [
		'name',
		'values',
		'lags',
		'fixedLags',
		'spec'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #instanceCreat }
Control class >> newWithName: aString [ 
	^ self new name: aString
]

{ #category : #accessing }
Control >> name [
	^ name
]

{ #category : #accessing }
Control >> name: aString [ 
	name := aString
]
