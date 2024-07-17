"
## An abstract class :
 visitor to a SavedPerformance to replay the script of a Performance.

## Collaborators:
Visit a savedPerformance to get a performanceScript and replay it in multiples ways.
Visit a savedPerformance.

## Public API and Key Messages

- getScript : Visit the savedPerformance to get a performanceScript
- replay : replay the performance in a playground
- writeScriptInStonFile : write the contents of performanceScript in a StonFile
- Create an instance of the subclasses instead


## Instance Variables
	performanceScript:		<OrderedCollection> an orderedCollection which contains the script of a played performance. 

"
Class {
	#name : 'PerformanceReplayer',
	#superclass : 'Object',
	#instVars : [
		'performanceScript'
	],
	#category : 'CoypuRecorder-Replayer',
	#package : 'CoypuRecorder',
	#tag : 'Replayer'
}

{ #category : 'read/write usage' }
PerformanceReplayer >> displayInTranscript [
"Display the script of the performance in the transcript"
	performanceScript do: [ :each | each traceCr ]
]

{ #category : 'visiting' }
PerformanceReplayer >> getScript: aSavedPerformance [
"Visit a SavedPerformance to get a performanceScript"
	^ self subclassResponsibility
]

{ #category : 'accessing' }
PerformanceReplayer >> performanceScript [

^	performanceScript 
]

{ #category : 'accessing' }
PerformanceReplayer >> performanceScript: anOrderedCollection [

	performanceScript := anOrderedCollection
]

{ #category : 'read/write usage' }
PerformanceReplayer >> readScriptFromStonFile: aPathToAFile [
" read a performanceScript from a aPathToAFile file and put it in performanceScript"
	| stream |
	stream := aPathToAFile asFileReference readStream.
	self performanceScript: (STON fromStream: stream)
]

{ #category : 'action' }
PerformanceReplayer >> replay [
	"Write the performanceScript script in the playground"

	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"'.
	content := content , String cr.
	content := content , ('' join: performanceScript).
	^ StPlayground openContents: content
]

{ #category : 'read/write usage' }
PerformanceReplayer >> writeScriptInStonFile [
"write the performanceScript in a stonFile"
	^ self subclassResponsibility
]

{ #category : 'read/write usage' }
PerformanceReplayer >> writeScriptInStonFile: aNameFile [
"write the performanceScript in a new ston file in the following path  home/Documents/PerformanceScripts/DateOfTheDay as aNameFile.ston"
	| x script stream |
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [ x ensureCreateDirectory ].

	script := (x / aNameFile , 'ston') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: aNameFile extension: 'ston') ].
	script := script asFileReference.
	stream := script writeStream.

	STON put: performanceScript asArray asJsonOnStreamPretty: stream.
	stream close
]

{ #category : 'read/write usage' }
PerformanceReplayer >> writeScriptInStonFile: aNameFile filePath: aFilePath [
	"write the performanceScript in a new ston file in the following path to filepath"

	| x script stream |
	x := aFilePath .


	script := (x / aNameFile , 'ston') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: aNameFile extension: 'ston') ].
	script := script asFileReference.
	stream := script writeStream.

	STON put: performanceScript asArray asJsonOnStreamPretty: stream.
	stream close
]

{ #category : 'read/write usage' }
PerformanceReplayer >> writeScriptInTxtFile [
	"write the performanceScript in a TxtFile"

	^ self subclassResponsibility
]

{ #category : 'read/write usage' }
PerformanceReplayer >> writeScriptInTxtFile: aNameFile [
	"write the performanceScript in a new txt file in the following path  home/Documents/PerformanceScripts/DateOfTheDay as aNameFile.txt"
	| x script stream |
	x := FileLocator home / 'Documents'.
	(x / 'PerformanceScripts') isDirectory ifFalse: [
		(x / 'PerformanceScripts') ensureCreateDirectory ].
	x := x / 'PerformanceScripts' / DateAndTime now asDate asString.
	x isDirectory ifFalse: [ x ensureCreateDirectory ].

	script := (x / 'TextualPerformance' , 'txt') asFileReference.
	script asFileReference isFile ifTrue: [
		script := x / (x nextNameFor: aNameFile extension: 'txt') ].

	script := script asFileReference.
	stream := script writeStream.
	performanceScript do: [ :each |
		stream
			nextPutAll: each;
			nextPutAll: String cr ].
	stream close
]
