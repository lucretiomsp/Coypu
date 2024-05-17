"
Minimal Playground for programming music on-the fly.

"
Class {
	#name : #Playground4LiveCoding,
	#superclass : #StPlaygroundPagePresenter,
	#category : #'Coypu-Playground'
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
		title: 'PROGRAMMING MUSIC ON-THE-FLY';
		initialExtent: self currentWorld width @ 700
]
