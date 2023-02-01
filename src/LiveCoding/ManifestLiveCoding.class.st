"
Performances are dictionaries contains Sequencers and are intended to be the complete ""live-score"" for the LiveCoding execution, and with the ""play"" methodss
they become Processes with the highest priority that send out OSC or MIDI messages.


Performances can be changed in real time.

If a Key of a Performance contains 'midi' + anIntegerBetween1And16 (for example #midi7), the corresponding sequencer will be assigned to the midiChannel of anIntegerBetween1And16 .

"
Class {
	#name : #ManifestLiveCoding,
	#superclass : #PackageManifest,
	#category : #'LiveCoding-Manifest'
}

{ #category : #'code-critics' }
ManifestLiveCoding class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#EsugVisual #visualizeAlanSpeech #false)) #'2022-08-05T10:59:38.794301+02:00') #(#(#RGClassDefinition #(#EsugVisual)) #'2022-08-05T10:59:46.630182+02:00') )
]

{ #category : #'code-critics' }
ManifestLiveCoding class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:34.471387+02:00') )
]

{ #category : #'code-critics' }
ManifestLiveCoding class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:48.618469+02:00') )
]

{ #category : #'code-critics' }
ManifestLiveCoding class >> ruleUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MIDISender #playChord:type:onChannel:duration: #false)) #'2022-06-27T11:28:11.059804+02:00') )
]
