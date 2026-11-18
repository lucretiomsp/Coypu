"
Tests for GenScaleLibrary.
"
Class {
	#name : 'GenScaleLibraryTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
GenScaleLibraryTest >> testDefaultIsShared [

	self assert: GenScaleLibrary default identicalTo: GenScaleLibrary default
]

{ #category : 'tests' }
GenScaleLibraryTest >> testHasTheSuperColliderScales [

	self assert: GenScaleLibrary default size equals: 108.
	self assert: GenScaleLibrary default keys asSet size equals: 108
]

{ #category : 'tests' }
GenScaleLibraryTest >> testLookup [

	| library |
	library := GenScaleLibrary default.
	self assert: (library at: #dorian) name equals: 'Dorian'.
	self assert: (library at: #partch_o1) tuning size equals: 43.
	self assert: (library at: #bayati) tuning size equals: 24.
	self deny: (library includesKey: #noSuchScale).
	self assert: (library at: #noSuchScale ifAbsent: [ #none ]) equals: #none
]

{ #category : 'tests' }
GenScaleLibraryTest >> testRandomScaleComesFromTheLibrary [

	| library |
	library := GenScaleLibrary default.
	self
		assert: (library randomScale: (GenScriptedRandom values: #( 0.0 )))
		equals: (library at: library keys first).
	self
		assert: (library randomScale: (GenScriptedRandom values: #( 0.999 )))
		equals: (library at: library keys last)
]

{ #category : 'tests' }
GenScaleLibraryTest >> testScalesAreWellFormed [

	GenScaleLibrary default scales do: [ :each |
		self assert: each degrees first equals: 0.
		self assert: (each degrees allSatisfy: [ :degree | degree < each tuning size ]).
		1 to: each size - 1 do: [ :index |
			self assert: (each degrees at: index) < (each degrees at: index + 1) ].
		each hasDescendingForm ifTrue: [
			self assert: each descendingDegrees size equals: each size ] ]
]

{ #category : 'tests' }
GenScaleLibraryTest >> testScalesWithADescendingForm [

	#( #melodicMinor #sikah #nahawand #rast #yakah #hijaz ) do: [ :each |
		self assert: (GenScaleLibrary default at: each) hasDescendingForm ].
	self deny: (GenScaleLibrary default at: #major) hasDescendingForm.
	self deny: (GenScaleLibrary default at: #melodicMinorDesc) hasDescendingForm
]
