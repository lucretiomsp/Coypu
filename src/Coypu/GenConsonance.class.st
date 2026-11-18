"
I measure how consonant an interval sounds, in any tuning.

My curve has a peak on every pure (just) interval: unison and octave, the fifth, the thirds and sixths, the fourth, septimal and neutral intervals, then the seconds and sevenths. An interval scores by how close it gets to the nearest peak (a bell of width cents around each one), so twelve-tone thirds score a little under pure thirds, quarter-tone neutral thirds land in between, and Partch's ratios sit right on the peaks.

An interval is the distance of a note above a reference note, folded into one octave: a fifth up scores like a fourth down (0.95), while a fourth up (0.55) is less stable, as in counterpoint.

thirdLikenessOf: and fifthLikenessOf: tell how much an interval sounds like a chord third or fifth; chord builders use them.

Results are cached per cent (memoization): the melody brain asks the same few intervals thousands of times.

Examples:
	GenConsonance new ofInterval: 7.
	GenConsonance new ofInterval: 6.
	GenConsonance new thirdLikenessOf: 3.5.
"
Class {
	#name : 'GenConsonance',
	#superclass : 'Object',
	#instVars : [
		'peaks',
		'width',
		'floor',
		'cache'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'defaults' }
GenConsonance class >> defaultPeaks [
	"Pure interval (ratio) -> how consonant it is."

	^ {
		  1 -> 1.0.
		  (3 / 2) -> 0.95.
		  (5 / 4) -> 0.85.
		  (6 / 5) -> 0.8.
		  (5 / 3) -> 0.75.
		  (8 / 5) -> 0.7.
		  (4 / 3) -> 0.55.
		  (7 / 4) -> 0.45.
		  (7 / 6) -> 0.4.
		  (9 / 7) -> 0.4.
		  (11 / 9) -> 0.35.
		  (16 / 9) -> 0.35.
		  (9 / 8) -> 0.3.
		  (7 / 5) -> 0.25.
		  (15 / 8) -> 0.2.
		  (16 / 15) -> 0.1 }
]

{ #category : 'defaults' }
GenConsonance class >> fifthTargets [

	^ { (3 / 2) -> 1.0 }
]

{ #category : 'defaults' }
GenConsonance class >> thirdTargets [
	"What a chord third can be, from the most to the least convincing."

	^ {
		  (5 / 4) -> 1.0.
		  (6 / 5) -> 0.95.
		  (9 / 7) -> 0.6.
		  (7 / 6) -> 0.55.
		  (11 / 9) -> 0.5 }
]

{ #category : 'private' }
GenConsonance >> centsPeaksFrom: someRatioWeights [

	^ someRatioWeights collect: [ :each |
		  (GenTuning semitonesOfRatio: each key) * 100 -> each value ]
]

{ #category : 'private' }
GenConsonance >> closenessOf: cents to: peakCents [
	"A bell around a peak, 1 on the peak itself. The distance wraps around the octave."

	| distance |
	distance := (cents - peakCents) abs \\ 1200.
	distance := distance min: 1200 - distance.
	^ (distance squared / (2 * width squared)) negated exp
]

{ #category : 'private' }
GenConsonance >> consonanceAtCents: cents [

	^ peaks inject: floor into: [ :best :peak |
		  best max: peak value * (self closenessOf: cents to: peak key) ]
]

{ #category : 'chords' }
GenConsonance >> fifthLikenessOf: aNumber [
	"How much an interval in semitones sounds like a chord fifth."

	^ self likenessOf: aNumber among: self class fifthTargets
]

{ #category : 'initialization' }
GenConsonance >> initialize [

	super initialize.
	width := 20.0.
	floor := 0.02.
	peaks := self centsPeaksFrom: self class defaultPeaks.
	cache := Dictionary new
]

{ #category : 'private' }
GenConsonance >> likenessOf: aNumber among: someTargets [

	| cents |
	cents := (aNumber * 100) asFloat \\ 1200.
	^ someTargets inject: 0 into: [ :best :target |
		  best max: target value * (self
				   closenessOf: cents
				   to: (GenTuning semitonesOfRatio: target key) * 100) ]
]

{ #category : 'consonance' }
GenConsonance >> ofInterval: aNumber [
	"Consonance in ]0, 1] of a note aNumber semitones above a reference note (octaves fold)."

	| cents |
	cents := (aNumber * 100) rounded \\ 1200.
	^ cache at: cents ifAbsentPut: [ self consonanceAtCents: cents ]
]

{ #category : 'chords' }
GenConsonance >> thirdLikenessOf: aNumber [
	"How much an interval in semitones sounds like a chord third (major, minor, septimal or neutral)."

	^ self likenessOf: aNumber among: self class thirdTargets
]

{ #category : 'accessing' }
GenConsonance >> width [

	^ width
]

{ #category : 'accessing' }
GenConsonance >> width: aNumberOfCents [
	"How forgiving the peaks are."

	width := aNumberOfCents.
	cache := Dictionary new
]
