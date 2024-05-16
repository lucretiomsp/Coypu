Class {
	#name : #CircleVisualization,
	#superclass : #Object,
	#instVars : [
		'clock',
		'ellipses'
	],
	#category : #'Coypu-Graph'
}

{ #category : #accessing }
CircleVisualization >> clock [

	^ clock
]

{ #category : #accessing }
CircleVisualization >> ellipses [

	ellipses ifNotNil: [ ^ ellipses ].

	^ ellipses := ElasticEllipses new
		              start;
		              yourself
]

{ #category : #rendering }
CircleVisualization >> showSound: soundName withNote: note [

	| color |
	color := Color r: note * 2 g: 0 b: note / 2.
"	clock radius: note; update."
	self ellipses color: color; update
]

{ #category : #initialize }
CircleVisualization >> startWith: bpm [

	clock := Clock new
		         bpm: bpm;
		         radius: 30;
		         yourself.

	clock start
]
