"
A bodered morph thats when mouse is over sends OSC messages in a MIDI keyboard fashion to the desired OSC adddress.
"
Class {
	#name : #KeyboardToOSC,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'noteArray',
		'noteDictionary',
		'address',
		'octave',
		'isHandlingKeyDown',
		'key',
		'mouseWheelValue'
	],
	#category : #'Coypu-KeyboardControl'
}

{ #category : #'instance creation' }
KeyboardToOSC class >> newWithAddress: anAddress [

	^ self new
		label: anAddress ;
		address: anAddress ;
		yourself
]

{ #category : #accessing }
KeyboardToOSC >> address [
	^ address
]

{ #category : #accessing }
KeyboardToOSC >> address: aStringAddress [
	address := aStringAddress.
	
]

{ #category : #'as yet unclassified' }
KeyboardToOSC >> fillNoteListDictionary [
 
	noteDictionary := Dictionary new.
	noteDictionary at: #a put: 60.
	noteDictionary at: #w put: 61.
	noteDictionary at: #s put: 62.
	noteDictionary at: #e put: 63.
	noteDictionary at: #d put: 64.
	noteDictionary at: #r put: 65.
	noteDictionary at: #f put: 66.
	noteDictionary at: #t put: 67.
	noteDictionary at: #g put: 68.
	noteDictionary at: #y put: 69.
	noteDictionary at: #h put: 70.
	noteDictionary at: #j put: 71.
	noteDictionary at: #k put: 72.

	"the note Array, 2 octaves chromatic keyboard"
	noteArray := Array new: 128.
	"lower octave"
	noteArray at: $a asciiValue put: 35. "B"
	noteArray at: $z asciiValue put: 36. "C"
	noteArray at: $s asciiValue put: 37.
	noteArray at: $x asciiValue put: 38. "D"
	noteArray at: $d asciiValue put: 39.
	noteArray at: $c asciiValue put: 40. "E"
	noteArray at: $v asciiValue put: 41. "F"
	noteArray at: $g asciiValue put: 42.
	noteArray at: $b asciiValue put: 43.
	noteArray at: $h asciiValue put: 44.
	noteArray at: $n asciiValue put: 45.
	noteArray at: $j asciiValue put: 46.
	noteArray at: $m asciiValue put: 47.
	noteArray at: $, asciiValue put: 48.
	noteArray at: $k asciiValue put: 49.
	noteArray at: $. asciiValue put: 50.
	noteArray at: $l asciiValue put: 51.
	noteArray at: $. asciiValue put: 52.
	noteArray at: $/ asciiValue put: 53.
	"upper octave"
	noteArray at: $q asciiValue put: 48. "C"
	noteArray at: $2 asciiValue put: 49.
	noteArray at: $w asciiValue put: 50. "D"
	noteArray at: $3 asciiValue put: 51.
	noteArray at: $e asciiValue put: 52. "E"
	noteArray at: $r asciiValue put: 53. "F"
	noteArray at: $5 asciiValue put: 54.
	noteArray at: $t asciiValue put: 55. "G"
	noteArray at: $6 asciiValue put: 56.
	noteArray at: $y asciiValue put: 57. "A"
	noteArray at: $7 asciiValue put: 58.
	noteArray at: $u asciiValue put: 59.
	noteArray at: $i asciiValue put: 60. "C"
	noteArray at: $9 asciiValue put: 61.
	noteArray at: $o asciiValue put: 62. "D"
	noteArray at: $0 asciiValue put: 63.
	noteArray at: $p asciiValue put: 64. "E"
	noteArray at: $[ asciiValue put: 65. "F"
	noteArray at: $= asciiValue put: 65. "F"
	noteArray at: $] asciiValue put: 67
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesKeyDown: anEvent [
	| debug kv |
	"keyboard up arrow = 30, keyboard down arrow = 31"
	debug := self keyAsMIDINoteNumber: anEvent.
	key := self keyAsMIDINoteNumber: anEvent.

	kv :=  anEvent keyValue.
	(kv = 30) ifTrue: [  octave := octave + 1] ifFalse: [(kv = 31) ifTrue: [octave := octave -1] ifFalse: [ nil]].
 	Transcript show: (key + (octave * 12)) asString, ' '.
	^ true
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesKeyUp: anEvent [

	^ true
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesMouseDown: anEvent [
	^ true
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesMouseOver: anEvent [
	^ true
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesMouseWheel: anEvent [
	^ true
]

{ #category : #adding }
KeyboardToOSC >> initialize [

	super initialize.

	"key is 60 at the begiing / middle C"
	key := 60.
	"not handling keydon if not clicked"
	isHandlingKeyDown := false.
	"dummy OSC address"
	address := 'nothing'.
	" octave"
	octave := 0.

	"initial mouseWheelValue"
	mouseWheelValue := 0.

	self fillNoteListDictionary
]

{ #category : #'as yet unclassified' }
KeyboardToOSC >> keyAsMIDINoteNumber: anEvent [
	"if the key pressed corresponds to a MIDI note, returns the MIDI note otherwise returns -1"

	| keyPressed result |
	"implementation with noteDictionary
	keyPressed := anEvent keyCharacter asSymbol.
	(noteDictionary includesKey: keyPressed) ifTrue: [ result := noteDictionary at: keyPressed ] 	ifFalse: [ result := -1].
	"

	"implementation with noteArray"
	keyPressed := anEvent keyCharacter asciiValue.
	((keyPressed ~= 0) & (keyPressed < 128)) 
		ifTrue: [ ((noteArray at: keyPressed ) isNotNil )  
					ifTrue: [ result := noteArray at: keyPressed ] 
					ifFalse: [ result := -1 ]] ifFalse: [result := -1].
	^ result


]

{ #category : #'event handling' }
KeyboardToOSC >> keyDown: anEvent [

	key := self keyAsMIDINoteNumber: anEvent.
	"key = 60 ifTrue: [ self color: Color yellow ]."
	" if the key pressed corresponds to a MIDI note"
	((key ~= -1) & isHandlingKeyDown) 
		ifTrue: [  address toLocalAsGate: 0.1 note: key + (octave * 12)] 	
		
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseDown: anEvent [

	super mouseDown: anEvent.
	isHandlingKeyDown := isHandlingKeyDown not.
	isHandlingKeyDown 
		ifTrue: [ anEvent hand newKeyboardFocus: self ] 
		ifFalse: [ anEvent hand releaseKeyboardFocus: self ]
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseEnter: anEvent [
"anEvent hand newKeyboardFocus: self"
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseLeave: anEvent [
	anEvent hand newKeyboardFocus: self
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseWheel: anEvent [

	anEvent isUp 
		ifTrue: [ mouseWheelValue  := mouseWheelValue  -1. mouseWheelValue  toKyma: 'SawDetune'].
	anEvent isDown 
		ifTrue: [ mouseWheelValue  := mouseWheelValue  +1. mouseWheelValue  toKyma: 'SawDetune'].
]

{ #category : #accessing }
KeyboardToOSC >> noteDictionary [
	^ noteDictionary
]

{ #category : #'as yet unclassified' }
KeyboardToOSC >> openInWindow [

	| buttonWidth buttonHeight positionLeft positionTop |
	 
	buttonWidth := 200.
	buttonHeight := 200.
	positionLeft := 627.
	positionTop := 354.

	^ ((self openInWindowLabeled: self sound) position:
		   positionLeft @ positionTop) extent: buttonWidth @ buttonHeight
]
