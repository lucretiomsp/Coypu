Class {
	#name : #SequencerVisualization,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'sequencer',
		'stepMarker',
		'titleShape'
	],
	#category : #LiveCodingVisualizations
}

{ #category : #hooks }
SequencerVisualization >> newTitle [
	^ RSLabel new
		text: sequencer seqKey;
		
		bold;
		noPaint;
		"fontName: 'Arial';"
		border: (RSBorder new color: Color red; width: 3);
		fontSize: 100;
		yourself
]

{ #category : #public }
SequencerVisualization >> open [ 
^ super open setLabel: sequencer seqKey
]

{ #category : #hooks }
SequencerVisualization >> renderIn: canvas [
	| extent borderWidth colors markShape |
	sequencer ifNil: [ ^ NoSequencerError new signal].
	titleShape := self newTitle.
	extent := 800 @ 200.
	borderWidth := #( 7 2 4 2 ).
	colors := #( #white #yellow ).
   canvas color: #black.
	sequencer gates doWithIndex:  [ :gate :stepNumber | 
		canvas add: (RSBox new
				 size: 38;
				 color: (colors at: gate + 1);
				 border: (RSBorder new
						  color: #blue;
						  width: (borderWidth at: (stepNumber - 1 rem: 4) + 1))) ].

	"RSHorizontalLineLayout on: canvas shapes."
	RSGridLayout new
		lineItemsCount: 16;
		on: canvas shapes.
	markShape := nil.
	canvas addShape: titleShape.
	RSHorizontalLineLayout new
		alignMiddle;
		on: { titleShape. canvas nodes }.
	canvas newAnimation
		repeat;
		onStepDo: [ self step ].
	canvas zoomToFit.
	shapes := canvas nodes copy.
	
]

{ #category : #accessing }
SequencerVisualization >> sequencer [
	^ sequencer
]

{ #category : #accessing }
SequencerVisualization >> sequencer: aSequencer [ 
	sequencer := aSequencer 
]

{ #category : #stepping }
SequencerVisualization >> step [

  | perf shapeIndex currentShape canvas|
			"shapeIndex := seq gates wrap: seq noteIndex ."
			canvas := self container .
			perf := Performance uniqueInstance .
			shapeIndex := perf transportStep  - 1 % sequencer gates size + 1.
			shapeIndex traceCr.
			currentShape := canvas nodes at: shapeIndex .
			stepMarker  ifNil: [ 
				stepMarker := RSEllipse size: 20.
				stepMarker color: Color red.
				canvas add: stepMarker .
				 ].
			stepMarker  position: currentShape position.
			canvas signalUpdate
			
]

{ #category : #accessing }
SequencerVisualization >> stepMarker [
	^ stepMarker
]

{ #category : #accessing }
SequencerVisualization >> titleShape [
	^ titleShape
]
