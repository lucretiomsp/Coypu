Class {
	#name : #MfTimerElementTest,
	#superclass : #TestCase,
	#category : 'Mooflod-TimerWidget'
}

{ #category : #tests }
MfTimerElementTest >> testDefaultValueIsCorrectlyInitialized [

	| timer |
	
	timer := MfTimerElement new value: 20.
	self assert: timer value equals: 20
]
