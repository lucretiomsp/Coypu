Class {
	#name : #MfPerformanceStepsDisplayerTests,
	#superclass : #TestCase,
	#category : 'Mooflod-PerformanceStepsDisplayer'
}

{ #category : #tests }
MfPerformanceStepsDisplayerTests >> testAnimationStartsWhenAddingSteps [

		| displayer |


	displayer := MfPerformanceStepsDisplayer new.
	self assert: displayer animationIsRunning equals: false.
	displayer addSteps: 267.
	self assert: displayer animationIsRunning equals: true
]

{ #category : #tests }
MfPerformanceStepsDisplayerTests >> testStepsCantBeOver30000 [

	| displayer |


	displayer := MfPerformanceStepsDisplayer new.
	displayer addSteps: 31540.
	self assert: displayer nbSteps equals: nil 
]
