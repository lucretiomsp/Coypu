Class {
	#name : #KeyboardToKymaDrums,
	#superclass : #SimpleSwitchMorph,
	#instVars : [
		'arrayOfAddresses',
		'isHandlingKeyDown',
		'keysDictionary'
	],
	#category : #LiveCoding
}

{ #category : #'instance creation' }
KeyboardToKymaDrums class >> newWithAddresses: anArrayofAddresses [

| labels |

labels := String new.
(1 to: anArrayofAddresses size) do: [:i | labels := labels, (anArrayofAddresses at: i), ' ' ].
	^ (self new) 
		createKeyDictionary; 
		label: labels;
		arrayOfAddresses:  anArrayofAddresses  ;
		yourself
]

{ #category : #accessing }
KeyboardToKymaDrums >> arrayOfAddresses [
^ arrayOfAddresses 
]

{ #category : #accessing }
KeyboardToKymaDrums >> arrayOfAddresses: anArrayOfAddresses [
"set the array of addresses to control drums via OSC"
arrayOfAddresses := anArrayOfAddresses 
]

{ #category : #'as yet unclassified' }
KeyboardToKymaDrums >> createKeyDictionary [

keysDictionary := Dictionary new.
keysDictionary at: $a put: 1.
keysDictionary at: $s put: 2.
keysDictionary at: $d put: 3.
keysDictionary at: $f put: 4.
keysDictionary at: $g put: 5.
keysDictionary at: $h put: 6.
keysDictionary at: $j put: 7.
keysDictionary at: $k put: 8.


^ keysDictionary
]

{ #category : #'as yet unclassified' }
KeyboardToKymaDrums >> handlesKeyDown [

^ true
]

{ #category : #'event handling' }
KeyboardToKymaDrums >> handlesMouseDown: anEvent [
^ true
]

{ #category : #initialization }
KeyboardToKymaDrums >> initialize [ 
super initialize .
"not handling keydon if not clicked"
isHandlingKeyDown := false.

]

{ #category : #'event handling' }
KeyboardToKymaDrums >> mouseDown: anEvent [
super mouseDown: anEvent.

isHandlingKeyDown := isHandlingKeyDown not.
isHandlingKeyDown ifTrue: [ anEvent hand newKeyboardFocus: self. ] ifFalse: [ anEvent hand releaseKeyboardFocus: self ]
]
