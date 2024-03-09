Class {
	#name : #ManifestCoypu,
	#superclass : #PackageManifest,
	#category : #'Coypu-Manifest'
}

{ #category : #'code-critics' }
ManifestCoypu class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#EsugVisual #visualizeAlanSpeech #false)) #'2022-08-05T10:59:38.794301+02:00') #(#(#RGClassDefinition #(#EsugVisual)) #'2022-08-05T10:59:46.630182+02:00') )
]

{ #category : #'code-critics' }
ManifestCoypu class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:34.471387+02:00') )
]

{ #category : #'code-critics' }
ManifestCoypu class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:48.618469+02:00') )
]

{ #category : #'code-critics' }
ManifestCoypu class >> ruleRefersToClassRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'FaderWindow class' #FaderWindow)) #'2023-08-23T14:36:52.925452+02:00') )
]

{ #category : #'code-critics' }
ManifestCoypu class >> ruleUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MIDISender #playChord:type:onChannel:duration: #false)) #'2022-06-27T11:28:11.059804+02:00') )
]
