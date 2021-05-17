"
A Scale is an Array of Musical Intervals in Number of Seminotes.
Sending the name of the desired Scale to the Scale class returns the desired class
"
Class {
	#name : #Scale,
	#superclass : #Array,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #creating }
Scale class >> major [ 

^ #(0 2 4 5 7 9 11 12 14 17 21).
]

{ #category : #creating }
Scale class >> minor [ 

^ #(0 2 3 5 7 8 10 12 13 17 20)
]

{ #category : #creating }
Scale class >> pentaMajor [
^ #(0 2 4 7 9 12)
]

{ #category : #creating }
Scale class >> pentaMinor [
^ #(0 3 5 7 10 12)
]
