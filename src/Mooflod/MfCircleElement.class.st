Class {
	#name : 'MfCircleElement',
	#superclass : 'ToElement',
	#category : 'Mooflod-MasterDelayWidget',
	#package : 'Mooflod',
	#tag : 'MasterDelayWidget'
}

{ #category : 'initialization' }
MfCircleElement >> initialize [

	super initialize.
	self geometry: (BlCircleGeometry new matchExtent: self extent).
	self constraintsDo: [ :e |
		e frame vertical alignCenter.
		e frame horizontal alignCenter ].
	self border: (BlBorder paint: Color black width: 1)
]
