Class {
	#name : 'ManifestCoypu',
	#superclass : 'PackageManifest',
	#category : 'Coypu-Manifest',
	#package : 'Coypu',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestCoypu class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#EsugVisual #visualizeAlanSpeech #false)) #'2022-08-05T10:59:38.794301+02:00') #(#(#RGClassDefinition #(#EsugVisual)) #'2022-08-05T10:59:46.630182+02:00') )
]

{ #category : 'code-critics' }
ManifestCoypu class >> ruleGuardingClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:34.471387+02:00') #(#(#RGMethodDefinition #(#Sequencer #to: #false)) #'2024-07-12T17:49:44.096451+02:00') #(#(#RGMethodDefinition #(#PerfType #addSequencer:to: #false)) #'2024-07-14T13:47:37.051281+02:00') )
]

{ #category : 'code-critics' }
ManifestCoypu class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#Performance #mute: #false)) #'2022-08-06T10:51:48.618469+02:00') #(#(#RGMethodDefinition #(#Sequencer #to: #false)) #'2024-07-12T17:49:47.218135+02:00') #(#(#RGMethodDefinition #(#PerfType #addSequencer:to: #false)) #'2024-07-14T13:47:40.515243+02:00') )
]

{ #category : 'code-critics' }
ManifestCoypu class >> ruleRefersToClassRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'FaderWindow class' #FaderWindow)) #'2023-08-23T14:36:52.925452+02:00') )
]

{ #category : 'code-critics' }
ManifestCoypu class >> ruleUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MIDISender #playChord:type:onChannel:duration: #false)) #'2022-06-27T11:28:11.059804+02:00') )
]
