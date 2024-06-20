Class {
	#name : #MfInputElementSkin,
	#superclass : #MfBasicMooflodSkin,
	#category : #'Mooflod-InputWidget'
}

{ #category : #'event handling' }
MfInputElementSkin >> installLookEvent: anEvent [
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		e background: Color black.
		e geometry: (BlRoundedRectangleGeometry cornerRadius: 20).
		e plus background: Color blue.
		e minus background: Color red ]
]
