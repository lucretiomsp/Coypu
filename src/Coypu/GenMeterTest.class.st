"
Tests for GenMeter.
"
Class {
	#name : 'GenMeterTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenMeterTest >> testABarNeedsSteps [

	self should: [ GenMeter stepsPerBar: 0 ] raise: Error
]

{ #category : 'tests' }
GenMeterTest >> testCompoundBar [

	| meter |
	meter := GenMeter stepsPerBar: 12.
	self assert: (meter strengthAt: 1) equals: 1.0.
	self assert: (meter strengthAt: 7) equals: 0.75.
	self assert: (meter strengthAt: 4) equals: 0.5.
	self assert: (meter strengthAt: 2) equals: 0.25
]

{ #category : 'tests' }
GenMeterTest >> testLevels [

	self assert: (GenMeter stepsPerBar: 16) levels equals: #( 16 8 4 2 1 ).
	self assert: (GenMeter stepsPerBar: 12) levels equals: #( 12 6 3 1 ).
	self assert: (GenMeter stepsPerBar: 13) levels equals: #( 13 1 ).
	self assert: (GenMeter stepsPerBar: 1) levels equals: #( 1 )
]

{ #category : 'tests' }
GenMeterTest >> testPrimeBar [

	| meter |
	meter := GenMeter stepsPerBar: 13.
	self assert: (meter strengthAt: 1) equals: 1.0.
	self assert: (meter strengthAt: 2) equals: 0.5
]

{ #category : 'tests' }
GenMeterTest >> testSixteenStepBar [

	| meter |
	meter := GenMeter stepsPerBar: 16.
	self assert: (meter strengthAt: 1) equals: 1.0.
	self assert: (meter strengthAt: 9) equals: 0.8.
	self assert: (meter strengthAt: 5) equals: 0.6.
	self assert: (meter strengthAt: 3) equals: 0.4.
	self assert: (meter strengthAt: 2) equals: 0.2
]

{ #category : 'tests' }
GenMeterTest >> testStepsWrapAroundTheBar [

	| meter |
	meter := GenMeter stepsPerBar: 16.
	self assert: (meter strengthAt: 17) equals: 1.0.
	self assert: (meter isDownbeat: 17).
	self deny: (meter isDownbeat: 16).
	self assert: (meter barOfStep: 16) equals: 1.
	self assert: (meter barOfStep: 17) equals: 2
]
