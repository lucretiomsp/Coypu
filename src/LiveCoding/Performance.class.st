"
""A performance is a Dictionary subclass used for live coding package""
"
Class {
	#name : #Performance,
	#superclass : #Dictionary,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #accessing }
Performance >> length [
"return the number of steps of the largest array contained in the performance values"
| valuesSizes maxLength |
valuesSizes := (1 to: (self values size)) collect: [ :i | ((self values at: i) at: 1 )size ].
maxLength := valuesSizes inject: 0 into: [ :a :c | (a > c) ifTrue: [ a ] ifFalse: [ c ] ].
^ maxLength 
]

{ #category : #'as yet unclassified' }
Performance >> mute: anArrayOfKeys [
"remove all the keys in the arrayOfKeys from the Performance"
anArrayOfKeys do: [ :i | self removeKey: i ifAbsent: [ ] ] 
]

{ #category : #'as yet unclassified' }
Performance >> muteAll [
" remove all keys from the Performance"
self keysDo: [ :i | self removeKey: i ifAbsent: [ ] ] .
]

{ #category : #accessing }
Performance >> playMIDISequenceAt: aRateInSeconds steps: aNumberOfSteps on: aMIDISender [
"test"
" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through a dictionary of patterns, containing arrays of numbers as values"
| step  bpm beatInSeconds gateTime|
"as in early hardware sequencers, default gatetime is 80% of the step duration"
bpm := 60 / (aRateInSeconds * 4).
beatInSeconds := aRateInSeconds * 4.
gateTime := aRateInSeconds * 0.8.
step := 0.


^
[ 	
	"bpm toKyma: 'BPM'."
	aNumberOfSteps timesRepeat: [ (Delay forSeconds: aRateInSeconds   ) wait.
		" test if dictionary values is an Array of two arrays or as defined, a sequence"
		 
		self keysAndValuesDo: [ :key : value |
		(value isSequencer) ifTrue: [  	
		(((value gates) at: (step modulo: (value gatesSize ))) = 1)
		ifTrue:
		[  "aMIDISender playDrum: 56 onChannel: (((key asString) at: 3) asInteger)."
		aMIDISender playDrum: ((value notes) at: ((value    noteIndex ) modulo: (value notesSize))) onChannel: (((key asString) at: 3) digitValue ).
		"old imlementation"
		"(key asString) toKymaAsGate: ( gateTime * ((value durations ) at: (value noteIndex modulo: (value durationsSize)))) note: ((value notes) at: ((value    noteIndex ) modulo: (value notesSize)))."
		
		
		value at: 4 put: ((value noteIndex) + 1).
		
		"noteIndex := noteIndex + 1."
		] 
		ifFalse: [nil]]
	"end of the isSequencer true condition"
		ifFalse: [nil] "[(value at: (step modulo: (value size))) toKyma: (key asString). (Delay forSeconds: aRateInSeconds   )wait. ]" 
		].
	
		"step is incrementing in any case"
		step := step + 1.
		
	]
	
	] forkAt: (Processor timingPriority )


]
