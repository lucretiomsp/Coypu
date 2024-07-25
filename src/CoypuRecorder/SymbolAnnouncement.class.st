"
## For the Class part:
represent an announcement when a symbol is given to a sequencer.
## For the Responsibility part:
 I am used when a symbol is given to a sequencer to announce it to the PerformanceRecorder.
-  Has an instance variable which is the symbol announced.
## For the Collaborators Part:
 PerformanceRecorder announcer.
## how to create instances :
```
 SymbolAnnouncement new.
```
"
Class {
	#name : 'SymbolAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'symbol'
	],
	#category : 'CoypuRecorder-Announcements',
	#package : 'CoypuRecorder',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
SymbolAnnouncement >> symbol [

	^ symbol
]

{ #category : 'accessing' }
SymbolAnnouncement >> symbol: aSymbol [

	symbol := aSymbol
]
