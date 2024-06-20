Class {
	#name : #MfStepElement,
	#superclass : #BlElement,
	#instVars : [
		'instrument'
	],
	#category : #'Mooflod-PatternWidget'
}

{ #category : #action }
MfStepElement >> assignInstrument [
	"Sets drum attribute to true"

	instrument := true
]

{ #category : #'visual properties' }
MfStepElement >> backgroundPaint [ 
	"Define the background for a bar"
	^ Color white.
]

{ #category : #initialization }
MfStepElement >> initialize [

	super initialize.
	instrument := false.
	self size: self stepExtent.
	self background: self backgroundPaint.
	self constraintsDo: [ :e | e frame vertical alignCenter ].
]

{ #category : #accessing }
MfStepElement >> instrument [

	^ instrument
]

{ #category : #removing }
MfStepElement >> removeInstrument [
	"Sets drum attribute to false"

	instrument := false
]

{ #category : #'visual properties' }
MfStepElement >> stepExtent [
	"Size of a bar"
	^30@52.
]
