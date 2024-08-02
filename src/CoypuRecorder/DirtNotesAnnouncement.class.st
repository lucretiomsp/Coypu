"
## For the Class part:
Represent an announcement when a dirtNotes is applied to a sequencer.

## For the Responsibility part: 
- I am used when a dirtNotes is applied to a sequencer to announce it to the PerformanceRecorder.
-  Has an instance variable which is the value of the dirtNotes announced.

## For the Collaborators Part:
 PerformanceRecorder announcer.

## how to create instances :
```
DirtNotesAnnouncement new.
```

"
Class {
	#name : 'DirtNotesAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'newDirtNotes'
	],
	#category : 'CoypuRecorder-Announcements',
	#package : 'CoypuRecorder',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
DirtNotesAnnouncement >> newDirtNotes [

^newDirtNotes 

]

{ #category : 'accessing' }
DirtNotesAnnouncement >> newDirtNotes: aNumberInString [

newDirtNotes := aNumberInString.

]
