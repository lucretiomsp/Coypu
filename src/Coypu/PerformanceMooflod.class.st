Class {
	#name : #PerformanceMooflod,
	#superclass : #Performance,
	#type : #variable,
	#instVars : [
		'displayVisualizer',
		'isVisualizerOpen',
		'stepVisualizer',
		'visualizer',
		'perfVisualizer',
		'trackVisualizers'
	],
	#category : #'Coypu-Performance'
}

{ #category : #accessing }
PerformanceMooflod >> displayVisualizer: aBoolean [

	displayVisualizer := aBoolean.
	visualizer := MfVisualizerElement new level: 5.
	stepVisualizer := MfPerformanceStepsDisplayer new.
	isVisualizerOpen := false
]

{ #category : #accessing }
PerformanceMooflod >> freq: aDurationInSeconds [
	"use for playback speed"

	super freq: aDurationInSeconds.
	isVisualizerOpen ifTrue: [
		visualizer squareArray do: [ :s | s changeAnimationTime: freq * 4 ] ]
]

{ #category : #initialization }
PerformanceMooflod >> initialize [

	super initialize.
	displayVisualizer := false
]

{ #category : #accessing }
PerformanceMooflod >> isVisualizerOpen: aBoolean [ 

isVisualizerOpen:= aBoolean 
]

{ #category : #'as yet unclassified' }
PerformanceMooflod >> levelOfDetail: anInteger [

	visualizer level: anInteger 
]

{ #category : #accessing }
PerformanceMooflod >> openVisualizers [

	space := BlSpace new extent:
		         World extent x * (5 / 12) @ World extent y.
	space useMorphicHost.
	stepVisualizer transformDo: [ :q | q translateBy: 100 @ 0 ].
	visualizer transformDo: [ :q | q translateBy: 0 @ 60 ].
	space root addChild: stepVisualizer.
	space root addChild: visualizer.
	space root childrenDo: [ :child |
		child margin: (BlInsets vertical: 10) ].
	space toTheme: MfMooflodTheme new.
	space show.
	space position: World extent x * (10 / 12) @ 20
]

{ #category : #accessing }
PerformanceMooflod >> perfVisualizer [

	^ perfVisualizer
]

{ #category : #accessing }
PerformanceMooflod >> perfVisualizer: aPerfVisualizer [
	"assing a perfVisualzier and initialize a new Dictionary for trackVisualziers"

	perfVisualizer := aPerfVisualizer.
	self trackVisualizers: Dictionary new.
]

{ #category : #playing }
PerformanceMooflod >> playFor: aNumberOfSteps [
	" reset all the Sequencers"

	"just on performance at once"

	self activeProcess isTerminated ifTrue: [
		self performer playFor: aNumberOfSteps ].
	displayVisualizer ifTrue: [
		isVisualizerOpen ifFalse: [
			stepVisualizer addSteps: self transportStep.
			stepVisualizer initializeAnimation: self freq.
			self openVisualizers.
			"MfKeyboardElement new openInMooflod."
			self isVisualizerOpen: true ].
		isVisualizerOpen ifTrue: [ stepVisualizer animationIsRunning: true ].
		stepVisualizer pauseAnimation: 15 / bpm / 60 * (aNumberOfSteps / 16).
		visualizer initAnimation: 15 / bpm / 60 * (aNumberOfSteps / 16) ].

	self resetAllSequencers
]

{ #category : #accessing }
PerformanceMooflod >> stop [

	visualizer cleanVisualizer.
	stepVisualizer animationIsRunning: false.
	super stop
]

{ #category : #accessing }
PerformanceMooflod >> trackVisualizers [

	^ trackVisualizers
]

{ #category : #accessing }
PerformanceMooflod >> trackVisualizers: aDictionary [

	trackVisualizers := aDictionary
]

{ #category : #accessing }
PerformanceMooflod >> visualizer [
	^visualizer 
]
