Class {
	#name : #MfMixingButtonElement,
	#superclass : #ToElement,
	#category : #'Mooflod-MixingTableWidget'
}

{ #category : #initialization }
MfMixingButtonElement >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self background: Color darkGray
]
