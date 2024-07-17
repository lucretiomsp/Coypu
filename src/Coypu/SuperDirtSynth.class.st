Class {
	#name : 'SuperDirtSynth',
	#superclass : 'Object',
	#instVars : [
		'parameters',
		'name'
	],
	#category : 'Coypu-SuperDirt',
	#package : 'Coypu',
	#tag : 'SuperDirt'
}

{ #category : 'instance creation' }
SuperDirtSynth class >> name: aString parameters: aCollection [

	^ self new
		  name: aString;
		  parameters: aCollection;
		  yourself
]

{ #category : 'accessing' }
SuperDirtSynth >> name [

	^ name
]

{ #category : 'accessing' }
SuperDirtSynth >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SuperDirtSynth >> parameters [

	^ parameters
]

{ #category : 'accessing' }
SuperDirtSynth >> parameters: anObject [

	parameters := anObject
]
