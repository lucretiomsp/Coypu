Extension { #name : #Number }

{ #category : #'*Coypu' }
Number >> asDirtArray [
	"convenience method to create an array from an interger. used to send osc messages to SuperDirt"
	^ Array with: self
]

{ #category : #'*Coypu' }
Number >> bars: aNumber [
"use it with anInteger bpm to have a cycle of the Iteration of a duration of aNumber of bars(or a fraction)"
^ (Delay forSeconds: ((self * aNumber) /100)) wait.
]

{ #category : #'*Coypu' }
Number >> bpm [
"returns time in milliseconds of one bar at self bpm"
^ (60 / self) / 4
]

{ #category : #'*Coypu' }
Number >> delay [
]

{ #category : #'*Coypu' }
Number >> midiNoteToFreq [
" convert Midi note number to frequency"
	| baseFreq |
	baseFreq := 440.0. "Standard tuning frequency for A4"
	^ (baseFreq * (2 raisedTo: self - 69 / 12.0)) asFloat
]

{ #category : #'*Coypu' }
Number >> randomsFromArray: anArray [
	" returns an array of self size with randomInts from anArray at: 1 to anArray at: 2"

	| min max |
	min := anArray at: 1.
	max := anArray at: 2.
	^ (1 to: self )collect: [ : i | Random new nextIntegerBetween: min and: max  ].
]

{ #category : #'*Coypu' }
Number >> secondsInStepAt: aDuration [
"return the number of steps at aDuration time as 1/16th of a bar which corresponding to self seconds"
^ (self / aDuration) asInteger.
]

{ #category : #'*Coypu' }
Number >> toKyma: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	| vcslabel "pacaAddress" |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', aString, '/1'.
	(OSCMessage for: { vcslabel  . (self asFloat)  }) sendToAddressString: pacaAddress  port: 8000.
]

{ #category : #'*Coypu' }
Number >> toLocal: aString [

	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| localAddress |
	localAddress := '127.0.0.1'.


	(OSCMessage for: { 
			 ('/' , aString).
			 self asFloat }) sendToAddressString: localAddress port: 57120
]

{ #category : #'*Coypu' }
Number >> wait [ 
^ (Delay forSeconds: self) wait.
]
