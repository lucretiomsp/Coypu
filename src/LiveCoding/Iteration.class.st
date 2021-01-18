Class {
	#name : #Iteration,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #'as yet unclassified' }
Iteration class >> lfo: aDelay event: anEvent [

| stream |
 stream := ReadStream on: ( 0 to: 100).
]

{ #category : #'as yet unclassified' }
Iteration class >> lfo: aDelay event: anEvent times: aNumberOfTimes [

| stream |
 stream := ReadStream on: ( 0 to: 1 by: 1/100).
	^ [ aDelay wait . (((stream next) * 5) asFloat) toKyma: anEvent. (stream atEnd) ifTrue: [ stream reset ] ] loopFor: aNumberOfTimes.
]

{ #category : #'as yet unclassified' }
Iteration class >> lfo: aDelay event: anEvent values: anArray times: aNumberOfTimes [

" sistemare la questione del range dei values!!!!"

| stream min max range|
 stream := ReadStream on: ( 0 to: 1 by: 1/100).
	min := (anArray at: 1).
	max := anArray at: 2.
	range := max - min.
	^ [ aDelay wait . ((((stream next) * range) + min) asFloat) toKyma: anEvent. (stream atEnd) ifTrue: [ stream reset ] ] loopFor: aNumberOfTimes.
]

{ #category : #'as yet unclassified' }
Iteration class >> lfoSpeed: aspe [
]

{ #category : #'as yet unclassified' }
Iteration class >> lfoTest [
| lfo |

lfo := LFO new asStream.
[ 0.2 wait . Transcript show: (lfo next);cr. lfo atEnd ifTrue: [ lfo reset ] ] loopFor: 100
]

{ #category : #tests }
Iteration class >> test [ 
^ [ (Delay forSeconds: 1) wait. Transcript show: (Time now); cr ]
]

{ #category : #tests }
Iteration class >> test: aNumber [
"repeat the test process aNumber of times" 
^ [ aNumber timesRepeat: [ (Delay forSeconds: 1) wait. Transcript show: (Time now); cr ] ]
]

{ #category : #tests }
Iteration class >> test: aNumber rate: aTimeInterval [
"repeat the test process aNumber of times every aTimeInterval" 
^ [ aNumber timesRepeat: [ (Delay forSeconds: aTimeInterval) wait. Transcript show: (Time now); cr ] ]
]
