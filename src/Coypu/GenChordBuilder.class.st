"
I build the chord on a scale degree (Strategy).

Seven-note scales stack thirds (GenTertianChordBuilder). Any other scale takes the notes that sound most like a third and a fifth (GenClosestIntervalChordBuilder). forScale: answers the right one.

Every chord gets a strength: how third-like its third is times how fifth-like its fifth is.
"
Class {
	#name : 'GenChordBuilder',
	#superclass : 'Object',
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenChordBuilder class >> forScale: aScale [
	"Factory Method: stacked thirds for heptatonic scales, closest intervals for the rest."

	^ aScale isHeptatonic
		  ifTrue: [ GenTertianChordBuilder new ]
		  ifFalse: [ GenClosestIntervalChordBuilder new ]
]

{ #category : 'building' }
GenChordBuilder >> buildOnDegree: aDegree in: aContext [
	"Answer the GenChord on aDegree of aContext's scale."

	^ self subclassResponsibility
]

{ #category : 'building' }
GenChordBuilder >> chordOnDegree: aDegree third: thirdSemitones fifth: fifthSemitones in: aContext [

	| consonance |
	consonance := aContext consonance.
	^ GenChord
		  degree: aDegree
		  root: (aContext pitchClassOfDegree: aDegree)
		  third: thirdSemitones
		  fifth: fifthSemitones
		  strength: ((consonance thirdLikenessOf: thirdSemitones) max: self minimumQuality)
			  * ((consonance fifthLikenessOf: fifthSemitones) max: self minimumQuality)
]

{ #category : 'building' }
GenChordBuilder >> intervalsAbove: aDegree in: aContext [
	"Semitones from aDegree up to each other scale note, within one octave."

	| scale bottom |
	scale := aContext scale.
	bottom := scale semitonesAtStep: aDegree - 1.
	^ (1 to: scale size - 1) collect: [ :steps |
		  (scale semitonesAtStep: aDegree - 1 + steps) - bottom ]
]

{ #category : 'defaults' }
GenChordBuilder >> minimumQuality [
	"Even the weakest third or fifth keeps a small chance."

	^ 0.1
]
