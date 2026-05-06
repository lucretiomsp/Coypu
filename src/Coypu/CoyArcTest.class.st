Class {
	#name : 'CoyArcTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
CoyArcTest >> testIncludesTimeAtEndIsExclusive [
    self deny: ((CoyArc from: 0 to: 1) includesTime: 1).
]

{ #category : 'tests' }
CoyArcTest >> testIncludesTimeAtStart [
    self assert: ((CoyArc from: 0 to: 1) includesTime: 0).

]

{ #category : 'tests' }
CoyArcTest >> testIncludesTimeInMiddle [
    self assert: ((CoyArc from: 0 to: 1) includesTime: 1/2).

]

{ #category : 'tests' }
CoyArcTest >> testInitialization [
    | arc |
    arc := CoyArc from: 0 to: 1.
    self assert: arc begin equals: 0.
    self assert: arc end equals: 1.
]

{ #category : 'tests' }
CoyArcTest >> testInitializationWithFractions [
    | arc |
    arc := CoyArc from: 1/3 to: 2/3.
    self assert: arc begin equals: 1/3.
    self assert: arc end equals: 2/3.
]

{ #category : 'tests' }
CoyArcTest >> testSectContained [
    | a b result |
    a := CoyArc from: 0 to: 1.
    b := CoyArc from: 1/4 to: 3/4.
    result := a sect: b.
    self assert: result equals: (CoyArc from: 1/4 to: 3/4)
]

{ #category : 'as yet unclassified' }
CoyArcTest >> testSectNoOverlap [
   | a b result |
    a := CoyArc from: 0 to: 1/3.
    b := CoyArc from: 2/3 to: 1.
    result := a sect: b.
    self assert: result duration equals: 0.
]

{ #category : 'tests' }
CoyArcTest >> testSectOverlapping [
    | a b result |
    a := CoyArc from: 0 to: 2/3.
    b := CoyArc from: 1/3 to: 1.
    result := a sect: b.
    self assert: result equals: (CoyArc from: 1/3 to: 2/3).
]
