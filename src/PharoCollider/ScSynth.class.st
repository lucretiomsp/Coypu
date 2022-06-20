"
Convenience methods to control scsynth server
"
Class {
	#name : #ScSynth,
	#superclass : #Object,
	#category : #PharoCollider
}

{ #category : #'as yet unclassified' }
ScSynth class >> dumpOSC [
" prints OSC messages received by the server on SUperCollider console"
(OSCMessage for: { '/d_load'  . '/Users/domenicocipriani/Library/Application Support/SuperCollider/synthdefs/sine.*' }) sendToAddressString: '127.0.0.1'  port: 57110
]
