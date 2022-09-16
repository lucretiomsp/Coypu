Extension { #name : #Number }

{ #category : #'*PharoCollider' }
Number >> midiToFreq [

	"converts a MIDI note number to a frequency value"

	| exponent |
	exponent := (self - 69) / 12.
	^ (2 raisedTo: exponent) * 440
]
