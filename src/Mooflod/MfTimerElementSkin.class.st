Class {
	#name : 'MfTimerElementSkin',
	#superclass : 'MfBasicMooflodSkin',
	#category : 'Mooflod-TimerWidget',
	#package : 'Mooflod',
	#tag : 'TimerWidget'
}

{ #category : 'event handling' }
MfTimerElementSkin >> installLookEvent: anEvent [
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: e defaultGeometry.
		e size: 300 @ 300.
		e background: e backgroundPaint ]
]
