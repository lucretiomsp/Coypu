Extension { #name : 'StDebugger' }

{ #category : '*Coypu' }
StDebugger >> open [

	super open.
	"prevents debugs explosion"
	Performance uniqueInstance stop.
]
