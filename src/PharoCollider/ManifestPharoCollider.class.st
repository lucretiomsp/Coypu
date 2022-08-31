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
ManifestPharoCollider class >> ruleFloatEqualityComparisonRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PharoColliderTests #testMidiToFreq #false)) #'2022-08-30T22:33:20.933001+02:00') )
]

{ #category : #'code-critics' }
ManifestPharoCollider class >> ruleSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PharoColliderTests #testMidiToFreq #false)) #'2022-08-30T22:33:24.391456+02:00') )
]
