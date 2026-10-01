"
Performer for Phuck: plays Coypu sequencers on a ChucK program running in a PhuckVM.
Phuck and its libraries must be loaded into your image.

I talk to the PhuckVM stored in the Performance (activePhuckVM), set with forPhuck:.

For each event of a sequencer with key #bell I:
- set the global bellNote to the MIDI note (convert it in ChucK, e.g. Std.mtof);
- set bellGate to 1, then back to 0 after duration * freq * gateTime;
- set one global per extra parameter, e.g. bellCutoff for an extra param #Cutoff.

The ChucK program must declare these globals (global float bellNote, ...) and react to bellGate going from 0 to 1 (note on) and back to 0 (note off). Globals not declared in code run through the VM are skipped and reported with inform:.

```language=Pharo
	ck := PhuckVM uniqueInstance.
ck run: '0 => global float bellGate;
60 => global float bellNote;
TubeBell bell => dac;
0 => float lastGate;
while (samp => now) {
	Std.mtof(bellNote) => bell.freq;
	if (bellGate > 0 && lastGate <= 0) bellGate => bell.noteOn;
	if (bellGate <= 0 && lastGate > 0) 1 => bell.noteOff;
	bellGate => lastGate;
}'.

p := Performance uniqueInstance.
p forPhuck: ck.
(16 downbeats notes: '60 63 67 70') to: #bell.
p playFor: 64 bars.
```
"
Class {
	#name : 'PerformerPhuck',
	#superclass : 'Performer',
	#category : 'Coypu-Performer',
	#package : 'Coypu',
	#tag : 'Performer'
}

{ #category : 'accessing' }
PerformerPhuck >> knows: aString [
	(performance activePhuckVM globalTypeOf: aString ifAbsent: [ nil ]) ifNotNil: [ ^ true ].
	self inform: 'Phuck: no global ' , aString.
	^ false
]

{ #category : 'accessing' }
PerformerPhuck >> playCyclicFor: aNumberOfCycles [
	performance activePhuckVM ifNil: [
		^ Error signal: 'There must be an active PhuckVM for this performance' ].
	super playCyclicFor: aNumberOfCycles
]

{ #category : 'accessing' }
PerformerPhuck >> playEventAt: anIndex in: aSequencer [
	| key gateDur |
	key := aSequencer seqKey.
	gateDur := (aSequencer durations asDirtArray wrap: anIndex)
		* performance freq
		* (aSequencer gateTimes wrap: anIndex).
	aSequencer extraParams keysAndValuesDo: [ :k :v |
		self setValue: (v wrap: anIndex) parameter: key , k asString ].
	self setValue: (aSequencer notes wrap: anIndex) parameter: key , 'Note'.
	(self knows: key , 'Gate') ifTrue: [
		performance activePhuckVM trig: key , 'Gate' for: gateDur ]
]

{ #category : 'accessing' }
PerformerPhuck >> playFor: aNumberOfSteps [
	performance activePhuckVM ifNil: [
		^ Error signal: 'There must be an active PhuckVM for this performance' ].
	super playFor: aNumberOfSteps
]

{ #category : 'playing' }
PerformerPhuck >> playNoteFor: aSequencer [
	self playEventAt: aSequencer noteIndex in: aSequencer.
	aSequencer noteIndex: aSequencer noteIndex + 1
]

{ #category : 'accessing' }
PerformerPhuck >> setValue: aNumber parameter: aString [
	(self knows: aString) ifFalse: [ ^ self ].
	performance activePhuckVM setValue: aNumber parameter: aString
]
