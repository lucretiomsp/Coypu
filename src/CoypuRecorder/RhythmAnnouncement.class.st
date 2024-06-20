"
## For the Class part:
represent an announcement when a rythm is given to a sequencer.

## For the Responsibility part:
I am used when a rythm is given to a sequencer to announce it to the PerformanceRecorder.
-  Has an instance variable rythm which is the rythm announced.

## For the Collaborators Part:
PerformanceRecorder announcer.


## how to create instances :
``` 
RythmAnnouncement new.
```
"
Class {
	#name : 'RhythmAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'rythm'
	],
	#category : 'CoypuRecorder-Announcements',
	#package : 'CoypuRecorder',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
RhythmAnnouncement >> rhythm [

	^ rythm
]

{ #category : 'accessing' }
RhythmAnnouncement >> rhythm: aRythm [

	rythm := aRythm
]
