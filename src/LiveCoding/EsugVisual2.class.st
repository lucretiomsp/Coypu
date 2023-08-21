"
Visualization for Performance ESUG2022 /less OSC message action / visualization on Sequencers
"
Class {
	#name : #EsugVisual2,
	#superclass : #RSCanvas,
	#instVars : [
		'alanTextGroup',
		'tickline',
		'backgroundText'
	],
	#category : #'LiveCoding-Visuals'
}

{ #category : #'instance creation' }
EsugVisual2 class >> for: anObservable [

	" Initialize a new EsugVisual, connect my visualization to anObservable Annoucer and open it"

	| canvas |
	canvas := self new.
	anObservable announcer isNotNil
		ifTrue: [ 
			canvas
				subscribeTo: anObservable announcer;
				"zoomToFit;"openOnce ]
		ifFalse: [  ].
	^ canvas
]

{ #category : #accessing }
EsugVisual2 >> alanTextGroup [

	^ alanTextGroup
]

{ #category : #accessing }
EsugVisual2 >> alanTextGroup: anObject [

	alanTextGroup := anObject
]

{ #category : #modifying }
EsugVisual2 >> backcgroundColor: aFloat [


	self color: (Color r: aFloat g: aFloat b: aFloat ).
		self signalUpdate
]

{ #category : #accessing }
EsugVisual2 >> backgroundText [

	^ backgroundText
]

{ #category : #accessing }
EsugVisual2 >> backgroundText: anObject [

	backgroundText := anObject
]

{ #category : #'sub item creating' }
EsugVisual2 >> cornholio [

	| r r2 r3 red blue words label |
	self removeShape: (self shapes at: 1) children asShape.
	alanTextGroup := RSGroup new.

	words := EsugVisual cornholioSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: (Color r: red g: blue b: 0).
		label fontSize: (r nextInteger: 48) + 10.

		"self add: label."
		alanTextGroup add: label ].

	RSRectanglePackLayout on: alanTextGroup.
	backgroundText := alanTextGroup asShape.
	self add: alanTextGroup asShape.
	"RSFlowLayout new
		alignLabel;
		on: alanText."
	self shapes translateTo: -100 @ -120.
	tickline translateTo: 0 @ 0.
	self signalUpdate
]

{ #category : #initialization }
EsugVisual2 >> initialize [

	super initialize.
	self color: #white.
	self visualizeAlanSpeech.

	tickline := RSBox new
		            color: Color white;
		            width: 28;
		            height: 200;
		            cornerRadius: 60;
		            yourself.

	"add bassline"
	self add: tickline
]

{ #category : #modifying }
EsugVisual2 >> moveTick: aFloat [

	tickline rotateByDegrees: 1.3.
	tickline pushFront.
	self signalUpdate
]

{ #category : #'sub item creating' }
EsugVisual2 >> neoPhoneCall [

	| r r2 r3 red blue words label |
	self removeShape: self backgroundText children asShape.
	alanTextGroup := RSGroup new.

	words := EsugVisual neoSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: (Color r: 0 g: blue b: red).
		label fontSize: (r nextInteger: 48) + 10.

		"self add: label."
		alanTextGroup add: label ].

	RSRectanglePackLayout on: alanTextGroup.
	self add: alanTextGroup asShape.
	"RSFlowLayout new
		alignLabel;
		on: alanText."
	self shapes translateTo: -100 @ -220.
	tickline translateTo: 0 @ 0.
	self signalUpdate
]

{ #category : #modifying }
EsugVisual2 >> scale: aFloat [

	self shapes do: [:i | i scaleBy: aFloat].
	self signalUpdate
]

{ #category : #subscription }
EsugVisual2 >> subscribeTo: anAnnouncer [

	anAnnouncer when: OSCMsgReceivedAnnouncement do: [ 
		self backcgroundColor:
			(OSCMsgReceivedAnnouncement values at: #'/snareGate') * 255.
		self moveTick:
			(OSCMsgReceivedAnnouncement values at: #'/bpmTick') * 1.
		 ]
]

{ #category : #'sub item creating' }
EsugVisual2 >> visualizeAlanSpeech [

	| r r2 r3 red blue words label |
	alanTextGroup := RSGroup new.

	words := EsugVisual alanSpeech substrings.
	r := Random new.
	r2 := Random new.
	r3 := Random new.
	words do: [ :w | 
		label := RSLabel text: w.
		red := r2 next.
		blue := r3 next.
		label color: (Color r: red g: 0 b: blue).
		label fontSize: (r nextInteger: 38) + 10.

		"self add: label."
		alanTextGroup add: label ].

	RSRectanglePackLayout on: alanTextGroup.
	self add: alanTextGroup asShape.
	"RSFlowLayout new
		alignLabel;
		on: alanText."
	self shapes translateTo: 0 @ 0
]
