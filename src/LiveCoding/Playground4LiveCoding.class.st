Class {
	#name : #Playground4LiveCoding,
	#superclass : #StPlaygroundPagePresenter,
	#category : #'LiveCoding-Playground'
}

{ #category : #layout }
Playground4LiveCoding class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: #text;
		  add: #statusbar expand: false;
		  yourself
]

{ #category : #accessing }
Playground4LiveCoding class >> defaultTitle [

	^ 'Programming music on-the-fly'
]

{ #category : #initialization }
Playground4LiveCoding >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'PROGRAMMIN MUSIC ON-FLY';
		initialExtent: 800 @ 700
]
