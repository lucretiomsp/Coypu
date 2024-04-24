Class {
	#name : #FaderWindow,
	#superclass : #SystemWindow,
	#category : #'Coypu-GUI'
}

{ #category : #accessing }
FaderWindow class >> countFadersInWorld [

	| fadersInWorld  |
	
	fadersInWorld := self currentWorld submorphs select: [ 
		                 :i | (i class = FaderWindow)].
	^ fadersInWorld size
]
