"
A test double for Performer. Records indices passed to playEventAt:in: without sending any OSC, MIDI or DSP messages. Used in PlayCyclicTest and any other test that needs to verify scheduling behavior without triggering external side effects.
"
Class {
	#name : 'MockPerformer',
	#superclass : 'Performer',
	#instVars : [
		'playedEvents'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'initialization' }
MockPerformer >> initialize [
  performance := Performance uniqueInstance .
	playedEvents := OrderedCollection new
]

{ #category : 'accessing' }
MockPerformer >> playEventAt: anIndex in: aSequencer [

	playedEvents add: anIndex
]

{ #category : 'accessing' }
MockPerformer >> playedEvents [ 
^ playedEvents 
]
