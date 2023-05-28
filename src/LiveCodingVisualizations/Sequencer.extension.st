Extension { #name : #Sequencer }

{ #category : #'*LiveCodingVisualizations' }
Sequencer >> gatesVisualizer [

	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"

	^ SequencerVisualization new
		sequencer: self;
		yourself
]

{ #category : #'*LiveCodingVisualizations' }
Sequencer >> inspectorSequencer [	
	
	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"
	<inspectorPresentationOrder: -1000 title: 'Gates'>
	
	
	^ self seqKey asSymbol inspectorGates
]
