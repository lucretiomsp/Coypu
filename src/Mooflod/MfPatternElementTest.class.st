Class {
	#name : #MfPatternElementTest,
	#superclass : #TestCase,
	#category : #'Mooflod-PatternWidget'
}

{ #category : #tests }
MfPatternElementTest >> testIfInstrumentAssignedOnClick [

	| patternElem |
	" Create the pattern element"
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	"Simulate a click on all bars in the pattern"
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e.
		self assert: e instrument equals: true "Now all bars have a drum assigned" ]
]

{ #category : #tests }
MfPatternElementTest >> testInstrumentRemovedOnClick [

	| patternElem |
	"Create the pattern element"
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e "proved by previous test, all drums attributes equals true" ].
	"Clicking a second time on all bars"
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e.
		self assert: e instrument equals: false "Now all bars have no drums, same as creation state" ]
]

{ #category : #tests }
MfPatternElementTest >> testPatternIsEmptyIfNbStepsNotValid [

	| patternE1 patternE2 |
	"Create two pattern elements with differents min/max bars allowed"
	patternE1 := MfPatternElement new
		             min: 4;
		             max: 12;
		             nbsteps: 13.
	self assert: patternE1 nbOfSteps equals: 0. "Bars not added to element, over the max"
	patternE2 := MfPatternElement new
		             min: 8;
		             max: 16;
		             nbsteps: 4.
	self assert: patternE2 nbOfSteps equals: 0 "Bars not added to element, under the min"
]

{ #category : #'test-init' }
MfPatternElementTest >> testStepAreInitializedCorrectlyInPattern [

	| patternElem |
	"create a pattern to assign to the element""Create the pattern element and give him the number of bars we want in "
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 16.
	"At creation all bars have no drum assigned"
	patternElem childrenDo: [ :e | self deny: e instrument ].
	"Test if all 16 bars are added to the pattern element"
	self assert: patternElem nbOfSteps equals: 16
]
