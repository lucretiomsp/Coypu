"
""A performance is a Dictionary subclass used for live coding package""
"
Class {
	#name : #Performance,
	#superclass : #Dictionary,
	#type : #variable,
	#category : #LiveCoding
}

{ #category : #'as yet unclassified' }
Performance >> mute: anArrayOfKeys [
"remove all the keys in the arrayOfKeys from the Performance"
anArrayOfKeys do: [ :i | self removeKey: i ifAbsent: [ ] ] 
]
