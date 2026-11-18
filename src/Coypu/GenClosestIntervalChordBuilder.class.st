"
For scales that do not have seven notes (pentatonic, hexatonic and Partch scales, octatonic, chromatic), I take the scale note that sounds most like a third and the one that sounds most like a fifth above each degree (Strategy).
"
Class {
	#name : 'GenClosestIntervalChordBuilder',
	#superclass : 'GenChordBuilder',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'building' }
GenClosestIntervalChordBuilder >> buildOnDegree: aDegree in: aContext [

	| consonance intervals third fifth |
	consonance := aContext consonance.
	intervals := self intervalsAbove: aDegree in: aContext.
	third := intervals detectMax: [ :each | consonance thirdLikenessOf: each ].
	fifth := (intervals copyWithout: third) detectMax: [ :each |
		         consonance fifthLikenessOf: each ].
	^ self
		  chordOnDegree: aDegree
		  third: third
		  fifth: fifth
		  in: aContext
]
