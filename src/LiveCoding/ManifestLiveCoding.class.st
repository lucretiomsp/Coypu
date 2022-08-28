"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
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
