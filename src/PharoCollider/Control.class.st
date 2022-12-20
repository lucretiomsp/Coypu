Class {
	#name : #Control,
	#superclass : #UGen,
	#instVars : [
		'name',
		'values',
		'lags',
		'fixedLag',
		'spec',
		'paramName'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #instanceCreat }
Control class >> newWithName: aString [
" creates a new instance of the control with a Control name"
	^ self new paramName: aString
]

{ #category : #accessing }
Control >> fixedLag [

	^ fixedLag
]

{ #category : #accessing }
Control >> fixedLag: aBoolean [

	fixedLag := aBoolean 
]

{ #category : #initialization }
Control >> initialize [

	super initialize.
	self fixedLag: false.
	self values: 0
]

{ #category : #testing }
Control >> isControl [

"my implementation to count controls in SynthDef"
^ true
]

{ #category : #accessing }
Control >> lags [

	^ lags
]

{ #category : #accessing }
Control >> lags: anObject [

	lags := anObject
]

{ #category : #accessing }
Control >> name [
	^ name
]

{ #category : #accessing }
Control >> name: aString [ 
	name := aString
]

{ #category : #accessing }
Control >> paramName [

	^ paramName
]

{ #category : #accessing }
Control >> paramName: aString [

	paramName := aString
]

{ #category : #accessing }
Control >> spec [

	^ spec
]

{ #category : #accessing }
Control >> spec: anObject [

	spec := anObject
]

{ #category : #accessing }
Control >> values [

	^ values
]

{ #category : #accessing }
Control >> values: anObject [

	values := anObject
]
