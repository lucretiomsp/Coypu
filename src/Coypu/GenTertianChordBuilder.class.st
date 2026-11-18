"
I stack thirds: the chord on a degree uses the scale notes two and four steps above it, the usual triads of a seven-note scale (Strategy).
"
Class {
	#name : 'GenTertianChordBuilder',
	#superclass : 'GenChordBuilder',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'building' }
GenTertianChordBuilder >> buildOnDegree: aDegree in: aContext [

	| intervals |
	intervals := self intervalsAbove: aDegree in: aContext.
	^ self
		  chordOnDegree: aDegree
		  third: (intervals at: 2)
		  fifth: (intervals at: 4)
		  in: aContext
]
