Class {
	#name : 'BaselineOfCoypu',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCoypu',
	#package : 'BaselineOfCoypu'
}

{ #category : 'baselines' }
BaselineOfCoypu >> baseline: spec [

	<baseline>
	spec for: #common do: [ "External dependencies"
		spec
			package: 'OSC'
			with: [ spec repository: 'github://Ducasse/OSC/src' ];
			baseline: 'Toplo'
			with: [
				spec repository: 'github://pharo-graphics/Toplo:dev/src' ];
			baseline: 'phausto' with: [spec repository: 'github://lucretiomsp/phausto/src'  ].

		"Project packages"
		spec
			package: 'Coypu' with: [ spec requires: 'OSC' ];
			package: 'CoypuRecorder' with: [ spec requires: 'Coypu' ];
			package: 'CoypuRecorder-Tests'
			with: [ spec requires: #( 'CoypuRecorder' ) ];
			package: 'CoypuRecorder_Graphics'
			with: [ spec requires: 'CoypuRecorder' ];
			package: 'CoypuRecorder_Graphics-Tests'
			with: [ spec requires: 'CoypuRecorder_Graphics' ];
			package: 'Mooflod' with: [ spec requires: 'Toplo' ] ]
]
