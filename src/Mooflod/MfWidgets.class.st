Class {
	#name : 'MfWidgets',
	#superclass : 'Object',
	#category : 'Mooflod-Widgets',
	#package : 'Mooflod',
	#tag : 'Widgets'
}

{ #category : 'example' }
MfWidgets class >> exampleDisplayingAllWidgets [

	<script>
	| k timer aPiano s aSquare space c anInput mT p |
	aSquare := MfFilledSquareElement new position: 20 @ 50.
	aSquare setValue: 65.
	anInput := MfNumberInputElement new position: 90 @ 0.
	c := MfMasterDelayElement new.
	c setValue: 100.
	mT := MfMixingTableElement new
		      nbButtons: 12;
		      nbButtonPerRow: 4.
	p := MfPatternElement new
		     min: 4;
		     max: 16;
		     nbsteps: 12.
	s := MfPerformanceStepsDisplayer new.
	aPiano := MfPianoElement new.
	s addSteps: 189.
	timer := MfTimerElement new value: 18.
	k := MfKeyboardElement new.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.

	space toTheme: MfMooflodTheme new.
	space root addChild: aSquare.
	space root addChild: anInput.
	space root addChild: mT.
	space root addChild: c.
	space root addChild: p.
	space root addChild: s.
	space root addChild: aPiano.
	space root addChild: timer.
	space root addChild: k.
	space root childrenDo: [ :child | child margin: (BlInsets all: 10) ].

	space show
]
