"
## A replayer of a savedPerformance

	- Visit a savedPerformance to get a script of a performance.
	- Can write and read ston & txt files with saved performance.
	- Can replay the script of the performance in a playground.

 ## Collaborators :
	-Visitor of a savedPerformance
	-Subclasse of PerformanceReplayer

## Public API & Key messages

	- getScript : visit a savedPerformance to get a script of commands 
	- getScriptWithRelativeTime : visit a savedPerformance to get a script with the timing of every commands since the start.
	- getScriptWithTime : visit a savedPerformance to get a script with the time at which every commands has been used.
	- replay : Open a playground with the performance in performance script.

## How to create an instance :
```
 PerformanceTextualReplayer new.
```
### Example of usage :
```
		r :=	PerformanceTextualReplayer new.
		r PerformanceRecorder uniqueInstance savedPerformance getScriptWithRelativeTime.
		r replay
```
"
Class {
	#name : #PerformanceTextualReplayer,
	#superclass : #PerformanceReplayer,
	#type : #variable,
	#category : #'CoypuRecorder-Replayer'
}

{ #category : #visiting }
PerformanceTextualReplayer >> getScript: aSavedPerformance [
	"visit a savedPerformance to get a script of commands of a savedPerformance."

	aSavedPerformance scriptForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithRelativeTime: aSavedPerformance [
"visit a savedPerformance to get a script with the timing of every commands since the start of the performance."

	aSavedPerformance scriptWithRelativeTimeForReplayer: self
]

{ #category : #visiting }
PerformanceTextualReplayer >> getScriptWithTime: aSavedPerformance [
	"visit a savedPerformance to get a script with the time at which every commands has been used."
	aSavedPerformance scriptWithTimeForReplayer: self
]

{ #category : #'read/write usage' }
PerformanceTextualReplayer >> writeScriptInStonFile [
	"Write the contents of performanceScript in a stonFile"
	self writeScriptInStonFile: 'TextualPerformance'
]

{ #category : #'read/write usage' }
PerformanceTextualReplayer >> writeScriptInTxtFile [
	"write the contents of a performanceScript in a TxtFile"
	self writeScriptInTxtFile: 'TextualPerformance'
]
