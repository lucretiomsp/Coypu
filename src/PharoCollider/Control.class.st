Class {
	#name : #Control,
	#superclass : #UGen,
	#instVars : [
		'name',
		'values',
		'lags',
		'fixedLag',
		'spec'
	],
	#category : #'PharoCollider-UGens'
}

{ #category : #instanceCreat }
Control class >> newWithName: aString [ 
	^ self new name: aString
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
super initialize .
self fixedLag: false
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
