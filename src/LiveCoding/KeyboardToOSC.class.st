"
A bodered morph thats when mouse is over sends OSC messages in a MIDI keyboard fashion to the desired OSC adddress.
"
Class {
	#name : #KeyboardToOSC,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'noteDictionary',
		'address',
		'octave',
		'isHandlingKeyDown',
		'key'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
KeyboardToOSC class >> newWithAddress: anAddress [

	^(self new) 
		label: anAddress ;
		address: anAddress ;
		yourself
]

{ #category : #accessing }
KeyboardToOSC >> address [
^ address.
]

{ #category : #accessing }
KeyboardToOSC >> address: aStringAddress [
address := aStringAddress.
^ aStringAddress.
]

{ #category : #'event handling' }
KeyboardToOSC >> handlesKeyDown: anEvent [
| debug kv |
"keyboard up arrow = 30, keyboard down arrow = 31"
debug := self keyAsMIDINoteNumber: anEvent.
key := self keyAsMIDINoteNumber: anEvent.
 .
kv :=  anEvent keyValue.
(kv = 30) ifTrue: [  octave := octave + 1] ifFalse: [(kv = 31) ifTrue: [octave := octave -1] ifFalse: [ nil]].
 Transcript show: (key + (octave * 12)) asString, ' '.
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
"the notea dictionary"
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

]

{ #category : #'as yet unclassified' }
KeyboardToOSC >> keyAsMIDINoteNumber: anEvent [
"if the key pressed corresponds to a MIDI note, returns the MIDI note otherwise returns -1"
| keyPressed result |
keyPressed := anEvent keyCharacter asSymbol.
(noteDictionary includesKey: keyPressed) ifTrue: [ result := noteDictionary at: keyPressed ] ifFalse: [ result := -1].
^ result


]

{ #category : #'event handling' }
KeyboardToOSC >> keyDown: anEvent [


key := self keyAsMIDINoteNumber: anEvent.
"key = 60 ifTrue: [ self color: Color yellow ]."
" if the key pressed corresponds to a MIDI note"
((key ~= -1) & isHandlingKeyDown) ifTrue: [  address toLocalAsGate: 0.1 note: key + (octave * 12)] ifFalse:[nil]
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseDown: anEvent [
super mouseDown: anEvent.

isHandlingKeyDown := isHandlingKeyDown not.
isHandlingKeyDown ifTrue: [ anEvent hand newKeyboardFocus: self. ] ifFalse: [ anEvent hand releaseKeyboardFocus: self ]
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseEnter: anEvent [
"anEvent hand newKeyboardFocus: self"
]

{ #category : #'event handling' }
KeyboardToOSC >> mouseLeave: anEvent [
anEvent hand newKeyboardFocus: self
]

{ #category : #accessing }
KeyboardToOSC >> noteDictionary [
^ noteDictionary
]
