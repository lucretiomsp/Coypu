Extension { #name : #ByteString }

{ #category : #'*Coypu' }
ByteString >> * aNumber [

" returns a string with aNumber repetiotion of self separated by space"
| result |
 result := self.
 (1 to: aNumber - 1) do: [ :i | result := result , ' ' , self ].


^ result
]

{ #category : #'*Coypu' }
ByteString >> / anInteger [



" return a string with self and anInteger minus one  number of breaks - to be used to construct patterns for SuperDirt"
	| result |
	result :=  self.
	
	(anInteger - 1) timesRepeat: [ result := result , ' ' , '~'. ].
	^ result 
	
]

{ #category : #'*Coypu' }
ByteString >> asDirtArray [
"convenience method to send OSC messages to SuperDirt"
^ Array with: self
]

{ #category : #'*Coypu' }
ByteString >> asDirtNotes [
	" returns a sequencer containing a trig for each integer and a rest for whatever other character and with the notes coresponding to the integeres inside the string - tokens must be separated by string"

	| seq tokens gates notesAStrings notesAsNumbers dirtString announcement|
	announcement := RhythmAnnouncement new.
	announcement rhythm: '''' , self asString , ''' asDirtNotes'.
	PerformanceRecorder uniqueInstance announce: announcement.
	
	gates := ''.
	tokens := self splitOn: ','.
	dirtString := ''.
	tokens do: [ :i |
		(i includes: $*)
			ifTrue: [ gates := gates , i multiplyStringsInString ]
			ifFalse: [
				(i includes: $/)
					ifTrue: [ gates := gates , i withNRests ]
					ifFalse: [ gates := gates , i ] ] ].

	notesAStrings := (gates copyReplaceAll: '~' with: '')
		                 findBetweenSubstrings: ' '.

	notesAsNumbers := notesAStrings collect: [ :i |
		                  i ~= ' ' ifTrue: [ i asInteger ] ].

	notesAsNumbers do: [ :i |
		dirtString := dirtString , i asString , ' ' ].

	seq := gates asSeqGates asSeq.
	seq dirtNotes: dirtString.
	seq notes: notesAsNumbers asArray.

	^ seq
]

{ #category : #'*Coypu' }
ByteString >> asDirtPureNotes [
	" retruns just the note numbers parsed - tokens must be separated by string"

	| seq tokens gates notesAStrings notesAsNumbers dirtString announcement |
	thisContext sender selector asString = 'hexBeat:' ifFalse:[
	announcement := RhythmAnnouncement new.
	announcement rhythm: '''' , self asString , ''' asDirtPureNotes'.
	PerformanceRecorder uniqueInstance announce: announcement].
	gates := ''.
	tokens := self splitOn: ','.
	dirtString := ''.
	tokens do: [ :i |
		(i includes: $*)
			ifTrue: [ gates := gates , i multiplyStringsInString ]
			ifFalse: [
				(i includes: $/)
					ifTrue: [ gates := gates , i withNRests ]
					ifFalse: [ gates := gates , i ] ] ].

	notesAStrings := (gates copyReplaceAll: '~' with: '')
		                 findBetweenSubstrings: ' '.

	notesAsNumbers := notesAStrings collect: [ :i |
		                  i ~= ' ' ifTrue: [ i asInteger ] ].

	notesAsNumbers do: [ :i |
		dirtString := dirtString , i asString , ' ' ].

	seq := gates asSeqGates asSeq.
	seq dirtNotes: dirtString.
	seq notes: notesAsNumbers asArray.

	^ notesAsNumbers asArray
]

{ #category : #'*Coypu' }
ByteString >> asDirtSounds [

	" parse a String into a Sequencer containing information to end to the SuperDirt synth for SuperCollider"





| seq tokens gates soundsAsStrings |

gates := ''.
tokens := self splitOn: ','.
tokens do: [ :i | (i  includes: $* ) ifTrue: [gates := gates,  i multiplyStringsInString ] ifFalse: [(i includes: $/) ifTrue: [gates := gates,  i withNRests ]
	ifFalse:  [gates := gates,  i]
	]].

soundsAsStrings := (gates copyReplaceAll: '~' with: '') . 




seq := gates asSeqGates  asSeq.
seq sound: soundsAsStrings  .

^ seq
]

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
ByteString >> asPacaAddress [


	"set the pacaAddress globally from the corresponding Paca(rana) serial number"
| serialNumber |
serialNumber := 'beslime-51.local'.
	Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress:
			 (NetNameResolver addressForName: serialNumber )).
	^ NetNameResolver stringFromAddress:
		  (NetNameResolver addressForName: serialNumber )
]

{ #category : #'*Coypu' }
ByteString >> asSeqGates [
	
| gates tokens|

" return an array of gates and rests, rests corrresponding to the ~ characters in the string"
gates := OrderedCollection new.
tokens := self findBetweenSubstrings: ' '.
tokens do: [ :i | i = '~' ifTrue: [ gates add: 0]  ifFalse: [ gates add: 1  ]  ].

^ gates asArray.

]

{ #category : #'*Coypu' }
ByteString >> asVerticalFaderLocal: aRange [

	| fader |
		" the fader label is also the OSC address"

	fader := VerticalFaderForOSC newWithAddress: self range: aRange .
	fader openInWindow  
		 
]

{ #category : #'*Coypu' }
ByteString >> chordsToArrays [
	
| chordsAsStrings chordAsArrays|
chordsAsStrings := self findBetweenSubstrings: ' '.
chordAsArrays := chordsAsStrings collect: [ :i| i parseChord  ].
^ chordAsArrays 

]

{ #category : #'*Coypu' }
ByteString >> every: anInteger [ 

" return a string with self and anInteger minus one  number of breaks - to be used to construct patterns for SuperDirt"
	| result |
	result :=  OrderedCollection new.
	result  add: self.
	(2 to: anInteger) do: [ :i | result add: ' ';  add: '~' ].
	^ result
	
]

{ #category : #'*Coypu' }
ByteString >> hexBeat [
	" convert a string with an Hexadecimal number to the Kyma array correspondong to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"

	| strings flat rhythm announcement|
	thisContext sender selector asString = 'semibreves' ifFalse: [
		announcement := RhythmAnnouncement new.
		announcement rhythm: '''' , self asString , ''' hexBeat'.
			PerformanceRecorder uniqueInstance announce: announcement.].
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	rhythm := ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		          asRhythm.
	^ rhythm asSeq
]

{ #category : #'*Coypu' }
ByteString >> hexBeat: aStringOfNoteNumbers [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes"

	| strings flat seq announcement|
		thisContext sender selector asString = 'semibreves' ifFalse: [
		announcement := RhythmAnnouncement new.
		announcement rhythm: '''' , self asString , ''' hexBeat: ',aStringOfNoteNumbers .
		PerformanceRecorder uniqueInstance announce: announcement ].
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	seq := ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		       asRhythm asSeq.
	seq notes: aStringOfNoteNumbers asDirtPureNotes.
	^ seq
]

{ #category : #'*Coypu' }
ByteString >> hexBeat: anArrayOfNoteNumbers dur: anArrayOfDurations [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes and anArrayOfDurations as Durations"

	| strings flat announcement|
		announcement := RhythmAnnouncement new.
		announcement rhythm: '''' , self asString , ''' hexBeat: ',anArrayOfNoteNumbers, ' dur: ',anArrayOfDurations .
		PerformanceRecorder uniqueInstance announce: announcement.
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers and: anArrayOfDurations
]

{ #category : #'*Coypu' }
ByteString >> hexBeat: aStringOfNoteNumbers to: aKey [
	"conveience method to avoid parenthesis !!! returns the Sequencer that has been created"
| seq |
	seq := (self hexBeat: aStringOfNoteNumbers) .
	seq to: aKey.
	^ seq
]

{ #category : #'*Coypu' }
ByteString >> inWords [
" return an Ordered collection separating all the words inside the string"
	^ self findBetweenSubstrings: ' '
]

{ #category : #'*Coypu' }
ByteString >> index: anArrayOfIndexes to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern index: anArrayOfIndexes to: aKeyInAPerformance 
]

{ #category : #'*Coypu' }
ByteString >> midiCh: anInteger to: aKeyInPerformance [
	"conveneience method to avoid extra parenthesis"
(self pattern  midiChannel: anInteger) to: aKeyInPerformance 
]

{ #category : #'*Coypu' }
ByteString >> multiplyStringsInString [
"multiply the string before the * fro the integer after the *"
| tokens |

	tokens := self splitOn: '*'. 
	
^ tokens first * tokens second asInteger
]

{ #category : #'*Coypu' }
ByteString >> notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInAPerformance
]

{ #category : #'*Coypu' }
ByteString >> notes: anArrayOfNotes  to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern notes: anArrayOfNotes to: aKeyInAPerformance .
]

{ #category : #'*Coypu' }
ByteString >> once [
	"play the sound from the SuperDirt audio engine once at the desired index if any -
for exampe cp:4 sound the 3rd sample of the /Library/Application\ Support/SuperCollider/downloaded-quarks/Dirt-Samples/cp folder"

	| sound note message parsedString announcement|

		announcement := SymbolAnnouncement new.
		announcement symbol: ' ''' , self , ''' once' .
		PerformanceRecorder uniqueInstance announce: announcement.
	parsedString := self findBetweenSubstrings: ':'.
	sound := parsedString at: 1.
	parsedString size = 2
		ifTrue: [ note := parsedString at: 2 ]
		ifFalse: [ note := 0 ].
	message := OSCMessage for: {
			           '/dirt/play'.
			           's'.
			           sound.
			           'n'.
			           note }.
	(OSCBundle for: { message })
		sendToAddressString: '127.0.0.1'
		port: 57120
]

{ #category : #'*Coypu' }
ByteString >> onceAtSpeed: aFloat [
	"play the soundfrom the SuperDirt audio engine once at the desired speed"

	| sound note message parsedString condition announcement |
	announcement := SymbolAnnouncement new.
	announcement symbol: ' ''' , self , ''' onceAtSpeed: ',aFloat asString.
	PerformanceRecorder uniqueInstance announce: announcement.
	note := 0.
	parsedString := self findBetweenSubstrings: ':'.
	sound := parsedString at: 1.
	condition := parsedString size = 2.
	condition
		ifTrue: [ note := parsedString at: 2 ]
		ifFalse: [ note := 0 ].
	message := OSCMessage for: {
			           '/dirt/play'.
			           's'.
			           sound.
			           'n'.
			           note.
			           'speed'.
			           aFloat }.
	(OSCBundle for: { message })
		sendToAddressString: '127.0.0.1'
		port: 57120
]

{ #category : #'*Coypu' }
ByteString >> onceAtSpeed: aFloat withNote: aNote [
	"play the soundfrom the SuperDirt audio engine once at the desired speed"

	| sound message parsedString condition announcement |
	announcement := SymbolAnnouncement new.
	announcement symbol:
		' ''' , self , ''' onceAtSpeed: ' , aFloat asString, ' withNote: ',aNote asString.
	PerformanceRecorder uniqueInstance announce: announcement.
	parsedString := self findBetweenSubstrings: ':'.
	sound := parsedString at: 1.
	condition := parsedString size = 2.

	message := OSCMessage for: {
			           '/dirt/play'.
			           's'.
			           sound.
			           'n'.
			           aNote.
			           'speed'.
			           aFloat }.
	(OSCBundle for: { message })
		sendToAddressString: '127.0.0.1'
		port: 57120
]

{ #category : #'*Coypu' }
ByteString >> parseChord [
"chords can be xpressed both with letteres or with MIDI NoteNumbers"
	|root chord notes|
	root := (self findBetweenSubstrings: '-') at: 1.
	chord :=(self findBetweenSubstrings: '-') at: 2.
	notes := Array new: 11.
	notes := #('c' 'c#' 'd' 'd#' 'e' 'f' 'f#' 'g#' 'a' 'a#' 'b').
	root asInteger ifNotNil: [ ^ (Chord list at: chord asLowercase  asSymbol) + root asInteger ] ifNil:
		[^ (Chord list at: chord asLowercase  asSymbol) + (notes indexOf: root asLowercase  ) - 1].
]

{ #category : #'*Coypu' }
ByteString >> pattern [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"

	| strings flat announcement |
	announcement := RhythmAnnouncement new.
	announcement symbol: ' ''' , self , ''' pattern'.
	PerformanceRecorder uniqueInstance announce: announcement.
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm asSeq
]

{ #category : #'*Coypu' }
ByteString >> pattern: anArrayOfNoteNumbers [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes"

	| strings flat announcement|
		announcement := RhythmAnnouncement new.
	announcement symbol:
		' ''' , self , ''' pattern: ', anArrayOfNoteNumbers .
	PerformanceRecorder uniqueInstance announce: announcement.
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers
]

{ #category : #'*Coypu' }
ByteString >> pattern: anArrayOfNoteNumbers and: anArrayOfDurations [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes and anArrayOfDurations as Durations"

	| strings flat announcement|
		announcement := RhythmAnnouncement new.
	announcement symbol:
		' ''' , self , ''' pattern: ' , anArrayOfNoteNumbers, ' and: ', anArrayOfDurations.
	PerformanceRecorder uniqueInstance announce: announcement.
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers and: anArrayOfDurations
]

{ #category : #'*Coypu' }
ByteString >> randomNotesFromFolder [
"returns a random number (between 2 and 512) of indexes from the folder wit self name"
| randIndex folder folderSize|
	randIndex := Random new nextIntegerBetween: 2 and:  512.
	folder := SuperDirt samplesFolder / self .
	folderSize := folder asFileReference allChildren size. 
	^ randIndex randomInts: folderSize .
]

{ #category : #'*Coypu' }
ByteString >> to: aKeyInPerformance [ 
	"convenience method to insert at aKeyInPerformance a pattern from the hex string"
	
| p |

p := Performance uniqueInstance .
self pattern to: aKeyInPerformance 
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsGate [
	" send an OSC message that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"
	| vcslabel  |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', self , 'Gate', '/1'.
	(OSCMessage for: { vcslabel  . 1.0  }) sendToAddressString: PacaAddress address  port: 8000.
	(Delay forSeconds: 2) wait.
	(OSCMessage for: { vcslabel  . 0.0  }) sendToAddressString: PacaAddress address  port: 8000.
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsGate: gateTimeInSeconds [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| vcslabel  |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', self , 'Gate', '/1'.
	^ [(OSCMessage for: { vcslabel  . 1.0  }) sendToAddressString: PacaAddress address port: 8000.
	(Delay forSeconds: gateTimeInSeconds ) wait.
	(OSCMessage for: { vcslabel  . 0.0  }) sendToAddressString: PacaAddress address port: 8000.
	] fork
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsGate: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcsGatelabel vcsNoteLabel sendNoteNumber sendNoteOn sendNoteOff |
	"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "
	vcsGatelabel := '/vcs/' , self , 'Gate' , '/1'.
	vcsNoteLabel := '/vcs/' , self , 'Note' , '/1'.
	sendNoteNumber := (OSCMessage for: { 
			                   vcsNoteLabel.
			                   aNoteNumber asFloat })
		                  sendToAddressString: pacaAddress
		                  port: 8000.
	[ "first NoteOff for VoiceStealing"
	(OSCMessage for: { 
			 vcsGatelabel.
			 0.0 }) sendToAddressString:  pacaAddress port: 8000."then note On"
	(OSCMessage for: { 
			 vcsGatelabel.
			 1.0 }) sendToAddressString: pacaAddress port: 8000.
	(Delay forSeconds: gateTimeInSeconds) wait.
	"then note Off"
	(OSCMessage for: { 
			 vcsGatelabel.
			 0.0 }) sendToAddressString: pacaAddress port: 8000 ] fork
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsGateOld: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcsGatelabel vcsNoteLabel |
	"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "
	vcsGatelabel := '/vcs/' , self , 'Gate' , '/1'.
	vcsNoteLabel := '/vcs/' , self , 'Note' , '/1'.

	^ [ 
	  (OSCMessage for: { 
			   vcsNoteLabel.
			   aNoteNumber asFloat })
		  sendToAddressString: PacaAddress address
		  port: 8000.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   1.0 }) sendToAddressString: PacaAddress address port: 8000.
	  (Delay forSeconds: gateTimeInSeconds) wait.
	  (OSCMessage for: { 
			   vcsGatelabel.
			   0.0 }) sendToAddressString: PacaAddress address port: 8000 ] fork
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsNoteOff: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message."
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: PacaAddress address port: 8000.
(OSCMessage for: { vcsGatelabel  . 0.0  }) sendToAddressString: PacaAddress address  port: 8000.

]

{ #category : #'*Coypu' }
ByteString >> toKymaAsNoteOn: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: PacaAddress address port: 8000.
(OSCMessage for: { vcsGatelabel  . 1.0  }) sendToAddressString: PacaAddress address port: 8000.

]

{ #category : #'*Coypu' }
ByteString >> toKymaAsTrig [

	" send an OSC message acting as a 10ms dutyCycle trigger"

	| vcslabel |
	"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "
	vcslabel := '/vcs/' , self , '/1'.
	^ [ 
	  (OSCMessage for: { 
			   vcslabel.
			   1.0 }) sendToAddressString: PacaAddress address port: 8000.
	  (Delay forSeconds: 0.01) wait.
	  (OSCMessage for: { 
			   vcslabel.
			   0.0 }) sendToAddressString: PacaAddress address port: 8000 ] fork
]

{ #category : #'*Coypu' }
ByteString >> toKymaAsTrigWithDuration: aDurationInSeconds [

	" send an OSC message acting as a 10ms dutyCycle trigger"

	| vcslabel |
	"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "
	vcslabel := '/vcs/' , self , '/1'.
	^ [ 
	  (OSCMessage for: { 
			   vcslabel.
			   1.0 }) sendToAddressString: PacaAddress address port: 8000.
	  (Delay forSeconds: aDurationInSeconds ) wait.
	  (OSCMessage for: { 
			   vcslabel.
			   0.0 }) sendToAddressString: PacaAddress address port: 8000 ] fork
]

{ #category : #'*Coypu' }
ByteString >> toLocalAsGate [

	" send an OSC message that mimics the behaviour of MIDI note on message, note is held for a default duration of 0.25 second and midi NN is 60"
self toLocalAsGate: 0.25 note: 60 
]

{ #category : #'*Coypu' }
ByteString >> toLocalAsGate: gateTimeInSeconds [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds, MIDI noteNumber is 60"

self toLocalAsGate: gateTimeInSeconds note: 60.
]

{ #category : #'*Coypu' }
ByteString >> toLocalAsGate: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| oscGate oscNote localAddress |
	localAddress := '127.0.0.1'.

	oscGate := '/' , self , 'Gate'.
	oscNote := '/' , self , 'Note'.
	(OSCMessage for: { 
			 oscNote.
			 aNoteNumber asFloat })
		sendToAddressString: localAddress
		port: 57120.
	(OSCMessage for: { 
			 oscGate.
			 1.0 }) sendToAddressString: localAddress port: 57120.
	(Delay forSeconds: gateTimeInSeconds) wait.
	(OSCMessage for: { 
			 oscGate.
			 0.0 }) sendToAddressString: localAddress port: 57120
]

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
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

{ #category : #'*Coypu' }
ByteString >> withNRests [
	" add rests to a string divided by an Integer inside a String"
	
| tokens |
tokens := self splitOn: '/'.

^ tokens first / tokens second asString asInteger
]
