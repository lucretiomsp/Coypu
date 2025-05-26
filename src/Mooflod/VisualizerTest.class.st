Class {
	#name : 'VisualizerTest',
	#superclass : 'TestCase',
	#category : 'Mooflod-Tests',
	#package : 'Mooflod',
	#tag : 'Tests'
}

{ #category : 'tests' }
VisualizerTest >> testNextFreeRow [

	| visualizer |
	visualizer := MfVisualizerElement new.
	
	visualizer nbTracks: 5.

	self assert: visualizer nextFreeRow equals: 1.

	visualizer nbTracks: 1.
	self assert: visualizer nextFreeRow equals: 2.
	
visualizer nbTracks: 4.
	self assert: visualizer nextFreeRow equals: 5
]
