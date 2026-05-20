"
I represent a MondoNotation angle-bracket alternation in Mondo Syntax: a
sequence of choices that picks a different element on each cycle.

Notation: `<a b c>` picks a on cycle 1, b on cycle 2, c on cycle 3, then
wraps. The optional `*N` suffix speeds the alternation up N-fold, so
`<a b>*4` fires four times per cycle, advancing through the choices on
each firing.

State:
	choices  — Array of the available alternatives (Strings as they
	           appear in the source, e.g. 'bd', '60', '~').
	speed    — Integer multiplier from the `*N` suffix (default 1).

The choice for a given moment is computed by:
	((cycleIndex - 1) * speed + (slotIndex - 1)) modulo choices size

where slotIndex distinguishes multiple firings within one cycle (always
1 when speed is 1).

Resolution methods are context-dependent:
	resolveForNotes:slot:   — returns a MIDI integer, or nil for a rest
	                          (~ or - in the source).
	resolveForSounds:slot:  — returns Array(soundName, midiNote) for
	                          Phausto routing, or nil for a rest.

I am produced at parse time by `parseMondoAlternation` and embedded in
the sequencer's rawNotes as part of a leaf-value tuple
Array(self, slotIndex). The cyclic player's precompute pass
(`precomputeResolvedCyclesFor:`) flattens all alternations into per-cycle
arrays (`resolvedCycles`, `resolvedGates`, optionally
`resolvedGateDestinations` and `resolvedNoteDestinations`), so playback
itself is a pure O(1) array lookup with no further dispatch.

Adding new resolution contexts (e.g. OSC, MIDI CC) means adding a
`resolveFor*:slot:` method. If the number of contexts grows, splitting
into subclasses (`MondoNoteAlternation`, `MondoSoundAlternation`) is the
expected refactor path.
"
Class {
	#name : 'MondoAlternation',
	#superclass : 'Object',
	#instVars : [
		'choices',
		'speed'
	],
	#category : 'Coypu-Cyclic',
	#package : 'Coypu',
	#tag : 'Cyclic'
}

{ #category : 'as yet unclassified' }
MondoAlternation class >> choices: anArray [
	^ self new choices: anArray; speed: 1; yourself
]

{ #category : 'as yet unclassified' }
MondoAlternation class >> choices: anArray speed: anInteger [
	^ self new choices: anArray; speed: anInteger; yourself

]

{ #category : 'accessing' }
MondoAlternation >> choices [
	^ choices
]

{ #category : 'accessing' }
MondoAlternation >> choices: anArray [
	choices := anArray
]

{ #category : 'resolving' }
MondoAlternation >> chooseForCycle: cycleIndex slot: slotIndex [
	"Pick the choice for a given cycle. slotIndex is which sub-step within the cycle (1-based)."
	| effectiveIndex |
	effectiveIndex := ((cycleIndex - 1) * speed + (slotIndex - 1)) \\ choices size + 1.
	^ choices at: effectiveIndex
]

{ #category : 'resolving' }
MondoAlternation >> resolveForSounds: cycleIndex slot: slotIdx [
	"Return Array(soundName, midiNote) or nil for rest"
	| chosen name |
	chosen := self chooseForCycle: cycleIndex slot: slotIdx.
	(#('~' '-') includes: chosen) ifTrue: [ ^ nil ].
	name := chosen copyUpTo: $:.
	^ Array
		with: name
		with: (Performance uniqueInstance performer noteFromSoundToken: chosen)
]

{ #category : 'accessing' }
MondoAlternation >> speed [ 
^ speed
]

{ #category : 'accessing' }
MondoAlternation >> speed: anInteger [

speed := anInteger
]
