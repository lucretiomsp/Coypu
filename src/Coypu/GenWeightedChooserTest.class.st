"
Tests for GenWeightedChooser.
"
Class {
	#name : 'GenWeightedChooserTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenWeightedChooserTest >> chooserWith: someValues [

	^ GenWeightedChooser random: (GenScriptedRandom values: someValues)
]

{ #category : 'tests' }
GenWeightedChooserTest >> testAllZeroFallsBackToUniform [

	self assert: ((self chooserWith: #( 0.5 )) indexFor: #( 0 0 0 )) equals: 2
]

{ #category : 'tests' }
GenWeightedChooserTest >> testChooseAnswersTheCandidate [

	self assert: ((self chooserWith: #( 0.9 )) choose: #( #a #b ) weights: #( 1 1 )) equals: #b
]

{ #category : 'tests' }
GenWeightedChooserTest >> testDrawIsProportionalToTheWeights [

	self assert: ((self chooserWith: #( 0.1 )) indexFor: #( 1 1 2 )) equals: 1.
	self assert: ((self chooserWith: #( 0.3 )) indexFor: #( 1 1 2 )) equals: 2.
	self assert: ((self chooserWith: #( 0.6 )) indexFor: #( 1 1 2 )) equals: 3
]

{ #category : 'tests' }
GenWeightedChooserTest >> testEmptyCandidatesAreAnError [

	self should: [ (self chooserWith: #( 0.5 )) choose: #(  ) weights: #(  ) ] raise: Error
]

{ #category : 'tests' }
GenWeightedChooserTest >> testMismatchedSizesAreAnError [

	self should: [ (self chooserWith: #( 0.5 )) choose: #( #a ) weights: #( 1 2 ) ] raise: Error
]

{ #category : 'tests' }
GenWeightedChooserTest >> testSharpeningFavoursStrongCandidates [

	| plain sharp |
	plain := GenWeightedChooser random: (GenScriptedRandom values: #( 0.25 )) sharpness: 1.
	sharp := GenWeightedChooser random: (GenScriptedRandom values: #( 0.25 )) sharpness: 2.
	self assert: (plain indexFor: #( 1 2 )) equals: 1.
	self assert: (sharp indexFor: #( 1 2 )) equals: 2
]

{ #category : 'tests' }
GenWeightedChooserTest >> testZeroWeightsNeverWin [

	#( 0.0 0.5 0.99 ) do: [ :each |
		self assert: ((self chooserWith: { each }) indexFor: #( 0 1 0 )) equals: 2 ]
]
