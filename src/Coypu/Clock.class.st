Class {
	#name : #Clock,
	#superclass : #Object,
	#instVars : [
		'bpm',
		'radius',
		'canvas',
		'characters'
	],
	#category : #'Coypu-Graph'
}

{ #category : #accessing }
Clock >> bpm [

	^ bpm
]

{ #category : #accessing }
Clock >> bpm: anObject [

	bpm := anObject
]

{ #category : #accessing }
Clock >> radius [

	^ radius
]

{ #category : #accessing }
Clock >> radius: aNumber [

	radius := aNumber
]

{ #category : #rendering }
Clock >> slice [

	^ Float twoPi / 16
]

{ #category : #rendering }
Clock >> start [

	| slice animation ios |
	canvas := RSCanvas new.
	canvas color: Color black.
	slice := self slice.
	
	ios := (1 to: 16) collect: [ :i | 
		       i even
			       ifTrue: [ 'I' ]
			       ifFalse: [ 'O' ] ].
	characters := ios collect: [ :m | 
		     RSLabel new
			     color: Color gray;
			     text: m;
			     yourself ].
	
	self update.
	
	canvas add: (RSComposite new
			 shapes: characters;
			 yourself).

	canvas addAll: ('TICK' asDirtArray collectWithIndex: [ :m :i | 
			 | s |
			 s := RSLabel new
				      color: Color white;
				      text: m asString;
				      yourself.
			 s position: 0 @ (-60 + (i * 15)).
			 s ]).
	(canvas nodes at: 3) remove.
	animation := [ :a :b :k | 
	             canvas transitionAnimation
		             duration: (bpm bpm * 4) seconds;
		             easing: RSEasingInterpolator bounceOut;
		             from: a;
		             to: b;
		             onStepDo: [ :t | | s |
			             canvas nodes first matrix
				             loadIdentity;
				             rotateByRadians: t.
			             s := canvas nodes first shapes.
			             (s at: k key) color: Color lightGray.
			             (s at: k value) color: Color white.
			 ] ].
	(canvas animationFrom: { 
			 (animation value: 0 value: slice value: 10 -> 11).
			 (animation value: slice value: slice * 2 value: 11 -> 10) })
		repeat.

	canvas
		when: RSExtentChangedEvent
		do: [ canvas camera zoomToFit: canvas extent extent: 120 asPoint ].
	
	canvas open
]

{ #category : #rendering }
Clock >> update [

	characters doWithIndex: [ :s :i | 
		| ang |
		ang := i * self slice.
		s matrix rotateByRadians: ang + Float halfPi.
		s position: ang cos @ ang sin * radius ].

]
