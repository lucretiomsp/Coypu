"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestCoypuRecorder',
	#superclass : 'PackageManifest',
	#category : 'CoypuRecorder-Manifest',
	#package : 'CoypuRecorder',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestCoypuRecorder class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ReplayerExamples #displayPerformanceInTranscript #false)) #'2024-04-29T10:08:42.546234+02:00') )
]
