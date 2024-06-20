Class {
	#name : 'MidiMessageParseTest',
	#superclass : 'TestCase',
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'tests' }
MidiMessageParseTest >> testIsVoiceMessage [

	self assert: 16r90 isVoiceMessage
]
