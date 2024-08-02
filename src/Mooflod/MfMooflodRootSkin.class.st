Class {
	#name : #MfMooflodRootSkin,
	#superclass : #ToRawSkin,
	#category : 'Mooflod-Core'
}

{ #category : #'event handling' }
MfMooflodRootSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.

	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'background-color') ]
]
