Class {
	#name : #PerformanceMooflod,
	#superclass : #Performance,
	#category : #'Coypu-Performance'
}

{ #category : #accessing }
PerformanceMooflod >> freq: aDurationInSeconds [
	"use for playback speed"

	super freq: aDurationInSeconds.
	isVisualizerOpen ifTrue: [
		visualizer squareArray do: [ :s | s changeAnimationTime: freq * 4 ] ]
]

{ #category : #initialization }
PerformanceMooflod >> initialize: aSize [

	super initialize: aSize.
	displayVisualizer := false
]

{ #category : #playing }
PerformanceMooflod >> playFor: aNumberOfSteps [
	" reset all the Sequencers"

	"just on performance at once"

	bpm := 60 * 1 / (self freq * 4).
	self activeProcess isTerminated ifTrue: [
		self performer playFor: aNumberOfSteps ].
	displayVisualizer ifTrue: [
		isVisualizerOpen ifFalse: [ stepVisualizer addSteps: self transportStep.
			stepVisualizer initializeAnimation: self freq.
			self openVisualizers.
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
