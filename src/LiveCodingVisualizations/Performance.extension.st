Extension { #name : #Performance }

{ #category : #'*LiveCodingVisualizations' }
Performance >> inspectorAllSequencers [
	<inspectorPresentationOrder: -1000 title: 'Sequencers'>
	| presenter layout sequencers |
	presenter := SpPresenter new.
	layout := SpBoxLayout newVertical.
	layout spacing: 5.
	sequencers := self values asSortedCollection: [:seq1 :seq2| 
		seq1 seqKey < seq2 seqKey ].
	sequencers do: [ :each | | presenterPresenter |
		presenterPresenter := each inspectorSequencer.
		layout 
			add: each inspectorSequencer
			withConstraints: [ :constraints | 
				constraints height: presenterPresenter canvas encompassingRectangle height  ] ].
	presenter layout: (SpScrollableLayout with: layout).
	
	^ presenter 
	
	
]

{ #category : #'*LiveCodingVisualizations' }
Performance >> inspectorAllSequencersContext: context [
	context
		withoutEvaluator
		active: self notEmpty
		
	
]
