Extension { #name : #ByteString }

{ #category : #'*LiveCoding' }
ByteString >> asChord [

	"return an Array with the Intervals of the Chord in semitones"
	
	

	
]

{ #category : #'*LiveCoding' }
ByteString >> asLocalGate: gateTimeInSeconds note: aNoteNumber [
" gate-like OSC messsage with multiple arguments"
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| label localAddress|
   localAddress := '127.0.0.1'.

	label := '/', self.
	
	
^ [(OSCMessage for: { label  . aNoteNumber asFloat }) sendToAddressString: localAddress  port: 8000.
	(OSCMessage for: { label  . 1.0  }) sendToAddressString: localAddress  port: 8000.
	(Delay forSeconds: gateTimeInSeconds ) wait.
	(OSCMessage for: { label  . 0.0  }) sendToAddressString: localAddress  port: 8000.] fork
]

{ #category : #'*LiveCoding' }
ByteString >> asPacaAddress [
"set the pacaAddress globally from the corresponding Paca(rana) serial number"

Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local')).
^ (NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local')).
	
]

{ #category : #'*LiveCoding' }
ByteString >> pattern [ 
" convert a string with an Hexadecimal number to the Kyma array correspondong to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"
|   strings flat |

strings := (1 to: (self size)) collect: [ :i | 
((self at: i) digitValue printStringBase: 2 length: 4 padded: true ) ].
flat := strings flatCollect: [ :each | each ].
^ ((( 1 to: (flat size)) collect: [ :i | (flat at: i ) digitValue ]) asRhythm ) asSeq.
]

{ #category : #'*LiveCoding' }
ByteString >> pattern: anArrayOfNoteNumbers [ 
" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes"
|   strings flat |

strings := (1 to: (self size)) collect: [ :i | 
((self at: i) digitValue printStringBase: 2 length: 4 padded: true ) ].
flat := strings flatCollect: [ :each | each ].
^ ((( 1 to: (flat size)) collect: [ :i | (flat at: i ) digitValue ]) asRhythm ) and: anArrayOfNoteNumbers  .
]

{ #category : #'*LiveCoding' }
ByteString >> pattern: anArrayOfNoteNumbers and: anArrayOfDurations [
" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes and anArrayOfDurations as Durations"
|   strings flat |

strings := (1 to: (self size)) collect: [ :i | 
((self at: i) digitValue printStringBase: 2 length: 4 padded: true ) ].
flat := strings flatCollect: [ :each | each ].
^ ((( 1 to: (flat size)) collect: [ :i | (flat at: i ) digitValue ]) asRhythm ) and: anArrayOfNoteNumbers and: anArrayOfDurations .
]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsGate [
	" send an OSC message that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"
	| vcslabel  |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', self , 'Gate', '/1'.
	(OSCMessage for: { vcslabel  . 1.0  }) sendToAddressString: pacaAddress  port: 8000.
	(Delay forSeconds: 2) wait.
	(OSCMessage for: { vcslabel  . 0.0  }) sendToAddressString: pacaAddress  port: 8000.
]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsGate: gateTimeInSeconds [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| vcslabel  |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', self , 'Gate', '/1'.
	^ [(OSCMessage for: { vcslabel  . 1.0  }) sendToAddressString: pacaAddress  port: 8000.
	(Delay forSeconds: gateTimeInSeconds ) wait.
	(OSCMessage for: { vcslabel  . 0.0  }) sendToAddressString: pacaAddress  port: 8000.
	] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsGate: gateTimeInSeconds note: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
^ [(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: pacaAddress  port: 8000.
	(OSCMessage for: { vcsGatelabel  . 1.0  }) sendToAddressString: pacaAddress  port: 8000.
	(Delay forSeconds: gateTimeInSeconds ) wait.
	(OSCMessage for: { vcsGatelabel  . 0.0  }) sendToAddressString: pacaAddress  port: 8000.] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsNoteOff: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message."
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: pacaAddress  port: 8000.
(OSCMessage for: { vcsGatelabel  . 0.0  }) sendToAddressString: pacaAddress  port: 8000.

]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsNoteOn: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: pacaAddress  port: 8000.
(OSCMessage for: { vcsGatelabel  . 1.0  }) sendToAddressString: pacaAddress  port: 8000.

]

{ #category : #'*LiveCoding' }
ByteString >> toKymaAsTrig [

	" send an OSC message acting as a 10ms dutyCycle trigger"

	| vcslabel |
	"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "
	vcslabel := '/vcs/' , self , '/1'.
	^ [ 
	  (OSCMessage for: { 
			   vcslabel.
			   1.0 }) sendToAddressString: pacaAddress port: 8000.
	  (Delay forSeconds: 0.01) wait.
	  (OSCMessage for: { 
			   vcslabel.
			   0.0 }) sendToAddressString: pacaAddress port: 8000 ] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toLocalAsGate [

	" send an OSC message that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"

	| vcslabel localAddress |
	localAddress := '127.0.0.1'.

	vcslabel := '/' , self , 'Gate'.
	(OSCMessage for: { 
			 vcslabel.
			 1.0 }) sendToAddressString: localAddress port: 8000.
	(Delay forSeconds: 2) wait.
	(OSCMessage for: { 
			 vcslabel.
			 0.0 }) sendToAddressString: localAddress port: 8000
]

{ #category : #'*LiveCoding' }
ByteString >> toLocalAsGate: gateTimeInSeconds [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcslabel localAddress |
	localAddress := '127.0.0.1'.
	vcslabel := '/' , self , 'Gate'.
	^ [ 
	  (OSCMessage for: { 
			   vcslabel.
			   1.0 }) sendToAddressString: localAddress port: 8000.
	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   vcslabel.
			   0.0 }) sendToAddressString: localAddress port: 8000] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toLocalAsGate: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcsGatelabel vcsNoteLabel localAddress |
	localAddress := '127.0.0.1'.

	vcsGatelabel := '/' , self , 'Gate'.
	vcsNoteLabel := '/' , self , 'Note'.

	^ [ 
	  (OSCMessage for: { 
			   vcsNoteLabel.
			   aNoteNumber asFloat })
		  sendToAddressString: localAddress
		  port: 8000.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   1.0 }) sendToAddressString: localAddress port: 57110.
	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   0.0 }) sendToAddressString: localAddress port: 57110 ] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toLocalFor: gateTimeInSeconds note: aNoteNumber [

	" gate-like OSC messsage with multiple arguments"

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| label localAddress |
	localAddress := '127.0.0.1'.

	label := '/' , self.


	^ [ 
	  (OSCMessage for: { 
			   label.
			   aNoteNumber asFloat.
			   1.0 }) sendToAddressString: localAddress port: 8000.

	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   label.
			   aNoteNumber asFloat.
			   0.0 }) sendToAddressString: localAddress port: 8000 ] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toSCAsGate [

	" send an OSC message that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"

	| vcslabel localAddress |
	localAddress := '127.0.0.1'.

	vcslabel := self , 'Gate'.
	(OSCMessage for: { 
			 vcslabel.
			 1.0 }) sendToAddressString: localAddress port: 57110.
	(Delay forSeconds: 2) wait.
	(OSCMessage for: { 
			 vcslabel.
			 0.0 }) sendToAddressString: localAddress port: 57110
]

{ #category : #'*LiveCoding' }
ByteString >> toSCAsGate: gateTimeInSeconds [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcslabel localAddress |
	localAddress := '127.0.0.1'.
	vcslabel := self , 'Gate'.
	^ [ 
	  (OSCMessage for: { 
			   vcslabel.
			   1.0 }) sendToAddressString: localAddress port: 57110.
	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   vcslabel.
			   0.0 }) sendToAddressString: localAddress port: 57110 ] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toSCAsGate: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcsGatelabel vcsNoteLabel localAddress |
	localAddress := '127.0.0.1'.

	vcsGatelabel := self , 'Gate'.
	vcsNoteLabel := self , 'Note'.

	^ [ 
	  (OSCMessage for: { 
			   vcsNoteLabel.
			   aNoteNumber asFloat })
		  sendToAddressString: localAddress
		  port: 8000.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   1.0 }) sendToAddressString: localAddress port: 57110.
	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   0.0 }) sendToAddressString: localAddress port: 57110 ] fork
]

{ #category : #'*LiveCoding' }
ByteString >> toSCFor: gateTimeInSeconds note: aNoteNumber [

	" gate-like OSC messsage with multiple arguments"

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| label localAddress |
	localAddress := '127.0.0.1'.

	label := self.


	^ [ 
	  (OSCMessage for: { 
			   label.
			   aNoteNumber asFloat.
			   1.0 }) sendToAddressString: localAddress port: 57110.

	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   label.
			   aNoteNumber asFloat.
			   0.0 }) sendToAddressString: localAddress port: 57110 ] fork
]
