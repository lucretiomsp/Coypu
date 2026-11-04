Extension { #name : 'StDebugger' }

{ #category : '*Coypu' }
StDebugger >> open [

	"one debugger can stay open while the performance plays. A second one stops it: prevents debugger explosion"
	(self application windows anySatisfy: [ :each | each presenter isKindOf: StDebugger ])
		ifTrue: [ Performance uniqueInstance stop ].
	^ super open
]
