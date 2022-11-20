Extension { #name : #Number }

{ #category : #'*PharoCollider' }
Number >> midiToFreq [

	"converts a MIDI note number to a frequency value"

	| exponent |
	exponent := (self - 69) / 12.
	^ (2 raisedTo: exponent) * 440
]

{ #category : #'*PharoCollider' }
Number >> writeInputSpec [

	"original SuperCollider method write to a file, not to an OrderedCollection, which I called int8Array"

	| int8Array constIndex |
	int8Array := OrderedCollection new.
	constIndex := 0.
	"var constIndex = synth.constants.at(this.asFloat) ???"

	int8Array addAll: #( -1 -1 -1 -1 ).
	int8Array addAll: (constIndex asByteArrayOfSize: 4).
	^ int8Array 
]
