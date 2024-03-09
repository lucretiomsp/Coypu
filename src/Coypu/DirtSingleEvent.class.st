"
use this class to send out single evnts to the SuperDirt audio engine
"
Class {
	#name : #DirtSingleEvent,
	#superclass : #Object,
	#instVars : [
		'dirtMessage'
	],
	#category : #'Coypu-SuperDirt'
}

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> add: anAssociationParameterValue [
"add a string and a number to the dirtMessage, corresponding to a parameter for SuperDirt and its value ".
self dirtMessage add: anAssociationParameterValue key asString ; add: anAssociationParameterValue value
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> delay: anInteger [
"change dry/wet delay  for the sound ".
self dirtMessage add: 'delay'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> delta: anInteger [
"change deltaduration for the sound ".
self dirtMessage add: 'delta'; add: anInteger
]

{ #category : #accessing }
DirtSingleEvent >> dirtMessage [

	^ dirtMessage
]

{ #category : #accessing }
DirtSingleEvent >> dirtMessage: anObject [

	dirtMessage := anObject
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> fb: anInteger [
"change deleay feedback for the sound ".
self dirtMessage add: 'delayfb'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> gain: anInteger [
"change gain for the sound ".
self dirtMessage add: 'gain'; add: anInteger
]

{ #category : #initialization }
DirtSingleEvent >> initialize [ 
super initialize .
dirtMessage := OrderedCollection new add: '/dirt/play'; yourself.

]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> note: anInteger [
"select the note or the folder index for the single event with the name of a folder in the SuperDirt sample folder".
self dirtMessage add: 'n'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> pan: aFloat [
"change stereo panorama for the sound  - 0 hard left, 1 hard righ".
self dirtMessage add: 'pan'; add: aFloat
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> phaserAmount: anInteger [
"change phaserRate for the sound ".
self dirtMessage add: 'phaserdepth'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> phaserRate: anInteger [
"change phaserRate for the sound ".
self dirtMessage add: 'phaserrate'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> room: anIntegerFromZeroToOne [
"addReverb to the sound - it controls the dry/wet balance, for 0 is dry and  1 is wet".
self dirtMessage add: 'room'; add: anIntegerFromZeroToOne 
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> send [ 
"sends the event to SuperDirt"
(OSCMessage for: self dirtMessage ) sendToAddressString:  '127.0.0.1' port: 57120 
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> size: anInteger [
"change reverb size for the sound ".
self dirtMessage add: 'size'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> sound: aString [
"select a sound for the single event with the name of a folder in the SuperDirt sample folder"
"for DirtSingleEventss folder inex after colons is discarded - use note: to set noteIndex"
| parsedString sound |

parsedString := (aString findBetweenSubstrings: ':') .
sound := parsedString at: 1. 
self dirtMessage add: 's'; add: sound.
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> speed: anInteger [
"select the pitch of the sample".
self dirtMessage add: 'speed'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> squiz: anInteger [
"change squiz amount for the sound ".
self dirtMessage add: 'size'; add: anInteger
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> time: aFloat [
"change deleay time for the sound ".
self dirtMessage add: 'delaytime'; add: aFloat
]

{ #category : #'LiveCoding  - SuperDirt' }
DirtSingleEvent >> voice: aFloat [
"change voice parameter  for synthesizer".
self dirtMessage add: 'voice'; add: aFloat
]
