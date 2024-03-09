"
Modeled on the typical Digital Audio Workstation transport, controls the playback of the Performance
"
Class {
	#name : #Transport,
	#superclass : #Object,
	#instVars : [
		'isRunning',
		'position'
	],
	#category : #'Coypu-Performance'
}

{ #category : #accessing }
Transport >> increment [ 
position := position + 1.
^ position
]

{ #category : #initialization }
Transport >> initialize [ 
super initialize .
self position: 0.
self isRunning: false. 
]

{ #category : #accessing }
Transport >> isRunning [

	^ isRunning
]

{ #category : #accessing }
Transport >> isRunning: aBoolean [
"if true, the Transport is running"
	isRunning := aBoolean
]

{ #category : #accessing }
Transport >> position [

	^ position
]

{ #category : #accessing }
Transport >> position: anObject [

	position := anObject
]

{ #category : #initialization }
Transport >> reset [
self position: 0.
]
