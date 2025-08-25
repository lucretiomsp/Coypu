Class {
	#name : 'MfCodeToken',
	#superclass : 'Object',
	#instVars : [
		'string'
	],
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
}

{ #category : 'instance creation' }
MfCodeToken class >> fromString: aString [

	"(aString includes: $#)
		ifTrue: [ ^ MfSymbolToken new string: aString ]
		ifFalse: [
				('\d+' asRegex matches: aString)
					ifTrue: [ ^ MfNumberToken new string: aString ]
					ifFalse: [
							(aString includes: $#)
								ifTrue: [ ^ MfSymbolToken new string: aString ]
								ifFalse: [
										aString isQuotedString
											ifTrue: [ ^ MfQUotedString new string: aString ]
											ifFalse: [ ^ self new string: aString ] ] ] ]"
								(aString includes: $#) ifTrue: [ 
        ^ MfSymbolToken new string: aString ].

    ('\d+' asRegex matches: aString) ifTrue: [ 
        ^ MfNumberToken new string: aString ].

    aString isQuotedString ifTrue: [ 
        ^ MfQUotedString new string: aString ].

    ^ self new string: aString
]

{ #category : 'accessing' }
MfCodeToken >> color [

^ Color white
]

{ #category : 'accessing' }
MfCodeToken >> string: aString [

string := aString 

	
]
