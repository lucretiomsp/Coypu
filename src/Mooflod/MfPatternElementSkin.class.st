Class {
	#name : 'MfPatternElementSkin',
	#superclass : 'MfBasicMooflodSkin',
	#category : 'Mooflod-PatternWidget',
	#package : 'Mooflod',
	#tag : 'PatternWidget'
}

{ #category : 'event handling' }
MfPatternElementSkin >> installLookEvent: anEvent [
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (Color pink)
				 width: (2)).
		e background: e backgroundPaint ]
]
