"
Convenience class to hold and change data for commmunication to the SUperCollider scsynth server


###??? should be implemented as a uniqueInstance?
"
Class {
	#name : #SCServer,
	#superclass : #Object,
	#classVars : [
		'address',
		'port'
	],
	#category : #'PharoCollider-SCServer'
}

{ #category : #accessing }
SCServer class >> address [
^ '127.0.0.1'

]

{ #category : #accessing }
SCServer class >> address: aString [

	address := aString 
]

{ #category : #accessing }
SCServer class >> port [

	^ 57110
]

{ #category : #accessing }
SCServer class >> port: anInteger [

port := anInteger 
]
