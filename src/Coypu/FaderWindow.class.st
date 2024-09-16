Class {
	#name : 'FaderWindow',
	#superclass : 'SystemWindow',
	#category : 'Coypu-GUI',
	#package : 'Coypu',
	#tag : 'GUI'
}

{ #category : 'accessing' }
FaderWindow class >> countFadersInWorld [

	| fadersInWorld  |
	
	fadersInWorld := self currentWorld submorphs select: [ 
		                 :i | (i class = FaderWindow)].
	^ fadersInWorld size
]
