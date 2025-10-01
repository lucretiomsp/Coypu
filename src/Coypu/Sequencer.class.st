"
A Sequencer contains gates, notes, duration and a noteIndex. extra1 and extra2 controls can be added.
A Sequencer can contain a MIDI channel, as intended to play it on a Performance for a MIDI sender.
A Sequencer contains a template for a message for the SuperDirt audio engine.

The Sequencer is the basic unit in Performance.


It is conceived as something in between a Digital Audio Workstation track and a ""clip"".
"
Class {
	#name : 'Sequencer',
	#superclass : 'Object',
	#instVars : [
		'seqKey',
		'extraParams',
		'notes',
		'durations',
		'noteIndex',
		'gates',
		'midiChannel',
		'visualGroup',
		'cycleDurations',
		'seqChords',
		'soundPattern',
		'samplesIndex',
		'dirtMessage',
		'orbit',
		'isPoly',
		'phaustGateDestination',
		'phaustNoteDestination',
		'kymaMessage',
		'transportStep',
		'gateTimes'
	],
	#classInstVars : [
		'orbit'
	],
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'accessing' }
Sequencer class >> orbit [
   
orbit isNil ifTrue: [ ^ 0 ] ifFalse: [^ orbit]
]

{ #category : 'accessing' }
Sequencer class >> orbit: anInteger [

	orbit := anInteger % 12 
]

{ #category : 'replication' }
Sequencer >> * anInteger [

	"returns a sequencer containing anInteger repetition of self - polysemic bunary version of times:"

	| newGates newNotes newDurations |
	newGates := (self gates times: anInteger) asRhythm.
	newNotes := self notes times: anInteger.
	newDurations := self durations asDirtArray times: anInteger.



	^ SequencerMono new
		  gates: newGates;
		  notes: newNotes;
		  durations: newDurations;
		  noteIndex: 0
]

{ #category : 'arithmetic' }
Sequencer >> + aString [ 
	self shouldBeImplemented.
]

{ #category : 'combination' }
Sequencer >> , anotherSequencer [
	"combine the gates of two sequencers, returns a sequencer"

	| newGates newNotes newDurations notes1 notes2 |


	notes1 := self notes.
	notes2 := anotherSequencer notes.
	newGates := self gates , anotherSequencer gates.
	newDurations := self durations asDirtArray
	                , anotherSequencer durations asDirtArray.

	newNotes := notes1 , notes2.
	^ self class new
		  gates: newGates;
		  notes: newNotes;
		  durations: newDurations;
		  noteIndex: 0
]

{ #category : 'comparing' }
Sequencer >> < aStringOfNotesOrAnaArrayIfNotes [
	"same as notes but binary!"



	^ self notes: aStringOfNotesOrAnaArrayIfNotes 
]

{ #category : 'comparing' }
Sequencer >> = anotherSequencer [ 
	" equality between sequencers"
	^ ((self notes = anotherSequencer notes) & (self gates = anotherSequencer gates) & (self durations = anotherSequencer durations) & (self extraParams = anotherSequencer extraParams))
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> > aKeyInPerformance [

"binary obscure polysemic alternative of to: methhod"

self to: aKeyInPerformance 
]

{ #category : 'adding' }
Sequencer >> add: anAssociation [
	" add an associtation of a parameter and a value or an array of values to the dirtMessage"
	dirtMessage add: anAssociation 

]

{ #category : 'modifying' }
Sequencer >> allNotes: anInteger [

	"fill sequencer notes with anArray with all equals notenumbers"

	| newNotes |
	newNotes := Array new: self numberOfGates.
	1 to: newNotes size do: [ :i | newNotes at: i put: anInteger ].
	self notes: newNotes.
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> amount: aStringOrAnArray [
	"set the amount to a collection of value in array or to to the numbe"

	self extra: #Amount values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'converting' }
Sequencer >> asPolySeq [
	
	self subclassResponsibility 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> bpf: aFloatOrAnArray [
	" add bandpass filter effect to the Sequencer at aFloatOrArray frequency"
	self dirtMessage 
		at: 'bandf' 
		put:  aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> bpq: aFloatOrAnArray [
	" add bandpass filter effect to the Sequencer with aFloatOrArray frequency"
	self dirtMessage 
		at: 'bpq' 
		put:  aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> bw: aStringOrAnArray [
	"set the bandwidth (bw) to  a collection of value in array or to to the numbe"

	self extra: #Bw values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> ccn: anIntOrAnArray ccv: anotherIntOrArray [
	" add a cc value/array of values to a cc number - to use with MIDI"

	self dirtMessage at: 'ccn' put: anIntOrAnArray asDirtArray.
	self dirtMessage at: 'ccv' put: anotherIntOrArray asDirtArray.
	
   self extra: anIntOrAnArray values: anotherIntOrArray 
]

{ #category : 'accessing' }
Sequencer >> chords: aStringWithOneOrMoreChords [
	" note and chord type separated by an hyphen for example 'c-maj d#-min f-sus4 e-min7') - can be expressed with a letter or with a note number."

	| arrayOfChords poly|
	arrayOfChords := aStringWithOneOrMoreChords chordsToArrays.
	seqChords := arrayOfChords.
	
	poly := self asPolySeq .
	poly dirtMessage add: 'n' -> arrayOfChords .
	^ poly
]

{ #category : 'accessing' }
Sequencer >> chords: aStringWithOneOrMoreChords octave: anIntegerOrAnArray [ 
	" note and chord type separated by an hyphen for example 'c-maj d#-min sus4 min7')"

	| arrayOfChords |
	arrayOfChords :=  aStringWithOneOrMoreChords chordsToArrays.
	seqChords := arrayOfChords + (anIntegerOrAnArray * 12).
   ^ self asPolySeq
	
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> cutoff: aStringOrAnArray [
	"set the cutoff to a collection of value in array or to to the numbe"

	self extra: #Cutoff values:aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> cutoffFreq: aStringOrAnArray [
	"set the cutoffFreq to a collection of value in array or to to the numbe"

	self extra: #CutoffFreq values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'sequencer - cycles' }
Sequencer >> cycleDurations [
	" return the duration of each event in the cycle"
	^ cycleDurations
]

{ #category : 'sequencer - cycles' }
Sequencer >> cycleDurations: anArrayOfFractions [

	cycleDurations := anArrayOfFractions 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> decay: aStringOrAnArray [
	"set the decay to a collection of value in array or to to the numbe"

	self extra: #Decay values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> delay: aFloatOrAnArray [
	" add delay wet/dry pattern to the Sequencer"

	self dirtMessage 
		at: 'delay' 
		put: aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> delayFb: aFloatOrAnArray [
	" add delay feedback pattern to the Sequencer"
	
	self dirtMessage 
		at: 'delayfb' 
		put: aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> delayTime: aFloatOrAnArray [
	" add delay time pattern to the Sequencer"
	self dirtMessage 
		at: 'delaytime' 
		put: aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> dirt: anArrayForSuperDirt [
	"fills the OSC dirtmessage for SuperDirt with suitable values"
	| keys values msgExtension msgExtensionSize  |
	keys := OrderedCollection new.
	values := OrderedCollection new.
	msgExtension := OrderedCollection new.

	msgExtensionSize := anArrayForSuperDirt size /2.

	anArrayForSuperDirt 
		doWithIndex: [ :value :i| i odd 
				ifTrue: [keys add: value  ] 
				ifFalse:  [  value isNumber 
								ifTrue: [ values add: value asFloat asDirtArray  ] 
								ifFalse: [ values add: value asDirtArray ] ] ]. 

	1 to: msgExtensionSize do: [:i | 
		dirtMessage 
			at: (keys at: i) 
			put: (values at: i)]
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> dirt: anArrayForSuperDirt to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis"
	(self dirt: anArrayForSuperDirt) to: aKeyInPerformance 
]

{ #category : 'accessing' }
Sequencer >> dirtMessage [

	^ dirtMessage
]

{ #category : 'accessing' }
Sequencer >> dirtMessage: anArrayOfAssociationForSuperDirt [
" template for OSC messages for SuperDirt"

	dirtMessage := anArrayOfAssociationForSuperDirt
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> dirtNotes: aStringWithNotes [
	"add into a Sequencer anotes from a String in which numbers can be multiplicated"

	| tokens dNotes arrayOfNotes   |

	tokens := aStringWithNotes splitOn: ','.
	dNotes := ' '.
	tokens do: [ :i |
			dNotes := (i includes: $*)
				          ifTrue: [ dNotes , i multiplyStringsInString ]
				          ifFalse: [ dNotes , i ] ].

	arrayOfNotes := (dNotes findBetweenSubstrings: '  ') collect: [ :each |
		                each asNumber ].
	self notes: arrayOfNotes asArray.
	self dirtMessage at: 'n' put: arrayOfNotes asDirtArray.

	^ self
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> djf: aFloatOrAnArray [
	"Made by Alex McLean. A fun classic DJ Filter. Low pass filter for the first half of the range, high pass for the rest:"
	self dirtMessage 
		at: 'djf' 
		put:  aFloatOrAnArray asDirtArray
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> drive: aStringOrAnArray [
	"set the drive to a collection of value in array or to to the numbe"

	self extra: #Drive values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'accessing' }
Sequencer >> duration [

	^ self durations at: (self noteIndex modulo: self durationsSize)
]

{ #category : 'accessing' }
Sequencer >> durations [

	^ durations
]

{ #category : 'accessing' }
Sequencer >> durations: anArray [

	durations := anArray
]

{ #category : 'accessing' }
Sequencer >> durationsSize [

	^ durations size
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> duty: aStringOrAnArray [
	"set the duty cycle to a collection of value in array or to to the numbe"

	self extra: #Duty values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> effect: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the effect, i.e. dry/wet "

	self extra: #Effect values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> envMod: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the envMod, "

	self extra: #EnvMod values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> extra: aSymbol values: aStringWithIndexes [
	"stores extra values to control synths parameters on Kyma values can be a Number, an Array or  a valid string of Coypu Notation"

	|  stringWithIndexes |
	stringWithIndexes := aStringWithIndexes.
	aStringWithIndexes class = Array ifTrue: [
			stringWithIndexes := String streamContents: [ :s |
					                     aStringWithIndexes do: [ :each |
							                     s
								                     nextPutAll: each asString;
								                     nextPutAll: ' ' ] ] ].

	self extraParams
		at: aSymbol
		put: aStringWithIndexes asDirtArrayOfValues
]

{ #category : 'accessing' }
Sequencer >> extraParams [

	^ extraParams
]

{ #category : 'accessing' }
Sequencer >> extraParams: anArrayWithASymbolAndAnrrayOfValues [


|parameter value |
parameter := anArrayWithASymbolAndAnrrayOfValues at: 1.
value := anArrayWithASymbolAndAnrrayOfValues at: 2.

	extraParams at: parameter put: value asDirtArray 
]

{ #category : 'accessing' }
Sequencer >> fillNotes: anArray [

	notes := anArray
]

{ #category : 'Sequencer - transformation' }
Sequencer >> flip [
	"Inverts the gate/rest pattern of the sequence — turning active steps (gates) into rests and vice versa."

<onTheFlyEssentials>
	| result |
	result := self gates collect: [ :i | (i ~= 1) asInteger ].
	^ result asRhythm asSeq
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> gain: aFloatOrAnArray [
	" add gain pattern to the Sequencer"
	self dirtMessage 
		at: 'gain' 
		put: aFloatOrAnArray asDirtArray
]

{ #category : 'accessing' }
Sequencer >> gateTimes [

	^ gateTimes
]

{ #category : 'modifying' }
Sequencer >> gateTimes: anArrayOrANumber [
	"a gate time value of 0.8 sets the duration to just under full value, i.e. plays notes that are connected sounding. A value of 1 produces a legato effect, a 0.5 produce a statccato sound"

	gateTimes := anArrayOrANumber asDirtArray
]

{ #category : 'accessing' }
Sequencer >> gates [

	^ gates
]

{ #category : 'modifying' }
Sequencer >> gates: aRhythm [
	"change the rhythm inside the sequencer"

	gates := aRhythm
]

{ #category : 'accessing' }
Sequencer >> gatesSize [

	^ gates size
]

{ #category : 'LiveCoding - sequencer' }
Sequencer >> gatesSize: anInteger [ 
	self shouldBeImplemented.
]

{ #category : 'accessing' }
Sequencer >> hasChords [

	| result |
	result := false.
		self chords isNil
			ifTrue: [ ^ false ]
			ifFalse: [ ^ true ].
	^ result
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> hold: aFloatOrAnArray [
	" add hold ASR envelope pattern to the Sequencer"
	
	self dirtMessage 
		at: 'rel' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'LiveCoding - sequencer' }
Sequencer >> incrementTransportStep [ 

self transportStep: self transportStep + 1.
]

{ #category : 'accessing - sequencer' }
Sequencer >> index [

	^ self extra1 at: 2
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> index: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the index , i.e. the sample number of a sample player"

	self extra: #Index values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> index: anArrayOfIndexes to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis to put a sequencer of gates with sample indexes into a performance"
	| p |
	p := Performance uniqueInstance.
	self to: aKeyInPerformance.
	aKeyInPerformance indexes: anArrayOfIndexes 
]

{ #category : 'initialization' }
Sequencer >> initialize [

	super initialize.
	isPoly := false.
	"by defaul gateTime is 0.9"
	gateTimes := #(0.9).
	dirtMessage := Dictionary new.
	transportStep := 0.
	dirtMessage
		at: 'cps'
		put: (Performance uniqueInstance freq * 4) asFloat.
	"superdirt orbits are 12"
	self class orbit: self class orbit + 1.
	orbit := self class orbit.

	"for Kyma"
	extraParams := Dictionary new

	"dirtMessage addAll: { '_id' -> 1 . 'cps' -> 0.56 .  'orbit' -> 0 }"
	
]

{ #category : 'accessing' }
Sequencer >> isPoly [

	^ isPoly
]

{ #category : 'accessing' }
Sequencer >> isPoly: aBolean [

	isPoly := aBolean
]

{ #category : 'LiveCoding - sequencer' }
Sequencer >> isPolySeq [

	self subclassResponsibility
]

{ #category : 'testing' }
Sequencer >> isSequencer [

	^ true
]

{ #category : 'accessing' }
Sequencer >> kymaMessage [

	^ kymaMessage
]

{ #category : 'accessing' }
Sequencer >> kymaMessage: anObject [

	kymaMessage := anObject
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> level: aStringOrAnArray [
	"set the decay to a collection of value in array or to to the number"

	self extra: #ULevel values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> lfoAmount: aStringOrAnArray [
	"set the lfoAmount to a collection of value in array or to to the numbe"

	self extra: #LfoAmount values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> lfoFreq: aStringOrAnArray [
	"set the lfo freqency"

	self extra: #LfoFreq values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> lock: aFloatOrAnArray [
	" add lock pattern to the Sequencer -  a pattern of numbers. Specifies whether delaytime is calculated relative to bpm. When set to 1, delaytime is a direct multiple of a bar."
	
	self dirtMessage 
		at: 'lock' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'modifying' }
Sequencer >> melodyFrom: aScale [

	| array |
	array := self numberOfGates randomNotesFrom: aScale.
	array at: 1 put: (aScale at: 1).
	2 to: array size do: [ :i | 
		((array at: i) rem: 12) = 0 ifTrue: [ 
			array at: i - 1 put: (aScale at: 6) ].
		((array at: i) rem: 12) = 2 ifTrue: [ 
			array at: i - 1 put: (aScale at: 5) ] ].
	"last note is mediante or dominante"
	^ self notes: array
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> midiCh: anInteger to: aKeyInPerformance [

	" convenience method to avoid extra parenthesis when assigning a midiChannel to  akey in a performance"
   | p |
	p := Performance uniqueInstance.
	p at: aKeyInPerformance put: (self midiChannel: anInteger).
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> midiChan: anIntegerOrAnArrayOfIntegers [
	" add midichannel for SuperDirt to the Sequencer "
	
	self dirtMessage 
		at: 'midichan' 
		put:  (anIntegerOrAnArrayOfIntegers  -1) asDirtArray.
   " the Sequencer will pe played from the dirtMidiDevice assigned to the Sequencer class"
   self dirtMessage 
		at: 's' 
		put: (Performance uniqueInstance dirtMIDIDevice). 	
	"id sequencer has no note values"
	(self dirtMessage includesKey:  'n') ifFalse: [ self dirtNotes: 0].
	^ self
	
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> midiChan: anInteger to: aKeyInPerformance [

	" for use with SuperDirt 
	convenience method to avoid extra parenthesis when assigning a midiChan to  akey in a performance"
   | p |
	p := Performance uniqueInstance.
	p at: aKeyInPerformance put: (self midiChan: anInteger).
]

{ #category : 'accessing' }
Sequencer >> midiChannel [ 

	^ midiChannel 
]

{ #category : 'accessing' }
Sequencer >> midiChannel: anIntegerBetween1And16 [

	midiChannel := anIntegerBetween1And16 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> modIndex: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the modulationIndex"

	self extra: #ModIndex values:  aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> modPitch: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the modulationPitch , i.e. the sample number of a sample player"

	self extra: #ModPitch values:  aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> modRatio: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the modulationRatio , i.e. the ratio between the frequency of the carrier and the frequency of the modlatorr"

	self extra:  #ModRatio values:  aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> mode: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the mode"

	self extra: #Mode values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'accessing' }
Sequencer >> note [

	^ self notes at: (self noteIndex modulo: self notesSize)
]

{ #category : 'accessing' }
Sequencer >> noteIndex [
	" returns the fourth array of the sequencer if there is one, otherwise returns 0.
noteIndex is used to play the folloowing note in the array. Only if there is a trig in the gates the noteIndex  will be incremented"

	^ noteIndex 
]

{ #category : 'accessing' }
Sequencer >> noteIndex: anInteger [

	" returns the fourth array of the sequencer if there is one, otherwise returns 0.
noteIndex is used to play the folloowing note in the array. Only if there is a trig in the gates the noteIndex  will be incremented"

	noteIndex := anInteger
]

{ #category : 'accessing' }
Sequencer >> notes [

	^ notes
]

{ #category : 'modifying' }
Sequencer >> notes: anArrayOfNotesOrANoteorAstring [
	" change notes in the sequencer"

	anArrayOfNotesOrANoteorAstring notesFor: self.
		
	"anArrayOfNotesOrANoteorAstring isArray
		ifTrue: [ notes := anArrayOfNotesOrANoteorAstring ]
		ifFalse: [
				anArrayOfNotesOrANoteorAstring isByteString
					ifTrue: [
					notes := anArrayOfNotesOrANoteorAstring asDirtPureNotes ]
					ifFalse: [
							notes := Array
								         new: self numberOfTrigs
								         withAll: anArrayOfNotesOrANoteorAstring ] ]"
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> notes: anArrayOfNotes index: anArrayOfIndexes to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis while declaring a sequencer of gates with its notes and its sample indexes"
	
	| p |
	p := Performance uniqueInstance.
	self to: aKeyInPerformance.
	aKeyInPerformance notes: anArrayOfNotes.
	aKeyInPerformance indexes: anArrayOfIndexes 
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> notes: anArrayOfNotes midiCh: anInteger to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis"
	
	((self notes: anArrayOfNotes ) midiChannel:  anInteger) to: aKeyInPerformance .
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> notes: anArrayOfNotes mode: anArrayOfModes to: aKeyInPerformance [ 
	"convenience mode to avoid extra parenthesis to put chord modes into sequencer - designed for polyphonic synths"
	
	(( self notes: anArrayOfNotes ) extra1: { #Mode . anArrayOfModes  } ) to: aKeyInPerformance 
]

{ #category : 'LiveCoding - sequencer' }
Sequencer >> notes: anArrayOfNotes to: aKeyInThePerformance [
	" convenience method to fill keys in performance without using too many parenthesis"

	| p |
	p := Performance uniqueInstance.
	self to: aKeyInThePerformance.
	aKeyInThePerformance notes: anArrayOfNotes.
	"for SuperDirt"
	self dirtMessage at: 'n' put: anArrayOfNotes 
]

{ #category : 'accessing' }
Sequencer >> notesSize [

	^ notes size
]

{ #category : 'counting' }
Sequencer >> numberOfGates [ 
	"return number of elements in the Sequencer gates array that are greater than 0"

	| result |
	result := (self gates) select: [ :i | i > 0 ].
	^ result size
]

{ #category : 'counting' }
Sequencer >> numberOfTrigs [
	"return number of elements in the Sequencer gates array that are greater than 0"
	
	^ (self gates select: [ :i | i > 0 ]) size
	
]

{ #category : 'Sequencer - transformation' }
Sequencer >> offset: aNumber [
	"Offsets the rhythm by aNumber of steps, rotating the sequence circularly so that elements wrap around."


<onTheFlyEssentials>
	| newArray |
	newArray := Array new: self gates size.
	1 to: self gates size do: [ :i |
		newArray
			at: (i + aNumber modulo: self gates size)
			put: (self gates at: i) ].
	self gates: newArray
]

{ #category : 'accessing' }
Sequencer >> orbit [

	^ orbit
]

{ #category : 'accessing' }
Sequencer >> orbit: anObject [

	orbit := anObject
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> pan: aFloatOrAnArray [
	" add gain pattern to the Sequencer"
	self dirtMessage 
		at: 'pan' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'accessing' }
Sequencer >> phaustGateDestination [

	^ phaustGateDestination
]

{ #category : 'accessing' }
Sequencer >> phaustGateDestination: aString [

	phaustGateDestination := aString
]

{ #category : 'accessing' }
Sequencer >> phaustNoteDestination [

	^ phaustNoteDestination
]

{ #category : 'accessing' }
Sequencer >> phaustNoteDestination: anObject [

	phaustNoteDestination := anObject
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> pitch: anIntOrAnArray [
	" add speed pattern to the Sequencer - change speed of samples playback but in chromatic way!"
   | speeds |
   speeds :=  anIntOrAnArray collect: [ :i | i semitonesToSpeed ].
	self dirtMessage 
		at: 'speed' 
		put:  speeds asDirtArray
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> pitchEnv: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify the pitchEnvelope r"

	self extra: #PitchEnv values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'sequencer - cycles' }
Sequencer >> playAsCycle [

]

{ #category : 'sequencer - cycles' }
Sequencer >> playAsCycle: aNumberOfCycles on: aMIDISender [

	"playMIDISequenceAt: aRateInSeconds steps: aNumberOfSteps on: aMIDISender"

	"test"

	" iterate over a process for self times, at a rate of aRateInMilliSeconds for step, through athe Performance containing arrays of numbers as values
keys in the Performance represents MIDI channels and must be written as #ch1 #ch2 #ch3 and so on if you want to send noteOn/off or

if you want to send out ccs
"

	| step gateTime |
	"as in early hardware sequencers, default gatetime is 80% of the step duration"
	gateTime := 0. "we dont use it for now"
	step := 0.


	^ [ 
	  aNumberOfCycles timesRepeat: [ 
		  (Delay forSeconds: (Cycle duration)
			   * (self cycleDurations at: (step modulo: self cycleDurations size)))
			  wait.

		  " test if dictionary values is an Array of two arrays or as defined, a sequence"


		  (self gates at: (step modulo: self gatesSize)) = 1 ifTrue: [ 
			  aMIDISender
				  playDrum:
				  (self notes at: (self noteIndex modulo: self notesSize))
				  onChannel: self midiChannel.
			  "advance"
			  self noteIndex: self noteIndex + 1 ].


		  step := step + 1 ] ] forkAt: Processor timingPriority
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> playDirtEventAt: anIndex [

	self subclassResponsibility 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> playFullDirtEventAt: anIndex [

	self subclassResponsibility
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> playFullDirtEventAt: anIndex delta: aRateInSeconds [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| message dur |
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := self durations asDirtArray  wrap: anIndex .
	message add: 'delta'; add: (aRateInSeconds * dur) asFloat asDirtArray . 
	dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].

	"| index sound message  delta|
	index := 'n' -> (self samplesIndex wrap: anIndex) asFloat.
	sound := 'sound' -> (self soundPattern wrap: anIndex).
	delta := 'delta' -> 0.125. change it to have changing delta values
   message := OrderedCollection new.
message addAll: { '_id' . '1' . 'cps' . 0.56 . 'delta' . 0.125 . 'orbit' . 0 . 's' . sound . 'n' . index}. "

	message asOSCMessageForSuperDirt.
	^ true 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> playFullDirtEventAt: anIndex port: aPort [

	"sends a mesaage to SuperDirt with all the desired OSC arguments and values" 
	| message dur |
	message := OrderedCollection new.
	message add: '/dirt/play'.
	dur := self durations asDirtArray  wrap: anIndex .

	message 
		add: 'delta'; 
		add: 0.123. "delta should change"
	dirtMessage keysAndValuesDo:  [ :key :value | message add: key; add: (value asDirtArray  wrap: anIndex ) ].

	"| index sound message  delta|
	index := 'n' -> (self samplesIndex wrap: anIndex) asFloat.
	sound := 'sound' -> (self soundPattern wrap: anIndex).
	delta := 'delta' -> 0.125. change it to have changing delta values
   message := OrderedCollection new.
message addAll: { '_id' . '1' . 'cps' . 0.56 . 'delta' . 0.125 . 'orbit' . 0 . 's' . sound . 'n' . index}. "

	(OSCBundle for: {  OSCMessage for: message  }  ) 
		sendToAddressString: '127.0.0.1' 
		port: aPort.
	^ true 
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> playMIDIEventAt: anIndex [

	self subclassResponsibility 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> playToDirt: aNumberOfSteps rate: aRateInSeconds [

	"play the sequencer to the SuperDirt/SuperCollider synth engine"

	| process step |
	step := 1.

	process := [ 
	           aNumberOfSteps timesRepeat: [ 
		           (Delay forSeconds: aRateInSeconds) wait.
		           (self gates wrap: step) = 1
			           ifTrue: [ 
				           self playBasicDirtEventAt: self noteIndex.
				           "increment note Index"
				           self noteIndex: self noteIndex + 1 ]
			           ifFalse: [ nil ].

		           "step is incremented anyway"
		           step := step + 1 ] ] forkAt: Processor timingPriority.

	^ process
]

{ #category : 'printing' }
Sequencer >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: ' with gates: '.
	aStream print: gates.
	aStream nextPutAll: ' with notes: '.
	aStream print: notes.
]

{ #category : 'progressions' }
Sequencer >> progression: anArrayOfIntervals [

	"return a new Sequencer that join together the original sequencer with as many transpositions of self  for as many intervals in anArrayOfIntervals"

	| oldSeq newSeq |
	oldSeq := self.
	newSeq := self.
	(1 to: anArrayOfIntervals size) do: [ :i | 
		newSeq := newSeq , (oldSeq transpose: (anArrayOfIntervals at: i)) ].
	^ newSeq
]

{ #category : 'Sequencer - transformation' }
Sequencer >> randomCounterPoint [
    "Creates a sequencer of trigs randomly placed only where self has rests (i.e., where gates = 0).
    This is a basic form of rhythmic counterpoint — avoiding overlap with the original."
<onTheFlyEssentials>
    | rand newGates |
    rand := Random new.
    newGates := self gates collect: [:g | g = 1 ifTrue: [0] ifFalse: [rand nextTrig]].
    ^  newGates asSeq

]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> randomSamplesFromFolder: aStringForAFolderOfSamples [
	"returns a random number (between 2 and 512) of indexes from the selected folder inside Dirt-Samples"
	| randIndex folder folderSize|
	randIndex := Random new nextIntegerBetween: 2 and:  512.
	folder := SuperDirt samplesFolder / aStringForAFolderOfSamples .
	folderSize := folder asFileReference allChildren size. 
	self sound: aStringForAFolderOfSamples ; dirtNotes: (randIndex  randomInts: folderSize) .
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> rate: aStringOrAnArray [
	"convenience method to avoid extra typing when we want to modify a rate parameter"

	self extra: #Rate values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> ratio: aStringOrAnArray [
	"set the ratio to a collection of value in array or to to the number"

	self extra: #Ratio values: aStringOrAnArray asDirtArrayOfValues 
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> rel: aFloatOrAnArray [
	" add release ASR envelope pattern to the Sequencer"
	self dirtMessage 
		at: 'rel' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> resonance: aStringOrAnArray [
	"set the ratio to a collection of value in array or to to the number"

	self extra: #Resonance values: aStringOrAnArray asDirtArrayOfValues
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> room: aFloatOrAnArray [
	" add room size reverb pattern to the Sequencer"
	self dirtMessage 
		at: 'room'
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'accessing' }
Sequencer >> samplesIndex [

	^ samplesIndex
]

{ #category : 'accessing' }
Sequencer >> samplesIndex: anArrayOfIntegers [

	samplesIndex := anArrayOfIntegers 
]

{ #category : 'accessing' }
Sequencer >> seqChords [

	^ seqChords
]

{ #category : 'accessing' }
Sequencer >> seqChords: anObject [

	seqChords := anObject
]

{ #category : 'accessing' }
Sequencer >> seqKey [
	^ seqKey
]

{ #category : 'accessing' }
Sequencer >> seqKey: anObject [

	seqKey := anObject
]

{ #category : 'counting' }
Sequencer >> size [
	"polysemic version of numberOfTrigs method!!!!. return the number of elements in the Sequencer gates array that are greater than 0"

	^ (self gates select: [ :i | i > 0 ]) size

]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> size: aFloatOrAnArray [
" add rdepth reverb pattern to the Sequencer"

	self dirtMessage 
		at: 'size' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> sound: soundsAndIndexs [
	"assign to a Sequencer an array with samples as string and one with samples index - intended to be used with the SuperDirt audioengine for SuperCollider for example: 
	16 downbeats sound: #('cp' 'bd:3' 'tom:4')
	
	//// what if using symbools insteda of strings?
	 
	"

	| soundsAndIndexsSeparated indexes sounds |
	soundsAndIndexsSeparated := soundsAndIndexs findBetweenSubstrings:
		                            ','.


	sounds := OrderedCollection new.
	1 to: soundsAndIndexsSeparated size do: [ :i |
			sounds add:
				(((soundsAndIndexsSeparated at: i) findBetweenSubstrings: ':')
					 at: 1) ].
	indexes := OrderedCollection new.
	(1 to: soundsAndIndexsSeparated size) do: [ :i |
			((soundsAndIndexsSeparated at: i) findBetweenSubstrings: ':') size
			> 1
				ifTrue: [
						indexes add:
							(((soundsAndIndexsSeparated at: i) findBetweenSubstrings: ':')
								 at: 2) asInteger ]
				ifFalse: [ indexes add: 0 ] ].


	self dirtMessage
		at: 's' put: sounds asDirtArray;
		at: 'n' put: indexes asDirtArray.

	self extraParams add: #index -> indexes.
	"needs refactoring"
	self soundPattern: sounds asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> sound: aString dirtNotes: anArrayfIndexes [
	"add into a Sequencer a soundPattern and notes suitable for SuperDirt"
	
	self sound: aString.
	self dirtMessage at: 'n' put:  anArrayfIndexes  asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> sound: anArrayOfStrings dirtNotes: anArrayOfMidiNN to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis" 
	
	(self sound: anArrayOfStrings dirtNotes: anArrayOfMidiNN ) to: aKeyInPerformance
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> sound: soundsAndIndexs to: aKeyInPerformance [
	"convenience method to avoid extra parenthesis"

	(self sound: soundsAndIndexs ) to: aKeyInPerformance 
]

{ #category : 'accessing' }
Sequencer >> soundPattern [

	^ soundPattern
]

{ #category : 'accessing' }
Sequencer >> soundPattern: anArrayOfStrings [

	soundPattern := anArrayOfStrings 
]

{ #category : 'accessing' }
Sequencer >> sounds: aStringForDirt [

	| soundsAndIndexs sounds indexes |
	self
		deprecated: 'Use #sound: instead'
		on: '11 May 2023'
		in:
		'Pharo-11.0.0+build.688.sha.cf3d3fd1805673a058ddf99229edb72ef062c890 (64 Bit)'.
	soundsAndIndexs := aStringForDirt findBetweenSubstrings: ' '.
	sounds := OrderedCollection new.
	(1 to: soundsAndIndexs size) do: [ :i |
		sounds add:
			(((soundsAndIndexs at: i) findBetweenSubstrings: ':') at: 1) ].
	indexes := OrderedCollection new.
	(1 to: soundsAndIndexs size) do: [ :i |
		((soundsAndIndexs at: i) findBetweenSubstrings: ':') size > 1
			ifTrue: [
				indexes add:
					(((soundsAndIndexs at: i) findBetweenSubstrings: ':') at: 2)
						asInteger ]
			ifFalse: [ indexes add: 0 ] ].

	self
		soundPattern: sounds asDirtArray;
		samplesIndex: indexes asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> speed: aFloatOrAnArray [
	" add speed size pattern to the Sequencer - change speed of samples playback"
	self dirtMessage 
		at: 'speed' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> squiz: aFloatOrAnArray [
	" add squiz distortion to the Sequencer"
	self dirtMessage 
		at: 'room' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'accessing' }
Sequencer >> stepIndex [

	self at: 4 put: self noteIndex + 1
]

{ #category : 'replication' }
Sequencer >> times: anInteger [

	"returns a sequencer containing anInteger repetition of self"

	| newGates newNotes newDurations |
	newGates := (self gates times: anInteger) asRhythm.
	newNotes := self notes times: anInteger.
	newDurations := self durations times: anInteger.



	^ SequencerMono new
		  gates: newGates;
		  notes: newNotes;
		  durations: newDurations;
		  noteIndex: 0
]

{ #category : 'LiveCoding - Performance' }
Sequencer >> to: aSymbol [
	" assign sequencer to the performance at aSymbol. if a sound for SuperDirt is not specified, the symbol is used for sound name"

	<onTheFlyEssentials>
	|  perf allItems soundfiles myInstrument sampleNames samplesForSequencer |
	

	Performance performanceType addSequencer: self to: aSymbol.

	"need cleaning and refactoring"
	perf := Performance uniqueInstance.
	perf performer class = PerformerPhausto ifTrue: [
			allItems := (((STONJSON fromString: perf activeDSP getJSON) at: #ui)
				             at: 1) at: #items.
			soundfiles := allItems select: [ :i |
				              i values includes: 'soundfile' ].

			myInstrument := perf activeDSP soundfiles select: [ :i |
				                i values includes: aSymbol ].
			myInstrument ifNotEmpty: [
					sampleNames := ((myInstrument first at: #url)
						                findBetweenSubstrings: ';') collect: [ :i |
						               (i afterLastSlash findBetweenSubstrings: '.')
							               first ].
					self soundPattern ifNotNil: [
							samplesForSequencer := self soundPattern collect: [ :i |
								                       (sampleNames indexOf: i) - 1 ].
							self index: samplesForSequencer ] ] ]
]

{ #category : 'addToPerformance' }
Sequencer >> to: aPerformance at: aKey [

	aPerformance add: aKey -> self
]

{ #category : 'printing' }
Sequencer >> trace [

	gates traceCr .
	notes traceCr.
	durations traceCr.
]

{ #category : 'accessing' }
Sequencer >> transportStep [

	^ transportStep
]

{ #category : 'accessing' }
Sequencer >> transportStep: anObject [

	transportStep := anObject
]

{ #category : 'modifying' }
Sequencer >> transpose: aNumberOfSemitones [
<onTheFlyEssentials>
	| melody |
	melody := self notes.
	^ self class new
		  gates: self gates;
		  notes: melody + aNumberOfSemitones;
		  durations: self durations;
		  noteIndex: self noteIndex
]

{ #category : 'accessing' }
Sequencer >> trigs [
	"return the number of trigs, i.e. gates = 1,  of the sequencer"
	
	| result |
	result := 0.
	(1 to: (self gates size)) do: [ :i | 
		((self gates at: i) = 1) 
			ifTrue: [ result := result + 1 ]].
	^ result.
]

{ #category : 'visualization' }
Sequencer >> visualGroup [

	^ visualGroup
]

{ #category : 'visualization' }
Sequencer >> visualGroup: aRSGroup [

	visualGroup := aRSGroup
]

{ #category : 'visualization' }
Sequencer >> visualizeOn: aRSCanvas [

	"visualize the sequencer on a Roassal canvas"

	| nIndex color red green blue border layout gatesSize minimumRadius |
	nIndex := 0. " to represent noteNumber"
	minimumRadius := self gates size.
	color := Color random.
	gatesSize := 40.
	border := red := Random new nextInteger: 255.
	green := Random new nextInteger: 255.
	blue := Random new nextInteger: 255.
	border := RSBorder new color: (Color r: red g: green b: blue).
	visualGroup := RSGroup new.
	self gates do: [ :g | 
		nIndex := nIndex + 1.
		visualGroup add: (RSCircle new
				 size:
					 3.1 * (80 - (self notes at: (nIndex modulo: self notesSize)));
				 border: border;
		
				 color: color * g) ].
	layout := RSCircleLayout new
		          radius:
			          (Random new
				           nextIntegerBetween: minimumRadius * 2 + 50
				           and: 400);
		          initialAngleInDegree: 270.
	layout on: visualGroup.
	visualGroup translateTo: 0 @ 0.
	aRSCanvas add: visualGroup asShape.
	aRSCanvas signalUpdate
]

{ #category : 'LiveCoding  - SuperDirt' }
Sequencer >> voice: aFloatOrAnArray [
	" add voice variation for SuperDirt Synths to the Sequencer"

	self dirtMessage 
		at: 'voice' 
		put:  aFloatOrAnArray   asDirtArray
]

{ #category : 'random' }
Sequencer >> withRandomNotesFrom: anArray root: aRootNote octaves: aNumber [
	"return an array of self size of a random note from anArray of note numbers with root aRootNote, and aNumber octave range"

	| intervals melody |
	intervals := (1 to: self numberOfGates) collect: [ :i | 
		             (anArray at: (Random new nextInteger: anArray size))
		             + ((Random new nextInteger: aNumber + 1) - 1 * 12) ].
	melody := intervals + aRootNote.
	self notes: melody.
	
]

{ #category : 'random' }
Sequencer >> withRandomNotesMin: anInteger max: anotherInteger [
	"return an array of self size of a random note from anArray of note numbers with root aRootNote, and aNumber octave range"

	| newNotes |
	newNotes := (1 to: self numberOfGates ) collect: [ :i | 
		            (Random new nextInteger: anotherInteger - anInteger)
		            + anInteger ].
	^ self notes: newNotes
]

{ #category : 'LiveCoding-ExtraParams' }
Sequencer >> x: aStringOrAnArray [
	"set the x value , for example in Modal Bar sytnhs"

	self extra: #X values: aStringOrAnArray asDirtArrayOfValues 
]
