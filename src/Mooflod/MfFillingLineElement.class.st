Class {
	#name : #MfFillingLineElement,
	#superclass : #ToElement,
	#category : #'Mooflod-FilledSquareWidget'
}

{ #category : #initialization }
MfFillingLineElement >> initialize [

	super initialize.
	self size: 180 @ 0.
	self geometry: BlRectangleGeometry new.
	self background: Color black.
	self constraintsDo: [ :e | e frame vertical alignBottom.
		e frame horizontal alignCenter ]
]
