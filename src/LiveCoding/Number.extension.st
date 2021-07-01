Extension { #name : #Number }

{ #category : #'*LiveCoding' }
Number >> bars: aNumber [
"use it with anInteger bpm to have a cycle of the Iteration of a duration of aNumber of bars(or a fraction)"
^ (Delay forSeconds: ((self * aNumber) /100)) wait.
]

{ #category : #'*LiveCoding' }
Number >> bpm [
"returns time in milliseconds of one bar at self bpm"
^ (60 / self) * 4
]

{ #category : #'*LiveCoding' }
Number >> delay [
]

{ #category : #'*LiveCoding' }
Number >> toKyma: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	| vcslabel pacaAddress |
	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). 

	vcslabel := '/vcs/', aString, '/1'.
	(OSCMessage for: { vcslabel  . (self asFloat)  }) sendToAddressString: pacaAddress  port: 8000.
]

{ #category : #'*LiveCoding' }
Number >> toLocal: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	|  localAddress |
	localAddress := '127.0.0.1'. 

	
	(OSCMessage for: { ('/', aString)  . (self asFloat)  }) sendToAddressString: localAddress  port: 8000.
]

{ #category : #'*LiveCoding' }
Number >> wait [ 
^ (Delay forSeconds: self) wait.
]
