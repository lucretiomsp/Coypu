Class {
	#name : #ElasticEllipses,
	#superclass : #Object,
	#instVars : [
		'color',
		'canvas'
	],
	#category : #'Coypu-Graph'
}

{ #category : #accessing }
ElasticEllipses >> color [

	^ color
]

{ #category : #accessing }
ElasticEllipses >> color: anObject [

	color := anObject
]

{ #category : #accessing }
ElasticEllipses >> initialize [

	color := Color black
]

{ #category : #accessing }
ElasticEllipses >> start [

	canvas := RSCanvas new.
	self update.
	canvas when: RSExtentChangedEvent do: [ :evt | canvas zoomToFit ].
	canvas open
]

{ #category : #accessing }
ElasticEllipses >> update [

	| c1 c2 random realColor |
	random := Random new.
	canvas nodes copy do: #remove.
	c1 := color.
	c2 := color muchDarker.
	realColor := NSScale linear range: { c1. c2 }.

	1 to: 10000 do: [ :i | 
		| shape radius ang overlapped |
		shape := RSEllipse new.
		shape radius: random next * 30 + 2.
		radius := random next * 250.
		ang := random next * Float pi * 2.
		shape position: radius * (ang cos @ ang sin).
		overlapped := canvas nodes anySatisfy: [ :other | 
			              (other position distanceTo: shape position)
			              < (shape radius + other radius * 1.4) ].
		overlapped ifFalse: [ 
			canvas add: shape.
			shape propertyAt: #radius put: shape radius.
			shape color:
				(realColor scale: (shape position distanceTo: 0 @ 0) / 250) ] ].
	canvas newAnimation
		easing: RSEasingInterpolator elasticOut;
		onStepDo: [ :t | 
			canvas nodes do: [ :shape | 
					| scale |
					scale := NSScale linear range: { 
								         1.
								         (shape propertyAt: #radius) }.
					shape radius: (scale scale: t) ] ]
]
