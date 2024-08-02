"
The key binding are using the physical position so that it works on any keyboard (the key Q on qwerty is the same as the key A on Azerty).
"
Class {
	#name : #MfMixingTableElement,
	#superclass : #ToElement,
	#classVars : [
		'keymap',
		'nbButtonPerRow',
		'nbButtons'
	],
	#category : 'Mooflod-MixingTableWidget'
}

{ #category : #example }
MfMixingTableElement class >> exampleMixingTable [

	<script>
	| mT space |
	mT := self new nbButtons: 12; nbButtonPerRow: 4.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	space root addChild: mT.
	space toTheme: MfMooflodTheme new.
	mT transformDo: [ :c | c translateBy: 180 @ 200 ].
	space show.
	^ mT
]

{ #category : #adding }
MfMixingTableElement >> addButton: anElement key: aKey [
	"add the key passed as parameter to the key dictionnary"

	keymap at: aKey put: anElement.
	self addChild: anElement
	
]

{ #category : #initialization }
MfMixingTableElement >> defaultGeometry [
	^ BlRectangleGeometry new
	
]

{ #category : #initialization }
MfMixingTableElement >> initialize [

	super initialize.
	self geometry: self defaultGeometry.
	self size: self tableExtent.
	keymap := Dictionary new.
	self background: Color black.
	self border: (BlBorder paint: Color blue width: 2).
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]
]

{ #category : #initialization }
MfMixingTableElement >> initializeEventListeners [
	"add the handler that changes color when pressing a key"

	self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key 
			ifPresent: [ :aButton | aButton background: Color red ] ].
	self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key 
			ifPresent: [ :aButton | aButton background: Color darkGray ] ].
	self requestFocus
]

{ #category : #initialization }
MfMixingTableElement >> initializeKeys [
	"create the keys that will be associated to buttons"

	| keys |
	"The key binding are using the physical position so that it works on any keyboard (the key Q on qwerty is the same as the key A on Azerty)."
	keys := #( Q W E R T Y U I A S D F G H J K ) collect: [ :each |
		        KeyboardKey perform: each ].
	keys do: [ :eachKey |
		self addButton: MfMixingButtonElement new key: eachKey ].
	self initializeEventListeners
]

{ #category : #accessing }
MfMixingTableElement >> keymap [


^keymap
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtonPerRow [

	^ nbButtonPerRow 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtonPerRow: rows [

	nbButtonPerRow  := rows.
	self layout columnCount: nbButtonPerRow 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtons [

^nbButtons 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtons: buttons [

	nbButtons := buttons.
	self initializeKeys
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> redefineKeys: keys [

	| v |
	v := keymap values.
	keymap := Dictionary new.
		keys withIndexDo: [ :key :index |
			| elem |
			elem := v at: index.
			keymap at: key put: elem ] .
	self initializeEventListeners
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> tableExtent [

	^ 400 @ 200
]
