"
Tests for GenDurationPolicy and GenNoteEvent.
"
Class {
	#name : 'GenDurationPolicyTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenDurationPolicyTest >> durationsOf: aPattern hold: aNumberOfSteps longNotes: aProbability random: aRandom [

	^ (GenDurationPolicy new
		   longNoteProbability: aProbability;
		   yourself)
		  durationsFor: (GenRhythm pattern: aPattern)
		  voice: (GenVoice
				   role: #test
				   center: 60
				   range: 12
				   maxHold: aNumberOfSteps
				   scorer: GenCompositeFactor new)
		  meter: (GenMeter stepsPerBar: 8)
		  random: aRandom
]

{ #category : 'tests' }
GenDurationPolicyTest >> testGate [

	| event |
	event := GenNoteEvent step: 1 pitch: (GenPitch midi: 60 step: 0) duration: 4 gate: 0.5.
	self assert: event soundingDuration equals: 2.0.
	self
		assert: (GenDurationPolicy new
				 gate: 0.25;
				 yourself) gate
		equals: 0.25
]

{ #category : 'tests' }
GenDurationPolicyTest >> testLongNotesHoldTheWholeGap [

	self
		assert: (self durationsOf: 'x.......' hold: 2 longNotes: 1 random: (GenScriptedRandom values: #( 0.5 )))
		equals: #( 8 )
]

{ #category : 'tests' }
GenDurationPolicyTest >> testLongNotesPreferStrongBeats [
	"Same dice for both notes: the downbeat note is held long, the off-beat one is not."

	self
		assert: (self durationsOf: 'x..x....' hold: 1 longNotes: 1 random: (GenScriptedRandom values: #( 0.5 )))
		equals: #( 3 1 )
]

{ #category : 'tests' }
GenDurationPolicyTest >> testNotesHoldUntilTheNextOnsetUpToTheLimit [

	self
		assert: (self durationsOf: 'x...x.x.' hold: 3 longNotes: 0 random: (Random seed: 1))
		equals: #( 3 2 2 )
]

{ #category : 'tests' }
GenDurationPolicyTest >> testTheLastGapWrapsAroundTheLoop [

	self
		assert: (self durationsOf: '..x..x..' hold: 8 longNotes: 0 random: (Random seed: 1))
		equals: #( 3 5 )
]
