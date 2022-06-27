"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLiveCoding,
	#superclass : #PackageManifest,
	#category : #'LiveCoding-Manifest'
}

{ #category : #'code-critics' }
ManifestLiveCoding class >> ruleUnoptimizedToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MIDISender #playChord:type:onChannel:duration: #false)) #'2022-06-27T11:28:11.059804+02:00') )
]
