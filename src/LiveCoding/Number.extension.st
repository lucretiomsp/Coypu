Extension { #name : #Number }

{ #category : #'*LiveCoding' }
Number >> asDirtArray [
	"convenience method to create an array from an interger. used to send osc messages to SuperDirt"
	^ Array with: self
]

{ #category : #'*LiveCoding' }
Number >> bars: aNumber [
"use it with anInteger bpm to have a cycle of the Iteration of a duration of aNumber of bars(or a fraction)"
^ (Delay forSeconds: ((self * aNumber) /100)) wait.
]

{ #category : #'*LiveCoding' }
Number >> bpm [
"returns time in milliseconds of one bar at self bpm"
^ (60 / self) / 4
]

{ #category : #'*LiveCoding' }
Number >> delay [
]

{ #category : #'*LiveCoding' }
Number >> midiNoteToFreq [
" convert Midi note number to frequency"
	| baseFreq |
	baseFreq := 440.0. "Standard tuning frequency for A4"
	^ (baseFreq * (2 raisedTo: self - 69 / 12.0)) asFloat
]

{ #category : #'*LiveCoding' }
Number >> secondsInStepAt: aDuration [
"return the number of steps at aDuration time as 1/16th of a bar which corresponding to self seconds"
^ (self / aDuration) asInteger.
]

{ #category : #'*LiveCoding' }
Number >> toKyma: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	| vcslabel "pacaAddress" |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', aString, '/1'.
	(OSCMessage for: { vcslabel  . (self asFloat)  }) sendToAddressString: pacaAddress  port: 8000.
]

{ #category : #'*LiveCoding' }
Number >> toLocal: aString [

	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| localAddress |
	localAddress := '127.0.0.1'.


	(OSCMessage for: { 
			 ('/' , aString).
			 self asFloat }) sendToAddressString: localAddress port: 57120
]

{ #category : #'*LiveCoding' }
Number >> wait [ 
^ (Delay forSeconds: self) wait.
]
