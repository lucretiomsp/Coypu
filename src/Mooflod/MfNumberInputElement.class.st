Class {
	#name : 'MfNumberInputElement',
	#superclass : 'ToElement',
	#instVars : [
		'plus',
		'minus',
		'inputValue',
		'value',
		'inputLabel',
		'validateValueBlock'
	],
	#category : 'Mooflod-InputWidget',
	#package : 'Mooflod',
	#tag : 'InputWidget'
}

{ #category : 'example' }
MfNumberInputElement class >> openInputWithSkin [

	<script>
	| space anInput |
	space := BlSpace new.
	space toTheme: MfMooflodTheme new.
	anInput := self new position: 200 @ 200.
	space root addChild: anInput.
	space show.
	^ anInput
]

{ #category : 'buttons' }
MfNumberInputElement >> changeValueTo: aValue [

	inputValue text: (self configuredString: aValue asString).
	inputValue text fontSize: 30.
	value := aValue
]

{ #category : 'buttons' }
MfNumberInputElement >> configuredString: aString [

	^ aString asRopedText attributes: { (BlTextForegroundAttribute paint: Color white) }.
	
]

{ #category : 'buttons' }
MfNumberInputElement >> createCircle [

	| circle |
	circle := BlElement new
		          background: Color black;
		          border: (BlBorder paint: Color pink width: 2);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new.
	^ circle
]

{ #category : 'buttons' }
MfNumberInputElement >> decreaseInput [
	
	(validateValueBlock value: value - 1) ifTrue: [
		value := value - 1.
		self changeValueTo: value ]
]

{ #category : 'buttons' }
MfNumberInputElement >> increaseInput [

	(validateValueBlock value: value + 1) ifTrue: [
		value := value + 1.
		self changeValueTo: value ]
]

{ #category : 'initialization' }
MfNumberInputElement >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	self padding: (BlInsets all: 30).
	self layout: BlLinearLayout horizontal.
	self border: (BlBorder paint: Color pink).
	self validateValueBlock: [ :v | v between: 1 and: 25 ].
	self label: 'Input'.
	self initializeMinusButton.
	self initializeInputValue: 20.
	self initializePlusButton
]

{ #category : 'initialization' }
MfNumberInputElement >> initializeInputValue: aValue [

	inputValue := BlTextElement new.
	inputValue size: 30 @ 30.
	inputValue constraintsDo: [ :c | c linear vertical alignCenter ].
	self changeValueTo: aValue.
	inputValue padding: (BlInsets all: 50).
	self addChild: inputValue
]

{ #category : 'buttons' }
MfNumberInputElement >> initializeMinusButton [

	| text |
	minus := self createCircle.
	minus constraintsDo: [ :c | c linear vertical alignCenter ].

	text := BlTextElement new text: (self configuredString: '-').
	text text fontSize: 80.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	minus
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self decreaseInput ].
	minus padding: (BlInsets all: 50).
	minus addChild: text.
	self addChild: minus
]

{ #category : 'buttons' }
MfNumberInputElement >> initializePlusButton [

	| text |
	plus := self createCircle.
	plus constraintsDo: [ :c | c linear vertical alignCenter ].

	text := BlTextElement new text: (self configuredString: '+').
	text text fontSize: 55.
	text constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	plus
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self increaseInput ].
	plus padding: (BlInsets all: 50).
	plus addChild: text.
	
	self addChild: plus
]

{ #category : 'accessing' }
MfNumberInputElement >> inputExtent [ 

	^ 300@120
]

{ #category : 'accessing' }
MfNumberInputElement >> label [

	^ inputLabel 
]

{ #category : 'initialization' }
MfNumberInputElement >> label: aString [

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 25.
	inputLabel constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignCenter ].
	inputLabel padding: (BlInsets all: 10).
	self addChild: inputLabel
]

{ #category : 'accessing' }
MfNumberInputElement >> minus [
	^ minus
]

{ #category : 'instance creation' }
MfNumberInputElement >> newMooflodSkin [

	^ MfInputElementSkin new
]

{ #category : 'accessing' }
MfNumberInputElement >> plus [
	^ plus
]

{ #category : 'accessing' }
MfNumberInputElement >> validateValueBlock [

	^ validateValueBlock
]

{ #category : 'evaluating' }
MfNumberInputElement >> validateValueBlock: aBlock [

	validateValueBlock := aBlock
]

{ #category : 'evaluating' }
MfNumberInputElement >> value [

	^ value
]

{ #category : 'initialization' }
MfNumberInputElement >> value: anInteger [

	value := anInteger 
]
