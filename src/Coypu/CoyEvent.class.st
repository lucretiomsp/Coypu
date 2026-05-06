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

{ #category : 'as yet unclassified' }
CoyEvent class >> onset: aFraction value: anObject [
  
    ^ self new onset: aFraction; value: anObject; yourself

]

{ #category : 'accessing' }
CoyEvent >> = anObject [ 
^ anObject class = self class 
   and: [  onset = anObject onset 
   and: [ value = anObject value ]]

]

{ #category : 'comparing' }
CoyEvent >> hash [ 
^ onset hash bitXor: value hash.
]

{ #category : 'accessing' }
CoyEvent >> onset [ 
^ onset 
]

{ #category : 'accessing' }
CoyEvent >> onset: aFraction [
  
    onset := aFraction
]

{ #category : 'printing' }
CoyEvent >> printOn: aStream [
  
    | onsetString |
    onsetString := onset isInteger
        ifTrue: [ onset printString ]
        ifFalse: [ onset numerator printString , '/' , onset denominator printString ].
    aStream
        nextPutAll: 'CoyEvent(';
        nextPutAll: onsetString;
        nextPutAll: ' -> ';
        print: value;
        nextPut: $)
]

{ #category : 'accessing' }
CoyEvent >> value [ 
^ value
]

{ #category : 'accessing' }
CoyEvent >> value: anObject [
    <cyclicEssentials>
    value := anObject
]
