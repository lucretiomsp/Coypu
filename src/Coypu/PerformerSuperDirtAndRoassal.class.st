"
Performer sdfor SuperDirt with Roassal visualization
"
Class {
	#name : #PerformerSuperDirtAndRoassal,
	#superclass : #Performer,
	#instVars : [
		'canvasBlock',
		'canvas',
		'random',
		'mode',
		'frame',
		'color',
		'border'
	],
	#category : #'Coypu-Performer'
}

{ #category : #accessing }
PerformerSuperDirtAndRoassal >> canvas [

	^ canvasBlock
]

{ #category : #accessing }
PerformerSuperDirtAndRoassal >> canvas: anObject [

	canvasBlock := anObject
]

{ #category : #initialization }
PerformerSuperDirtAndRoassal >> initialize [
	super initialize.
	self canvas: [ self updateCanvas ].
	
	self initializeRoassalCanvas.
]

{ #category : #initialization }
PerformerSuperDirtAndRoassal >> initializeRoassalCanvas [

	canvas := RSCanvas new.
	canvas shouldClearBackground: false.
	random := Random new.
	mode := 1.
	canvas color: Color black.
	frame := 0.
	canvas camera position: 0@ 50.
	color := NSScale ordinal
		         domain: #( 0 1 2 );
		         range: {
				         [ Color black ].
				         [ :e | Color h: (e propertyAt: #hue) s: 0.7 v: 1 ].
				         [ :e |
				         frame even
					         ifTrue: [ Color black ]
					         ifFalse: [ Color h: (e propertyAt: #hue) s: 1 v: 1 ] ] }.

	border := RSBorder new
		          width: 0.5;
		          yourself
]

{ #category : #initialization }
PerformerSuperDirtAndRoassal >> newBall [

	| e att xs ys |
	e := RSEllipse new.
	e border: border.
	att := e properties.
	xs := random rsNext: -3 and: 3.
	ys := (xs between: -1 and: 1)
		      ifTrue: [
			      random next > 0.5
				      ifTrue: [ random rsNext: 1 and: 3 ]
				      ifFalse: [ random rsNext: -3 and: -1 ] ]
		      ifFalse: [ random rsNext: 3 and: -3 ].
	att
		at: #s put: 0;
		at: #t put: 0;
		at: #degX put: random next;
		at: #degY put: random next;
		at: #xs put: xs;
		at: #ys put: ys;
		at: #hue put: random next * 360;
		at: #hue2 put: 4.
	^ e
]

{ #category : #'instance creation' }
PerformerSuperDirtAndRoassal >> open [
	canvas open
		position: 0@0;
		extent: self currentWorld extent * (1 @ 0.2).
]

{ #category : #playing }
PerformerSuperDirtAndRoassal >> playFor: aNumberOfSteps [
	"play the performance to SuperDIrt/SuperCollider audio engine - default freq is 132 bpm 
	Performance speed can be changed with p freq: a bpm"

	performance bpm: 60 / (performance freq * 4).
	performance transportStep: 1.
	performance activeProcess: ([
		 aNumberOfSteps timesRepeat: [
			 (Delay forSeconds: performance freq) wait.
			
			canvasBlock value.
			 "sequencers scan"
			 [
			 performance valuesDo: [ :seq |
				 (seq gates wrap: performance transportStep) = 1
					 ifTrue: [
						 seq playFullDirtEventAt: seq noteIndex. "delta!!!!"
						 
						 "increment note Index"
						 seq noteIndex: seq noteIndex + 1 ]
					 ] ] forkAt: Processor timingPriority.

			 "step is incremented anyway"
			 performance incrementTransportStep ] ] forkAt:
			 Processor timingPriority)
]

{ #category : #initialization }
PerformerSuperDirtAndRoassal >> updateCanvas [

	| shapes scale ball |
	frame := performance transportStep.
	
	frame % 16 = 0 ifTrue: [
		scale := NSScale linear
			domain: { 1. 12};
			range: { 20. 0 }.
		ball := self newBall.
		canvas add: ball.
		ball propertyAt: #s put: (scale scale: performance size) ].

	frame % 64 = 0 ifTrue: [ mode := mode + 1 % 3 ].
	frame % 128 = 0 ifTrue: [
		canvas color: (canvas color = Color black
				 ifTrue: [ Color white ]
				 ifFalse: [ Color black ]).
		canvas shouldClearBackground: true.
		canvas newAnimation
			duration: 100 milliSeconds;
			when: RSAnimationEndEvent
			do: [ canvas shouldClearBackground: false ]
			for: canvas ].
	shapes := canvas shapes copy.
	shapes do: [ :e |
		| att t s degX degY xs ys hue hue2 |
		att := e properties.
		t := att at: #t.
		s := att at: #s.
		degX := att at: #degX.
		degY := att at: #degY.
		xs := att at: #xs.
		ys := att at: #ys.
		hue := att at: #hue.
		hue2 := att at: #hue2.

		e color: ((color scale: mode) rsValue: e).
		e border color: (Color h: 360 - (att at: #hue) s: 1 v: 1).
		e size: s.

		t := t + 0.02.
		s := s + 0.2.
		e translateBy: xs @ ys + (degX cos @ degY cos) * t.
		degX := degX + (random rsNext: 0.1 and: 0.8).
		degY := degY + (random rsNext: 0.1 and: 0.8).
		hue := hue + hue2.
		(hue > 360 or: [ hue < 0 ]) ifTrue: [ hue2 := hue2 negated ].
		att
			at: #t put: t;
			at: #s put: s;
			at: #degX put: degX;
			at: #degY put: degY;
			at: #hue put: hue;
			at: #hue2 put: hue2.

		(canvas visibleRectangle intersects: e encompassingRectangle) ifFalse: [
			e remove ] ].
	canvas signalUpdate
]
