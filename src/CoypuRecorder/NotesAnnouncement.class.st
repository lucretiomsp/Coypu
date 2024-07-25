"
## For the Class part:
Represent an announcement when notes are given to a sequencer.

## For the Responsibility part: 
- I am used when notes are given to a sequencer to announce it to the PerformanceRecorder.
-  Has an instance variable which is the notes given to the sequencer.

## For the Collaborators Part:
 PerformanceRecorder announcer.
 Sequencer notes:

## how to create instances :
```
NotesAnnouncement new.
```

"
Class {
	#name : 'NotesAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'notes'
	],
	#category : 'CoypuRecorder-Announcements',
	#package : 'CoypuRecorder',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
NotesAnnouncement >> notes [

	^notes
]

{ #category : 'accessing' }
NotesAnnouncement >> notes: aStringOfNotes [

	notes := aStringOfNotes 
]
