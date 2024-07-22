"
### A replayer of a savedPerformance

	- Visit a savedPerformance to get a script of a performance.
	- Can write and read ston & txt files with saved performance.
	- Can replay the script of the performance in a playground with the same timing as the original.

## Collaborators :
	-Visitor of a savedPerformance
	-Subclasse of PerformanceReplayer

## Public API & Key messages

	- getScript : visit a savedPerformance to get a script with the delays between each commands 
	- replay : Open a playground with the performance in performance script that can redo the 	performance with the same timings.
		
## How to create an instance :
```
 PerformanceMusicalReplayer new.
```
### Example :
```
		r :=	PerformanceMusicalReplayer new.
		r PerformanceRecorder uniqueInstance savedPerformance getScript.
		r replay
```
"
Class {
	#name : 'PerformanceMusicalReplayer',
	#superclass : 'PerformanceReplayer',
	#type : 'variable',
	#category : 'CoypuRecorder-Replayer',
	#package : 'CoypuRecorder',
	#tag : 'Replayer'
}

{ #category : 'visiting' }
PerformanceMusicalReplayer >> getScript: aSavedPerformance [
"Visit a savedPerformance to get a script that can be replayed"
	aSavedPerformance scriptWithDelayTimeForReplayer: self
]

{ #category : 'initialization' }
PerformanceMusicalReplayer >> initialize [
super initialize
	"stop := false"
]

{ #category : 'action' }
PerformanceMusicalReplayer >> replayWithoutPlayground [

	| x |
	x := String streamContents: [ :s |
		     performanceScript do: [ :each |
			     s
				     nextPutAll: each asString;
				     nextPutAll: String cr ] ].
	[ Object readFromString: x ] forkAt: 40
]

{ #category : 'read/write usage' }
PerformanceMusicalReplayer >> writeScriptInStonFile [
"Write the contents of performanceScript in a stonFile"
	self writeScriptInStonFile: 'ReplayablePerformance'
]

{ #category : 'read/write usage' }
PerformanceMusicalReplayer >> writeScriptInTxtFile [
"write the contents of a performanceScript in a TxtFile"
	self writeScriptInTxtFile: 'ReplayablePerformance'
]
