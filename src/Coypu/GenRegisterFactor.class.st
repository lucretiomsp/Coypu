"
Register: a bell curve keeps a voice near its center (bass low, mid around B3, lead around C#5).
"
Class {
	#name : 'GenRegisterFactor',
	#superclass : 'GenWeightFactor',
	#instVars : [
		'center',
		'width'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenRegisterFactor class >> center: aMidi width: aNumberOfSemitones [

	^ self new
		  setCenter: aMidi width: aNumberOfSemitones;
		  yourself
]

{ #category : 'accessing' }
GenRegisterFactor >> center [

	^ center
]

{ #category : 'initialization' }
GenRegisterFactor >> setCenter: aMidi width: aNumberOfSemitones [

	center := aMidi.
	width := aNumberOfSemitones
]

{ #category : 'scoring' }
GenRegisterFactor >> weightOf: aPitch in: aContext [

	^ self gaussian: aPitch midi - center width: width
]

{ #category : 'accessing' }
GenRegisterFactor >> width [

	^ width
]
