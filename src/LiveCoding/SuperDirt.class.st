"
Convenience class to interface with and get information on the SuperDirt audioEngine for SuperCollider
"
Class {
	#name : #SuperDirt,
	#superclass : #Object,
	#category : #'LiveCoding-SuperDirt'
}

{ #category : #'as yet unclassified' }
SuperDirt class >> listOfSynths [
"print on Transcript the list of SuperDirt available Synths"
| synthList  cr |
synthList := #( '##### SYNTHS #####' 'supermandolin' 'supergong' ' superpiano' 'superhex' 'supersquare'
'supersaw' 'superpwm' 'supercomparator' 'superchip' 'superfork' 'superhammond' 
'superhive' 'superzow' 'supergrind' 'superprimes' 'superwavemechanichs' 'supertron'
'superreese' 'superfm' 'supersiren' 'supernoise'
'##### DRUMS #####' 'superkick' ' super808' 'supersnare' 'superclap' ' soskick'
'soshats' 'sostoms' 'sossnare'
).
cr := 0.
Transcript clear.	
synthList do: [ :i | (cr % 3 == 0 ) ifTrue: [i traceCr. Transcript tab ] ifFalse:  [i trace. Transcript tab]. cr := cr + 1].
Transcript open.

^ synthList 
]
