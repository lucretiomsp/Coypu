Class {
	#name : #BaselineOfCoypu,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoypu
}

{ #category : #baselines }
BaselineOfCoypu >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec package: 'OSC' with: [ spec repository: 'github://Ducasse/OSC/src' ].

		"Project packages"
		spec package: 'Coypu' with: [ spec requires: 'OSC' ].
		
		"Groups"
		spec group: 'default' with: #('Coypu') ]
]
