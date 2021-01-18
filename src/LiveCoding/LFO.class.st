"
in development stage LFO.
"
Class {
	#name : #LFO,
	#superclass : #Object,
	#instVars : [
		'internalStream'
	],
	#category : #LiveCoding
}

{ #category : #accessing }
LFO >> asStream [
^ internalStream .
]

{ #category : #initialization }
LFO >> initialize [ 
" create the lfo as a stream"
internalStream := ReadStream on: ( 0 to: 100).

 " TO UNDERSTAN BEHAVIOR 
| can |
can := LFO new internalStream .
[  120 bpm bars: 0.3. Transcript show: (can next); cr ] loopFor: 101
"
]

{ #category : #accessing }
LFO >> internalStream [
^ internalStream .
]
