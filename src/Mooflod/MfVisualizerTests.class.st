Class {
	#name : 'MfVisualizerTests',
	#superclass : 'TestCase',
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'tests' }
MfVisualizerTests >> testLevelOneWorksCorrectly [

	| v name firstSect |
	v := MfVisualizerElement new level: 1.
	name := 'Kick'.
	v addInstrument: name.
	v initAnimation: 128.
	firstSect := v children at: 1.
	"at level 1 we have 3 childs : the pulsing square, the instrument label and the name displayed"
	self assert: firstSect children size equals: 3
]

{ #category : 'tests' }
MfVisualizerTests >> testLevelTwoWorksCorrectly [

	| v name firstSect |
	v := MfVisualizerElement new level: 2.
	name := 'Snare'.
	v addInstrument: name.
	v initAnimation: 128.
	firstSect := v children at: 1.
	"the fourth child is the patternElement widget, added at the level 2"
	self assert: firstSect children size equals: 4.
]
