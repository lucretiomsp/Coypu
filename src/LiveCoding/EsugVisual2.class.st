"
Visualization for Performance ESUG2022 /less OSC message action / visualization on Sequencers
"
Class {
	#name : #EsugVisual2,
	#superclass : #RSCanvas,
	#instVars : [
		'alanTextGroup'
	],
	#category : #'LiveCoding-Visuals'
}

{ #category : #accessing }
EsugVisual2 >> alanTextGroup [

	^ alanTextGroup
]

{ #category : #accessing }
EsugVisual2 >> alanTextGroup: anObject [

	alanTextGroup := anObject
]

{ #category : #initialization }
EsugVisual2 >> initialize [

	super initialize.
	self color: #black.
	self visualizeAlanSpeech 
]

{ #category : #'sub item creating' }
EsugVisual2 >> visualizeAlanSpeech [

	| r r2 r3 red blue words label |
	alanTextGroup := RSGroup new.

	words := EsugVisual  alanSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: (Color r: red g: 0 b: blue).
		label fontSize: (r nextInteger: 38) + 10.

		self add: label.
		alanTextGroup add: label ].

	RSRectanglePackLayout on: alanTextGroup.
	"RSFlowLayout new
		alignLabel;
		on: alanText."
	self shapes translateTo: 10 @ 0
]
