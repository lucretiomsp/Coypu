"
Frontend for the SuperCollider language.
To be developed
"
Class {
	#name : #ManifestPharoCollider,
	#superclass : #PackageManifest,
	#category : #'PharoCollider-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoCollider class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SynthDef #graphDeprecated: #false)) #'2022-11-20T12:34:17.692187+01:00') )
]

{ #category : #'code-critics' }
ManifestPharoCollider class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SynthDef)) #'2022-11-20T12:34:22.337748+01:00') )
]

{ #category : #'code-critics' }
ManifestPharoCollider class >> ruleFloatEqualityComparisonRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PharoColliderTests #testMidiToFreq #false)) #'2022-08-30T22:33:20.933001+02:00') )
]

{ #category : #'code-critics' }
ManifestPharoCollider class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PharoColliderTests #testMidiToFreq #false)) #'2022-08-30T22:33:24.391456+02:00') )
]
