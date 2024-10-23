Class {
	#name : 'MfPianoTests',
	#superclass : 'TestCase',
	#category : 'Mooflod-PianoKeyboardWidget',
	#package : 'Mooflod',
	#tag : 'PianoKeyboardWidget'
}

{ #category : 'tests' }
MfPianoTests >> testNoteChangesOnClick [

	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'E'.
	self assert: p whitenotes first background paint color equals: p whiteKeyColor.
	p whitenotes do: [ :n |
		BlSpace simulateMouseDownOn: n.
		self assert: n background paint color equals: Color lightGray ]
]

{ #category : 'tests' }
MfPianoTests >> testNotesInitializedCorrectly [

	| p |
	p := MfPianoElement new startNote: 'C'.
	self assert: p whitenotes size + p blacknotes size  equals: 24
]

{ #category : 'tests' }
MfPianoTests >> testStartingNoteUpdatePiano [

	| p |
	p := MfPianoElement new startNote: 'F'.
	"start note is F so there's the position of each black note for the start note F"
	self
		assert: p initializeNotes
		equals: #( 24 39 39 68 36 70 39 39 68 36 )
]

{ #category : 'tests' }
MfPianoTests >> testTwoPianoCanHaveDifferentOctaves [

	| p1 p2 |
	p1 := MfPianoElement new
		     nOctaves: 3;
		     startNote: 'E'.
	self assert: p1 nOctaves equals: 3.
	p2 := MfPianoElement new.
	self assert: p2 nOctaves equals: 2.
	self assert: p1 nOctaves ~= p2 nOctaves.
]

{ #category : 'tests' }
MfPianoTests >> testTwoPianoCanHaveDifferentStartNote [

	| p1 p2 |
	p1 := MfPianoElement new
		      nOctaves: 3;
		      startNote: 'E'.
	self assert: p1 startNote equals: 'E'.
	p2 := MfPianoElement new.
	self assert: p2 startNote equals: 'C'.
]
