Class {
	#name : 'MfNumberInputElementTest',
	#superclass : 'TestCase',
	#category : 'Mooflod-InputWidget',
	#package : 'Mooflod',
	#tag : 'InputWidget'
}

{ #category : 'tests' }
MfNumberInputElementTest >> testCanChangeLabel [

	| inputElem |
	inputElem := MfNumberInputElement new.
	self assert: inputElem label text asString equals: 'Input'.
	inputElem label: 'Volume'.
	self assert: inputElem label text asString equals: 'Volume'
]

{ #category : 'tests' }
MfNumberInputElementTest >> testEverythingIsInitializedCorrectly [

	| inputElem |
	inputElem := MfNumberInputElement new.
	self assert: inputElem children size equals: 4
]

{ #category : 'tests' }
MfNumberInputElementTest >> testValueCantBeNegative [

	| inputElem value |
	inputElem := MfNumberInputElement new.
	inputElem changeValueTo: 0.
	BlSpace simulateClickOn: inputElem minus.
	value := inputElem value.
	self assert: value equals: 0
]

{ #category : 'tests' }
MfNumberInputElementTest >> testValueUpdatedOnClick [

	| inputElem |
	inputElem := MfNumberInputElement new.
	BlSpace simulateClickOn: inputElem minus.
	self assert: inputElem value equals: 19.
	6 timesRepeat: [ BlSpace simulateClickOn: inputElem plus ].
	self assert: inputElem value equals: 25
]
