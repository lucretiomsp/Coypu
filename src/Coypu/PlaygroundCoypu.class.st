"
Minimal Playground for programming music on-the fly.

"
Class {
	#name : 'PlaygroundCoypu',
	#superclass : 'StPlaygroundPagePresenter',
	#category : 'Coypu-Playground',
	#package : 'Coypu',
	#tag : 'Playground'
}

{ #category : 'layout' }
PlaygroundCoypu class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: #text;
		  add: #statusbar expand: false;
		  yourself
]

{ #category : 'accessing' }
PlaygroundCoypu class >> defaultTitle [

	^ 'Programming music on-the-fly'
]

{ #category : 'initialization' }
PlaygroundCoypu >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter
		title: 'COYPU';
		initialExtent: self currentWorld width @ 700
]
