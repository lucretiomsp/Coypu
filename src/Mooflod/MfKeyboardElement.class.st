"
This is copy of the original bloc BlDevKeyboardElement.
In particular this keyboard works independently from the language layout. 
"
Class {
	#name : 'MfKeyboardElement',
	#superclass : 'ToElement',
	#instVars : [
		'keymap'
	],
	#category : 'Mooflod-KeyboardWidget',
	#package : 'Mooflod',
	#tag : 'KeyboardWidget'
}

{ #category : 'examples' }
MfKeyboardElement class >> example [

	<script>
	self new openInSpace
]

{ #category : 'examples' }
MfKeyboardElement class >> exampleSimpleKeyboard [

	<script>
	| k space |
	k := MfKeyboardElement new.
	space := BlSpace new extent: World extent x / 6 @ World extent y.
	space useMorphicHost.
	space toTheme: MfMooflodTheme new.
	k transformDo: [ :c |
		c rotateBy: 90.
		c translateBy: -270 @ 300 ].
	space root addChild: k.
	space show.
	^ space
]

{ #category : 'initialization' }
MfKeyboardElement >> addButton: anElement key: aKey [
	"add the key passed as parameter to the key dictionnary"
	keymap at: aKey put: anElement.
	self addChild: anElement
]

{ #category : 'as yet unclassified' }
MfKeyboardElement >> illuminateKey: aButton [

	| illumination innerText |
	"illuminate the pressed Key for 10 milliseconds"
	innerText := aButton children first.
	illumination := [
	                aButton background: Color yellow.



	                aButton zIndex: 100.
	                aButton transformDo: [ :builder |
		                builder scaleBy: 2.2 ].
	                innerText transformDo: [ :builder |
		                builder scaleBy: 2.2 ].


	                (Delay forMilliseconds: 200) wait.

	                aButton transformDo: [ :builder |
		                builder scaleBy: 1.0 ].
	innerText transformDo: [ :builder | builder scaleBy: 1 ].
	                aButton zIndex: 1.

	                aButton background: Color black ].
	
	^ illumination
]

{ #category : 'initialization' }
MfKeyboardElement >> initialize [

	super initialize.

	self layout: BlFlowLayout new.
	self size: self keyboardWidth @ self keyboardHeight.
	self background: Color gray.

	keymap := Dictionary new.

	self initializeKeys.
	self initializeEventListeners.
	self requestFocus.
	self receiveKeyEventsFromLastPlayground 
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeBottomRow [
	"add all keys from the bottom row of keyboard"
	self addButton: (self simpleSmallKey: 'fn') key: KeyboardKey function.
	self addButton: (self simpleSmallKey: 'control') key: KeyboardKey controlLeft.
	self addButton: (self simpleSmallKey: 'option') key: KeyboardKey altLeft.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: KeyboardKey superLeft.
	self addButton: (self wideSmallKey: '' span: 4.5) key: KeyboardKey space.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: KeyboardKey superRight.
	self addButton: (self simpleSmallKey: 'option') key: KeyboardKey altRight.
	
	self addButton: (self simpleSmallKey: 'left') key: KeyboardKey left.
	self addButton: (self simpleSmallKey: 'up') key: KeyboardKey up.
	self addButton: (self simpleSmallKey: 'right') key: KeyboardKey right.
	self addButton: (self simpleSmallKey: 'down') key: KeyboardKey down.
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeEventListeners [
	"when pressing a key, changes the color of it and notify a down/unknown if the key is not in the dico"

	self
		addEventHandlerOn: BlKeyDownEvent
		do: [ :anEvent | "doing the same when keyup by reset the key color and sending up notification""self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color black ] ]"
			keymap
				at: anEvent key
				ifPresent: [ :aButton | (self illuminateKey: aButton)fork ]
				ifAbsent: [ "self inform: 'Unknown: ' , anEvent key asString."
					NonInteractiveTranscript stdout
						show: 'Unknown: ' , anEvent key asString;
						cr ] ]
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeFirstRow [
	| theKeys |
	"add all keys from first row to the keys dico"
	self addButton: (self wideKey: 'tab' span: 1.45) key: KeyboardKey tab.
	
	theKeys := #(Q W E R T Y U I O P) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '[') key: KeyboardKey bracketLeft.
	self addButton: (self simpleKey: ']') key: KeyboardKey bracketRight.
	self addButton: (self simpleKey: '\') key: KeyboardKey backslash.
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeKeys [
	self initializeTopRow.
	self initializeFirstRow.
	self initializeSecondRow.
	self initializeThirdRow.
	self initializeBottomRow
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeSecondRow [
	| theKeys |
	
	self addButton: (self wideKey: 'capslock' span: 1.8) key: KeyboardKey capsLock.

	theKeys := #(A S D F G H J K L) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ';') key: KeyboardKey semicolon.
	self addButton: (self simpleKey: '''') key: KeyboardKey quote.
	self addButton: (self wideKey: 'return' span: 1.8) key: KeyboardKey enter.
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeThirdRow [
	| theKeys |
	"add all keys in the third row, for example the shift left key is a big key
	so we add it as a wideKey"
	self addButton: (self wideKey: 'shift' span: 2.42) key: KeyboardKey shiftLeft.
	
	theKeys := #(Z X C V B N M) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ',') key: KeyboardKey comma.
	self addButton: (self simpleKey: '.') key: KeyboardKey period.
	self addButton: (self simpleKey: '/') key: KeyboardKey slash.
	
	self addButton: (self wideKey: 'shift' span: 2.42) key: KeyboardKey shiftRight.
]

{ #category : 'initialization' }
MfKeyboardElement >> initializeTopRow [
	| theKeys |
	
	self addButton: (self simpleKey: '`') key: KeyboardKey grave.
	
	theKeys := #(one two three four five six seven eight nine zero) collect: [ :each | KeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '-') key: KeyboardKey minus.
	self addButton: (self simpleKey: '=') key: KeyboardKey equal.
	self addButton: (self wideKey: 'delete' span: 1.45) key: KeyboardKey backspace.
]

{ #category : 'geometry' }
MfKeyboardElement >> keyboardHeight [
"sets the keyboard widget height"
	^ (5 * self rowHeight) + ((5 * 2 + 1) * self spacing)
]

{ #category : 'geometry' }
MfKeyboardElement >> keyboardWidth [
	"sets the keyboard widget width"
	^ self rowWidth
]

{ #category : 'accessing' }
MfKeyboardElement >> keymap [ 

	^keymap.
]

{ #category : 'instance creation' }
MfKeyboardElement >> newButton: anExtent [
	"creates an instance of button and give its graphical properties"

	^ BlElement new
		  size: anExtent;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		  layout: BlFrameLayout new;
		  effect: (BlGaussianShadowEffect
				   color: (Color black alpha: 0.1)
				   width: 2
				   offset: 0 @ 1);
		  margin: (BlInsets all: self spacing);
		  background: Color black
]

{ #category : 'as yet unclassified' }
MfKeyboardElement >> openInMooflod [

	| space |
	space := BlSpace new extent: World extent x / 6 @ World extent y.
	space useMorphicHost.
	space toTheme: MfMooflodTheme new.

	self transformDo: [ :c |
		c rotateBy: 90.
		c translateBy: -270 @ 250 ].
	space root addChild: self.

	space root position: 0 @ 20.
	space show.
	^ space
]

{ #category : 'as yet unclassified' }
MfKeyboardElement >> receiveKeyEventsFromLastPlayground [

	| eventHandler |
	eventHandler := StPlaygroundPagePresenter allSubInstances last text
		                eventHandler.
	eventHandler
		whenKeyDownDo: [ :event |
			BlSpace simulateKeyDownOn: self key: event key ];
		whenKeyUpDo: [ :event |
			BlSpace simulateKeyUpOn: self key: event key ]
]

{ #category : 'geometry' }
MfKeyboardElement >> rowHeight [
	^ 35
]

{ #category : 'geometry' }
MfKeyboardElement >> rowWidth [
	^ (13 * self simpleKeyWidth) + (self wideWidth: 1.5) + ((14 * 2) * self spacing)
]

{ #category : 'instance creation' }
MfKeyboardElement >> simpleKey: aString [

	| button label |
	"assign a key to the button instance created by newButton: "
	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 18).
	label text  attributes:
		{ (BlTextForegroundAttribute paint: Color red) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : 'geometry' }
MfKeyboardElement >> simpleKeyExtent [
	^ self simpleKeyWidth @ self rowHeight
]

{ #category : 'geometry' }
MfKeyboardElement >> simpleKeyWidth [
	^ self rowHeight * 1.2
]

{ #category : 'instance creation' }
MfKeyboardElement >> simpleSmallKey: aString [

	| button label |
	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 11).
		label text attributes:
		{ (BlTextForegroundAttribute paint: Color red) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : 'geometry' }
MfKeyboardElement >> spacing [
	^ 5
]

{ #category : 'instance creation' }
MfKeyboardElement >> wideKey: aString span: aNumber [

	| button label |
	button := self newButton: (self wideWidth: aNumber) @ self rowHeight.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 13).
		label text attributes:
		{ (BlTextForegroundAttribute paint: Color red) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : 'instance creation' }
MfKeyboardElement >> wideSmallKey: aString span: aNumber [

	| button label |
	button := self newButton: (self wideWidth: aNumber) @ self rowHeight.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 11).
		label text attributes:
		{ (BlTextForegroundAttribute paint: Color red) }.
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : 'geometry' }
MfKeyboardElement >> wideWidth: aNumber [
	^ ((self simpleKeyWidth * aNumber) + self spacing)
]
