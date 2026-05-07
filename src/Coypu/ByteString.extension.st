Extension { #name : 'ByteString' }

{ #category : '*Coypu' }
ByteString >> * aNumber [

" returns a string with aNumber repetiotion of self separated by space"
| result |
 result := self.
 (1 to: aNumber - 1) do: [ :i | result := result , ' ' , self ].


^ result
]

{ #category : '*Coypu' }
ByteString >> / anInteger [



" return a string with self and anInteger minus one  number of breaks - to be used to construct patterns for SuperDirt"
	| result |
	result :=  self.
	
	(anInteger - 1) timesRepeat: [ result := result , ' ' , '~'. ].
	^ result 
	
]

{ #category : '*Coypu' }
ByteString >> << aNumber [
	"economic method to send a value to the parameter named self on the OSC audio server"

	aNumber toLocal: self
]

{ #category : '*Coypu' }
ByteString >> asDirtArray [
"convenience method to send OSC messages to SuperDirt"
^ Array with: self
]

{ #category : '*Coypu' }
ByteString >> asDirtArrayOfValues [
	" designed for change Sequencer extra paramters"

	^ self asDirtPureNotes asDirtArray 
]

{ #category : '*Coypu' }
ByteString >> asDirtIndex [
	" returns a sequencer containing a trig for each integer and a rest for whatever other character and with indexes coresponding to the integeres inside the string - tokens must be separated by string"

	| seq tokens gates notesAStrings notesAsNumbers dirtString  |
	


	gates := ''.
	tokens := self splitOn: ','.
	dirtString := ''.
	tokens do: [ :i |
			(i includes: $*)
				ifTrue: [ gates := gates , i multiplyStringsInString ]
				ifFalse: [
						gates := (i includes: $/)
							         ifTrue: [ gates , i withNRests ]
							         ifFalse: [ gates , i ] ] ].


	notesAStrings := ((gates copyReplaceAll: '~' with: '')
		                  copyReplaceAll: '-'
		                  with: '') findBetweenSubstrings: ' '.

	notesAsNumbers := notesAStrings collect: [ :i |
		                  i ~= ' ' ifTrue: [ i asNumber ] ].

	notesAsNumbers do: [ :i |
		dirtString := dirtString , i asString , ' ' ].

	seq := gates asSeqGates asSeq.

	seq index: notesAsNumbers asArray.

	^ seq
]

{ #category : '*Coypu' }
ByteString >> asDirtLevel [
	
	" returns a sequencer containing a trig for each integer and a rest for whatever other character and with the notes coresponding to the integeres inside the string - tokens must be separated by string"

	<onTheFlyEssentials>
	| seq tokens gates durs levelsAStrings levelsAsNumbers dirtString  |
	

	gates := ''.
	durs := OrderedCollection new.
	tokens := self splitOn: ','.
	dirtString := ''.
	tokens do: [ :i |
			(i includes: $*)
				ifTrue: [
						gates := gates , i multiplyStringsInString.
						(i includes: $~) ifFalse: [
							i getMultiplier timesRepeat: [ durs add: 1 ] ] ]
				ifFalse: [
						(i includes: $/)
							ifTrue: [
									gates := gates , i withNRests.
									(i includes: $~) ifFalse: [ durs add: i getDivisor ] ]
							ifFalse: [
									gates := gates , i.
									(i includes: $~) ifFalse: [ durs add: 1 ] ] ] ].
	"tildes or - can be used as rests"
	levelsAStrings := ((gates copyReplaceAll: '~' with: '')
		                  copyReplaceAll: '-'
		                  with: '') findBetweenSubstrings: ' '.

	levelsAsNumbers := levelsAStrings collect: [ :i | "note cant be higher than higher MIDI note"
		                  i ~= ' ' ifTrue: [ i asNumber] ].

	levelsAsNumbers do: [ :i |
		dirtString := dirtString , i asString , ' ' ].

	seq := gates asSeqGates asSeq.
	seq dirtNotes: dirtString.
	seq notes: 60.
	seq durations: durs asArray.
	seq level: levelsAsNumbers asArray.

	^ seq
]

{ #category : '*Coypu' }
ByteString >> asDirtNotes [
    "Returns a sequencer containing a trig for each note and a rest 
     for ~ or - characters. Notes can be MIDI numbers ('60') or note 
     names ('c4','f#3','bb2','cs5'). Tokens are separated by commas.
     Supports * for multiply and / for divide."
    <onTheFlyEssentials>
    | seq tokens gates durs notesAsStrings notesAsNumbers dirtString |
    gates := ''.
    durs := OrderedCollection new.
    tokens := self splitOn: ','.
    dirtString := ''.

    tokens do: [ :i |
        (i includes: $*)
            ifTrue: [
                gates := gates , i multiplyStringsInString , ' '.
                ((i includes: $~) or: [ i includes: $- ])
                    ifFalse: [ i getMultiplier timesRepeat: [ durs add: 1 ] ] ]
            ifFalse: [
                (i includes: $/)
                    ifTrue: [
                        gates := gates , i withNRests , ' '.
                        ((i includes: $~) or: [ i includes: $- ])
                            ifFalse: [ durs add: i getDivisor ] ]
                    ifFalse: [
                        gates := gates , i , ' '.
                        ((i includes: $~) or: [ i includes: $- ])
                            ifFalse: [ durs add: 1 ] ] ] ].

    "Extract note tokens, strip rests and empty strings"
    notesAsStrings := ((gates copyReplaceAll: '~' with: '')
        copyReplaceAll: '-' with: '') findBetweenSubstrings: ' '.
    notesAsStrings := notesAsStrings reject: [ :i |
        i isEmpty or: [ i = ' ' ] ].

    "Convert to MIDI numbers — supports both '60' and 'c4'"
    notesAsNumbers := notesAsStrings collect: [ :i | i asMidiNote ].

    notesAsNumbers do: [ :i |
        dirtString := dirtString , i asString , ' ' ].

    seq := gates asSeqGates asSeq.
    seq dirtNotes: dirtString.
    seq notes: notesAsNumbers asArray.
    durs isEmpty ifTrue: [ durs add: 1 ].
    seq durations: durs asArray.
    ^ seq
]

{ #category : '*Coypu' }
ByteString >> asDirtPureNotes [
	" retruns just the note numbers parsed - tokens must be separated by string"

	| seq tokens gates notesAStrings notesAsNumbers dirtString  |

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
		                  i ~= ' ' ifTrue: [ i asNumber ] ].

	notesAsNumbers do: [ :i |
		dirtString := dirtString , i asString , ' ' ].

	seq := gates asSeqGates asSeq.
	seq dirtNotes: dirtString.
	seq notes: notesAsNumbers asArray.

	^ notesAsNumbers asArray
]

{ #category : '*Coypu' }
ByteString >> asDirtSounds [
	" parse a String into a Sequencer containing information to end to the SuperDirt synth for SuperCollider"

	<onTheFlyEssentials>
	| seq tokens gates soundsAsStrings soundsAndDirtNotesArray soundAndDirtNotes notesAsIndex |
	gates := ''.
	tokens := self splitOn: ','.

	tokens do: [ :i |
			(i includes: $*)
				ifTrue: [ gates := gates , i multiplyStringsInString ]
				ifFalse: [
						(i includes: $/)
							ifTrue: [ gates := gates , i withNRests ]
							ifFalse: [ gates := gates , i ] ] ]. "soundsAsStrings := (((gates copyReplaceAll: '~' with: '')
		                    copyReplaceAll: '-'
		                    with: '') copyReplaceAll: ':' with: '') findBetweenSubstrings: ' '."
	soundsAsStrings := gates select: [ :ch |
		                   ch isLetter or: ch isSeparator ].
	soundAndDirtNotes := gates select: [ :ch |
		                     (ch isLetter or: ch isDigit) or: ch isSeparator ].
	soundsAndDirtNotesArray := soundAndDirtNotes findBetweenSubstrings:
		                           ' '.
	notesAsIndex := soundsAndDirtNotesArray collect: [ :i |
		                i hasDigit asInteger ].




	seq := gates asSeqGates asSeq. "seq sound: (soundsAsStrings joinUsing: ' ')."
	seq sound: soundsAsStrings.

	(soundsAsStrings findBetweenSubstrings: ' ') do: [ :i |
			seq phaustoGateDestinations: i , 'Trigger'.
			seq phaustoNoteDestinations: i , 'Freq' ].
	seq notes: notesAsIndex asArray.
	

	^ seq
]

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
ByteString >> asMidiNN [

| octave noteBaseNumber noteName |
octave := ('(\d+)' asRegex matchesIn: self) first  asInteger.
noteName := ('(\D+)' asRegex matchesIn: self) first .

noteBaseNumber := Chord notesNamesToNumbers at: noteName .
^ noteBaseNumber  + ((octave  + 2) * 12).

]

{ #category : '*Coypu' }
ByteString >> asMidiNote [
	"Converts a note name ('c4','f#3','bb2','cs5') 
     or a MIDI number string ('60') to a MIDI note number.
     Supports: # s for sharp, b f for flat, ## x ss for double sharp, 
     bb ff for double flat. c4 = 60.
     TidalCycles-style notation (s for sharp, f for flat) is supported
     alongside standard notation."

	<onTheFlyEssentials>
	| input noteChar rest accidental octaveStr semitones octave acc digitStart |
	input := self trimBoth asLowercase.

	"Plain number — just return it"
	(input allSatisfy: [ :c | c isDigit ]) ifTrue: [
		^ input asNumber min: 127 ].

	semitones := Dictionary new.
	semitones
		at: $c put: 0;
		at: $d put: 2;
		at: $e put: 4;
		at: $f put: 5;
		at: $g put: 7;
		at: $a put: 9;
		at: $b put: 11.

	"First character is always the note letter"
	noteChar := input first.
	(semitones includesKey: noteChar) ifFalse: [
		Error signal: 'Unknown note: ' , noteChar asString ].

	rest := input allButFirst.

	"Octave is the trailing digit(s)"
	digitStart := rest size.
	[ digitStart > 0 and: [ (rest at: digitStart) isDigit ] ] whileTrue: [
		digitStart := digitStart - 1 ].
	octaveStr := rest copyFrom: digitStart + 1 to: rest size.
	octaveStr isEmpty ifTrue: [octaveStr := 4].

	"Accidental is whatever sits between note letter and octave"
	accidental := rest copyFrom: 1 to: digitStart.

	"Map accidental to semitone offset"
	acc := 0.
	(#( '##' 'x' 'ss' ) includes: accidental) ifTrue: [ acc := 2 ].
	(#( '#' 's' ) includes: accidental) ifTrue: [ acc := 1 ].
	(#( 'b' 'f' ) includes: accidental) ifTrue: [ acc := -1 ].
	(#( 'bb' 'ff' ) includes: accidental) ifTrue: [ acc := -2 ].

	octave := octaveStr asNumber.

	^ octave + 1 * 12 + (semitones at: noteChar) + acc min: 127 max: 0
]

{ #category : '*Coypu' }
ByteString >> asPacaAddress [


	"set the pacaAddress globally from the corresponding Paca(rana) serial number"
| serialNumber |
serialNumber := 'beslime-51.local'.
	Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress:
			 (NetNameResolver addressForName: serialNumber )).
	^ NetNameResolver stringFromAddress:
		  (NetNameResolver addressForName: serialNumber )
]

{ #category : '*Coypu' }
ByteString >> asSeqGates [
	
| gates tokens|

" return an array of gates and rests, rests corrresponding to the ~ characters in the string"
gates := OrderedCollection new.
tokens := self findBetweenSubstrings: ' '.
tokens do: [ :i | i = '~' ifTrue: [ gates add: 0]  ifFalse: [ gates add: 1  ]  ].

^ gates asArray.

]

{ #category : '*Coypu' }
ByteString >> asTidalIndex [
    | topSlots cycleLengths gatesString allIndices seq |
    topSlots := self splitTopLevelSlots.
    cycleLengths := OrderedCollection new.
    gatesString := ''.
    allIndices := OrderedCollection new.
    topSlots do: [ :slot |
        | leaves |
        leaves := slot parseTidalLeaves.
        cycleLengths add: leaves size.
        leaves do: [ :leaf |
            ((leaf = '~') or: [ leaf = '-' ])
                ifTrue: [ gatesString := gatesString , '~ ' ]
                ifFalse: [
                    gatesString := gatesString , leaf , ' '.
                    allIndices add: leaf  ] ] ].
    seq := gatesString trimBoth asSeqGates asSeq.
    seq index: allIndices asArray.
    seq cycleLengths: cycleLengths asArray.
    ^ seq
]

{ #category : '*Coypu' }
ByteString >> asTidalNotes [
    | topSlots cycleLengths gatesStream notesStream seq |
    topSlots := self splitTopLevelSlots.
    cycleLengths := OrderedCollection new.
    gatesStream := WriteStream on: String new.
    notesStream := OrderedCollection new.
    topSlots do: [ :slot |
        | leaves slotCycleLength newNotes newCycleLengths |
        leaves := slot parseTidalLeaves.
        slotCycleLength := topSlots size * leaves size.
        newNotes := OrderedCollection new.
        newCycleLengths := OrderedCollection new.
        leaves do: [ :leaf |
            newCycleLengths add: slotCycleLength.
            (#('~' '-') includes: leaf)
                ifTrue: [ gatesStream nextPutAll: '~ ' ]
                ifFalse: [
                    newNotes add: leaf asMidiNote.
                    gatesStream
                        nextPutAll: leaf;
                        nextPut: $  ] ].
        cycleLengths addAllLast: newCycleLengths.
        notesStream addAllLast: newNotes ].
    seq := gatesStream contents trimBoth asSeqGates asSeq.
    seq notes: notesStream asArray.
    seq cycleLengths: cycleLengths asArray.
    ^ seq
]

{ #category : '*Coypu' }
ByteString >> asVerticalFaderLocal: aRange [

	| fader |
		" the fader label is also the OSC address"

	fader := VerticalFaderForOSC newWithAddress: self range: aRange .
	fader openInWindow  
		 
]

{ #category : '*Coypu' }
ByteString >> chordsToArrays [
	
| chordsAsStrings chordAsArrays|
chordsAsStrings := self findBetweenSubstrings: ' '.
chordAsArrays := chordsAsStrings collect: [ :i| i parseChord  ].
^ chordAsArrays 

]

{ #category : '*Coypu' }
ByteString >> every: anInteger [ 

" return a string with self and anInteger minus one  number of breaks - to be used to construct patterns for SuperDirt"
	| result |
	result :=  OrderedCollection new.
	result  add: self.
	(2 to: anInteger) do: [ :i | result add: ' ';  add: '~' ].
	^ result
	
]

{ #category : '*Coypu' }
ByteString >> getDivisor [

	| tokens |
	tokens := self splitOn: '/'.

	^ tokens second asInteger
]

{ #category : '*Coypu' }
ByteString >> getMultiplier [

	| tokens |
	tokens := self splitOn: '*'.

	^ tokens second asInteger
]

{ #category : '*Coypu' }
ByteString >> hasDigit [
   "Return false if the receiver has no digits.
     If digits exist, return the full number as an Integer."
    
    | digits |
    digits := self select: [ :ch | ch isDigit ].
    digits isEmpty ifTrue: [ ^ false ].
    ^ digits asString asInteger
]

{ #category : '*Coypu' }
ByteString >> hexBeat [
	" convert a string with an Hexadecimal number to the Kyma array correspondong to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"

	<onTheFlyEssentials>
	| strings flat rhythm  |
	
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

{ #category : '*Coypu' }
ByteString >> hexBeat: aStringOfNoteNumbers [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes"

	| strings flat seq |
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

{ #category : '*Coypu' }
ByteString >> hexBeat: anArrayOfNoteNumbers dur: anArrayOfDurations [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes and anArrayOfDurations as Durations"

	| strings flat |
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers and: anArrayOfDurations
]

{ #category : '*Coypu' }
ByteString >> hexBeat: aStringOfNoteNumbers to: aKey [
	"conveience method to avoid parenthesis !!! returns the Sequencer that has been created"
| seq |
	seq := (self hexBeat: aStringOfNoteNumbers) .
	seq to: aKey.
	^ seq
]

{ #category : '*Coypu' }
ByteString >> inWords [
" return an Ordered collection separating all the words inside the string"
	^ self findBetweenSubstrings: ' '
]

{ #category : '*Coypu' }
ByteString >> index: anArrayOfIndexes to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern index: anArrayOfIndexes to: aKeyInAPerformance 
]

{ #category : '*Coypu' }
ByteString >> isQuotedString [
	
^ self includes: $'
]

{ #category : '*Coypu' }
ByteString >> midiCh: anInteger to: aKeyInPerformance [
	"conveneience method to avoid extra parenthesis"
(self pattern  midiChannel: anInteger) to: aKeyInPerformance 
]

{ #category : '*Coypu' }
ByteString >> multiplyStringsInString [
"multiply the string before the * fro the integer after the *"
| tokens |

	tokens := self splitOn: '*'. 
	
^ tokens first * tokens second asInteger
]

{ #category : '*Coypu' }
ByteString >> notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInAPerformance
]

{ #category : '*Coypu' }
ByteString >> notes: anArrayOfNotes  to: aKeyInAPerformance [
	
"convenience method to avoid extra parenthesis when sending an HEX rhythm pattern to aKeyInPerformance"

self pattern notes: anArrayOfNotes to: aKeyInAPerformance .
]

{ #category : '*Coypu' }
ByteString >> notesFor: aSequencer [

aSequencer notes: self asDirtPureNotes 
]

{ #category : '*Coypu' }
ByteString >> once [
	"play the sound from the SuperDirt audio engine once at the desired index if any -
for exampe cp:4 sound the 3rd sample of the /Library/Application\ Support/SuperCollider/downloaded-quarks/Dirt-Samples/cp folder"

	| sound note message parsedString |
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

{ #category : '*Coypu' }
ByteString >> onceAtSpeed: aFloat [
	"play the soundfrom the SuperDirt audio engine once at the desired speed"

	| sound note message parsedString condition  |

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

{ #category : '*Coypu' }
ByteString >> onceAtSpeed: aFloat withNote: aNote [
	"play the soundfrom the SuperDirt audio engine once at the desired speed"

	| sound message parsedString condition  |
	
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

{ #category : '*Coypu' }
ByteString >> parseChord [
	"chords can be xpressed both with letteres or with MIDI NoteNumbers"

	| root chord notes chordSymbol |
	root := 0.
	chord := self. "if the root is specified"
	(self includes: $-) ifTrue: [
		root := (self findBetweenSubstrings: '-') at: 1.
		chord := (self findBetweenSubstrings: '-') at: 2 ].
	notes := Array new: 11.
	notes := #( 'c' 'c#' 'd' 'd#' 'e' 'f' 'f#' 'g#' 'a' 'a#' 'b' ).
	chordSymbol := chord asLowercase asSymbol.
	(Chord list includesKey: chordSymbol)  ifTrue: [  
	root asInteger
		ifNotNil: [
		^ (Chord list at: chordSymbol) + root asInteger ]
		ifNil: [
			^ (Chord list at: chordSymbol )
			  + (notes indexOf: root asLowercase) - 1 ]] ifFalse: [ Error new signal: chord , 'is not a valid Chord' ]
]

{ #category : '*Coypu' }
ByteString >> parseChordWithoutRoot [

	^ (Chord list at: self asLowercase asSymbol)
]

{ #category : '*Coypu' }
ByteString >> parseTidalLeaves [

	  "Recursively flatten a slot into leaf tokens.
     'bd' => #('bd')
     '[sd*3]' => #('sd' 'sd' 'sd')
     '[cp [ht lt]]' => #('cp' 'ht' 'lt')"
    | inner slots leaves |
    inner := self trimBoth.
    (inner beginsWith: '[') ifTrue: [
        inner := (inner copyFrom: 2 to: inner size - 1) trimBoth ].
    slots := inner splitTopLevelSlots.
    leaves := OrderedCollection new.
    slots do: [ :s |
        (s includes: $[)
            ifTrue: [ leaves addAll: s parseTidalLeaves ]
            ifFalse: [
                (s includes: $*)
                    ifTrue: [ s getMultiplier timesRepeat: [
                        leaves add: (s copyUpTo: $*) ] ]
                    ifFalse: [ leaves add: s ] ] ].
    ^ leaves
]

{ #category : '*Coypu' }
ByteString >> pattern [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"

	| strings flat |
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm asSeq
]

{ #category : '*Coypu' }
ByteString >> pattern: anArrayOfNoteNumbers [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes"

	| strings flat |
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers
]

{ #category : '*Coypu' }
ByteString >> pattern: anArrayOfNoteNumbers and: anArrayOfDurations [
	" convert a string with an Hexadecimal number to the Kyma array corresponding to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex) , and with  anArrayOfNoteNumbers as Notes and anArrayOfDurations as Durations"

	| strings flat  |
	
	strings := (1 to: self size) collect: [ :i |
		           (self at: i) digitValue
			           printStringBase: 2
			           length: 4
			           padded: true ].
	flat := strings flatCollect: [ :each | each ].
	^ ((1 to: flat size) collect: [ :i | (flat at: i) digitValue ])
		  asRhythm and: anArrayOfNoteNumbers and: anArrayOfDurations
]

{ #category : '*Coypu' }
ByteString >> randomNotesFromFolder [
"returns a random number (between 2 and 512) of indexes from the folder wit self name"
| randIndex folder folderSize|
	randIndex := Random new nextIntegerBetween: 2 and:  512.
	folder := SuperDirt samplesFolder / self .
	folderSize := folder asFileReference allChildren size. 
	^ randIndex randomInts: folderSize .
]

{ #category : '*Coypu' }
ByteString >> splitRespectingQuotes [
    | result token inQuotes |
    result := OrderedCollection new.
    token := WriteStream on: String new.
    inQuotes := false.

    self do: [:ch |
        (ch = $') 
            ifTrue: [
                inQuotes := inQuotes not.
                token nextPut: ch  "Keep the quote"
            ]
            ifFalse: [
                (ch = Character space and: [inQuotes not])
                    ifTrue: [
                        token position > 0 ifTrue: [   "WriteStream not empty"
                            result add: token contents.
                            token := WriteStream on: String new ].
                    ]
                    ifFalse: [
                        token nextPut: ch ]]].

    token position > 0 ifTrue: [ result add: token contents ].
    ^ result

]

{ #category : '*Coypu' }
ByteString >> splitTopLevelSlots [
    "Split into top-level tokens, keeping bracketed groups intact.
     'bd [sd*3] [cp ht lt]' => #('bd' '[sd*3]' '[cp ht lt]')"
    | slots current depth |
    slots := OrderedCollection new.
    current := ''.
    depth := 0.
    self do: [ :ch |
        ch = $[ ifTrue: [ depth := depth + 1 ].
        ch = $] ifTrue: [ depth := depth - 1 ].
        (ch = Character space and: [ depth = 0 ])
            ifTrue: [
                current trimBoth isEmpty ifFalse: [ slots add: current trimBoth ].
                current := '' ]
            ifFalse: [ current := current , ch asString ] ].
    current trimBoth isEmpty ifFalse: [ slots add: current trimBoth ].
    ^ slots
]

{ #category : '*Coypu' }
ByteString >> sweepToLocalValue: anArrayWithStartAndEndValue in: aTimeInseconds [
	" send a sweep of values to the OSC address equals to self in aTimeInSeconds"

	| startValue currentValue range timeInDeciSec step numberOfSteps stepDelay incrementingProcess decrementingProcess targetValue |
	startValue := anArrayWithStartAndEndValue first.
	targetValue := anArrayWithStartAndEndValue second.
	range := (startValue max: targetValue)
	         - (startValue min: targetValue).
	timeInDeciSec := aTimeInseconds * 10.
	step := range / timeInDeciSec.
	stepDelay := Delay forSeconds: 0.1.
	numberOfSteps := timeInDeciSec.
	currentValue := startValue.
	decrementingProcess := [
		                       numberOfSteps timesRepeat: [
				                       currentValue := currentValue - step.
				                       currentValue toLocal: self.

				                       stepDelay wait ] ].
	incrementingProcess := incrementingProcess := [
		                                              numberOfSteps
			                                              timesRepeat: [
					                                              currentValue := currentValue
					                                                              +
					                                                              step.
					                                              currentValue
						                                              toLocal: self.
					                                              stepDelay wait ] ].
	startValue < targetValue 
		ifTrue: [ incrementingProcess fork ]
		ifFalse: [ decrementingProcess fork ]
]

{ #category : '*Coypu' }
ByteString >> to: aKeyInPerformance [ 
	"convenience method to insert at aKeyInPerformance a pattern from the hex string"
	
| p |

p := Performance uniqueInstance .
self hexBeat to: aKeyInPerformance 
]

{ #category : '*Coypu' }
ByteString >> toKymaAsGate [
	" send an OSC message that mimics the behaviour oa MIDI note on message, note is held for a default duration of 2 seconds"
	| vcslabel  |
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcslabel := '/vcs/', self , 'Gate', '/1'.
	(OSCMessage for: { vcslabel  . 1.0  }) sendToAddressString: PacaAddress address  port: 8000.
	(Delay forSeconds: 2) wait.
	(OSCMessage for: { vcslabel  . 0.0  }) sendToAddressString: PacaAddress address  port: 8000.
]

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
ByteString >> toKymaAsGate: gateTimeInSeconds note: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| vcsGatelabel vcsNoteLabel sendNoteNumber pacaAddress |
    pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). 
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
				 0.0 }) sendToAddressString: pacaAddress port: 8000. "then note On"
		(OSCMessage for: {
				 vcsGatelabel.
				 1.0 }) sendToAddressString: pacaAddress port: 8000.
		(Delay forSeconds: gateTimeInSeconds) wait.
		"then note Off"
		(OSCMessage for: {
				 vcsGatelabel.
				 0.0 }) sendToAddressString: pacaAddress port: 8000 ] fork
]

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
ByteString >> toKymaAsNoteOff: aNoteNumber [
	" send an OSC message that mimics the behaviour oa MIDI note on message."
	| vcsGatelabel  vcsNoteLabel|
"	pacaAddress := NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local'). "

	vcsGatelabel := '/vcs/', self , 'Gate', '/1'.
	vcsNoteLabel := '/vcs/', self , 'Note', '/1'.
	
(OSCMessage for: { vcsNoteLabel  . aNoteNumber asFloat }) sendToAddressString: PacaAddress address port: 8000.
(OSCMessage for: { vcsGatelabel  . 0.0  }) sendToAddressString: PacaAddress address  port: 8000.

]

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
ByteString >> toLocal: aString [
	"comment stating purpose of instance-side message"

	"scope: class-variables  &  instance-variables"

	| localAddress |
	localAddress := '127.0.0.1'.


	(OSCMessage for: {
			 ('/' , aString).
			 self  }) sendToAddressString: localAddress port: 57120
]

{ #category : '*Coypu' }
ByteString >> toLocalAsGate [

	" send an OSC message that mimics the behaviour of MIDI note on message, note is held for a default duration of 0.25 second and midi NN is 60"
self toLocalAsGate: 0.25 note: 60 
]

{ #category : '*Coypu' }
ByteString >> toLocalAsGate: gateTimeInSeconds [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds, MIDI noteNumber is 60"

self toLocalAsGate: gateTimeInSeconds note: 60.
]

{ #category : '*Coypu' }
ByteString >> toLocalAsGate: gateTimeInSeconds note: aNoteNumber [

	" send an OSC message that mimics the behaviour oa MIDI note on message.
	gateTime is expressed in seconds"

	| oscGate oscNote localAddress |
	localAddress := '127.0.0.1'.

	oscGate := '/' , self , 'Gate'.
	oscNote := '/' , self , 'Note'.
	[(OSCMessage for: { 
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
			 0.0 }) sendToAddressString: localAddress port: 57120] fork
]

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
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

{ #category : '*Coypu' }
ByteString >> trigLocal [
	"trig sound on OSC server nameds self, with suffix Gate"

	self toLocalAsGate: 0.25 note: 60
]

{ #category : '*Coypu' }
ByteString >> withNRests [
	" add rests to a string divided by an Integer inside a String"
	
| tokens |
tokens := self splitOn: '/'.

^ tokens first / tokens second asString asInteger
]
