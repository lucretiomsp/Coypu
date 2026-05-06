"
A scheduled event produced by querying a pattern over a CoySpan. onset is a Fraction representing the event's position within the cycle (e.g. 1/3 means one third into the cycle). value is the musical content — a note, a dirt sample name, a midi number, or any object understood by playEventAt:in:. Analogous to Event in TidalCycles/Vortex.
"
Class {
	#name : 'CoyEvent',
	#superclass : 'Object',
	#instVars : [
		'onset',
		'value'
	],
	#category : 'Coypu-Cyclic',
	#package : 'Coypu',
	#tag : 'Cyclic'
}
