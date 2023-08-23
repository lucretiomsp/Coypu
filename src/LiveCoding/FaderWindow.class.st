Class {
	#name : #FaderWindow,
	#superclass : #SystemWindow,
	#category : #'LiveCoding-GUI'
}

{ #category : #'as yet unclassified' }
FaderWindow class >> countFadersInWorld [

	| fadersInWorld  |
	
	fadersInWorld := self currentWorld submorphs select: [ 
		                 :i | (i class = FaderWindow)].
	^ fadersInWorld size
]
