Class {
	#name : #FaderWindow,
	#superclass : #SystemWindow,
	#category : #'Coypu-GUI'
}

{ #category : #'as yet unclassified' }
FaderWindow class >> countFadersInWorld [

	| fadersInWorld  |
	
	fadersInWorld := self currentWorld submorphs select: [ 
		                 :i | (i class = FaderWindow)].
	^ fadersInWorld size
]
