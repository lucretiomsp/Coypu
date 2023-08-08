Extension { #name : #ByteSymbol }

{ #category : #'*LiveCodingVisualizations' }
ByteSymbol >> gatesVisualizer [

	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"

	| p seq |
	p := Performance uniqueInstance.
	seq := p at: self.
	^ seq gatesVisualizer
]

{ #category : #'*LiveCodingVisualizations' }
ByteSymbol >> inspectorGates [

	"simple visualization of the gates of a Sequencer - triggers are yellow, rests are white"
	<inspectorPresentationOrder: -1000 title: 'Gates'>
	| p seq |
	p := Performance uniqueInstance.
	seq := p at: self.
	^ seq gatesVisualizer asPresenter
]

{ #category : #'*LiveCodingVisualizations' }
ByteSymbol >> inspectorGatesContext: context [

	context
		withoutEvaluator;
		active: self isInPerformance
]

{ #category : #'*LiveCodingVisualizations' }
ByteSymbol >> isInPerformance [

	^ Performance uniqueInstance includesKey: self
]

{ #category : #'*LiveCodingVisualizations' }
ByteSymbol >> visualizeGates [
	^ self gatesVisualizer open
]
