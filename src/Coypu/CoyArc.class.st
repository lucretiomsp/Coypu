"
A time arc represented as two Fractions [begin, end) within a cycle. 0 is the cycle start, 1 its end. Used by the cyclic engine to query and schedule pattern events. Equivalent to Arc in TidalCycles/Vortex.
"
Class {
	#name : 'CoyArc',
	#superclass : 'Object',
	#instVars : [
		'begin',
		'end'
	],
	#category : 'Coypu-Cyclic',
	#package : 'Coypu',
	#tag : 'Cyclic'
}
