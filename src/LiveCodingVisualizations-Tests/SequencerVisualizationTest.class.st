"
A SequencerVisualizationTest is a test class for testing the behavior of SequencerVisualization
"
Class {
	#name : #SequencerVisualizationTest,
	#superclass : #TestCase,
	#instVars : [
		'visualisation',
		'window'
	],
	#category : #'LiveCodingVisualizations-Tests'
}

{ #category : #running }
SequencerVisualizationTest >> setUp [
	super setUp.
   
	"Put here a common initialization logic for tests"
	visualisation := SequencerVisualization new.
	window := nil.
	
]

{ #category : #running }
SequencerVisualizationTest >> tearDown [ 
.
   
	"Put here a common initialization logic for tests"
	
	window ifNotNil: [window delete].
	super tearDown .
	
]

{ #category : #tests }
SequencerVisualizationTest >> testAnimationProcessCreatesMarkerShape [

|  seq|
	
	seq := 16 downbeats.
	visualisation sequencer: seq.
	visualisation build.
	self assert: visualisation stepMarker isNil.
	visualisation step.
	self assert: visualisation stepMarker isNotNil.
]

{ #category : #tests }
SequencerVisualizationTest >> testBuildCreates16Shapes [

	|  seq|
	
	seq := 16 downbeats.
	visualisation sequencer: seq.
	visualisation build.
	
	self assert: visualisation shapes size equals: 16.
]

{ #category : #tests }
SequencerVisualizationTest >> testOpenEmptySequencerRisesError [

	
	self should: [ visualisation build. ] raise: NoSequencerError.
	
]

{ #category : #tests }
SequencerVisualizationTest >> testOpenSequencer [

	|  seq|

	seq := 16 downbeats.
	visualisation sequencer: seq.
	window := visualisation open.
	self assert: window isDisplayed.
	self assert: visualisation sequencer equals: seq.
	
]

{ #category : #tests }
SequencerVisualizationTest >> testVisualisationGatesWith2Colors [

	|  seq groups|
	
	seq := 16 downbeats.
	visualisation sequencer: seq.
	visualisation build.
	groups := visualisation shapes groupedBy: [ :each | each color ].
	self assert: groups size equals: 2.
]
