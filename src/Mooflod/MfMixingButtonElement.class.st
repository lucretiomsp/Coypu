Class {
	#name : 'MfMixingButtonElement',
	#superclass : 'ToElement',
	#category : 'Mooflod-MixingTableWidget',
	#package : 'Mooflod',
	#tag : 'MixingTableWidget'
}

{ #category : 'initialization' }
MfMixingButtonElement >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self background: Color darkGray
]
