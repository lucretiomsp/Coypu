"
in development.
the Loop class is a Process subclass used to re-iterate aProcess fro a number of Times.
"
Class {
	#name : #Loop,
	#superclass : #Process,
	#category : #LiveCoding
}

{ #category : #tests }
Loop class >> test [ 

^ [  10 timesRepeat: [ (Delay forSeconds: 0.6) wait. Transcript show: (Time now); cr ] ] fork
]

{ #category : #tests }
Loop class >> test: aNumber rate: aTimeInterval [
"answer a process repeated for aNumber of times at aTimeInterval" 
	| x |
	x := 0.
^ [  aNumber timesRepeat: [ (Delay forSeconds: aTimeInterval) wait. Transcript show: 		x; cr. x := x + 1 ] ] fork
]

{ #category : #tests }
Loop class >> test: aNumber rate: aTimeInterval event: anEvent [
	"answer a process repeated for aNumber of times at aTimeInterval"

	| x| x := 0.
	^ [ aNumber
		timesRepeat: [ (Delay forSeconds: aTimeInterval) wait.
			x toKyma: anEvent. x := x + 0.1.
				 ] ] fork
]
