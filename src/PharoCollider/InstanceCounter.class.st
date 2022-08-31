Class {
	#name : #InstanceCounter,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#classInstVars : [
		'number'
	],
	#category : #PharoCollider
}

{ #category : #initialization }
InstanceCounter class >> number [
	^ number.
]

{ #category : #accessing }
InstanceCounter class >> number: anInteger [
		number := anInteger
]

{ #category : #initialization }
InstanceCounter >> initialize [

	super initialize.
	self class number
		ifNotNil: [ self class number: self class number + 1 ]
		ifNil: [ self class number: 0 ].
		self number: self class number.
]

{ #category : #accessing }
InstanceCounter >> number [
	^ number
]

{ #category : #accessing }
InstanceCounter >> number: anInteger [
number := anInteger.
]
