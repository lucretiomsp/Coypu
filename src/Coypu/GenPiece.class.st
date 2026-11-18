"
I am what the composer answers: the scale context, the meter, the progression and the lanes, bottom voice first.

	piece := GenComposer new compose.
	piece bass midiNotes.
	piece lead stepArray.
"
Class {
	#name : 'GenPiece',
	#superclass : 'Object',
	#instVars : [
		'context',
		'meter',
		'progression',
		'lanes'
	],
	#category : 'Coypu-Generative',
	#package : 'Coypu',
	#tag : 'Generative'
}

{ #category : 'instance creation' }
GenPiece class >> context: aScaleContext meter: aMeter progression: aProgression lanes: aCollection [

	^ self new
		  setContext: aScaleContext
		  meter: aMeter
		  progression: aProgression
		  lanes: aCollection asArray;
		  yourself
]

{ #category : 'accessing' }
GenPiece >> bass [

	^ self lane: #bass
]

{ #category : 'accessing' }
GenPiece >> context [

	^ context
]

{ #category : 'accessing' }
GenPiece >> lane: aRole [

	^ lanes detect: [ :each | each role = aRole ]
]

{ #category : 'accessing' }
GenPiece >> lanes [

	^ lanes
]

{ #category : 'accessing' }
GenPiece >> lead [

	^ self lane: #lead
]

{ #category : 'accessing' }
GenPiece >> meter [

	^ meter
]

{ #category : 'accessing' }
GenPiece >> mid [

	^ self lane: #mid
]

{ #category : 'printing' }
GenPiece >> printOn: aStream [

	aStream
		print: context;
		nextPutAll: ', degrees ';
		print: progression
]

{ #category : 'accessing' }
GenPiece >> progression [

	^ progression
]

{ #category : 'accessing' }
GenPiece >> scale [

	^ context scale
]

{ #category : 'converting' }
GenPiece >> sequencers [
	"One Coypu sequencer per lane, bottom voice first."

	^ lanes collect: [ :each | each asSequencer ]
]

{ #category : 'initialization' }
GenPiece >> setContext: aScaleContext meter: aMeter progression: aProgression lanes: anArray [

	context := aScaleContext.
	meter := aMeter.
	progression := aProgression.
	lanes := anArray
]

{ #category : 'live coding' }
GenPiece >> to: someKeys [
	"Put every lane on the Performance, bottom voice first, like Sequencer>>to: (a key without a sound is used as the SuperDirt sound):
	(GenComposer new scale: #minor root: 2; compose) to: #( #superfm #superpiano #supersaw )"

	lanes with: someKeys asArray do: [ :lane :key | lane asSequencer to: key ]
]
