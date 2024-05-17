"
## For the Class part:
Represent an announcement when a delay is applied to a time of a RecordedCommand ( Only used when trying to record a replay).

## For the Responsibility part: 
- I am used when a replay is recorded to announce it to the PerformanceRecorder.
-  Has an instance variable which is the value of the delay.

## For the Collaborators Part:
 PerformanceRecorder announcer.

## how to create instances :
```
DelayAnnouncement new.
```

"
Class {
	#name : #DelayAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'delay'
	],
	#category : #'CoypuRecorder-Announcements'
}

{ #category : #accessing }
DelayAnnouncement >> delay [

^delay
]

{ #category : #accessing }
DelayAnnouncement >> delay: anInteger [

	delay := anInteger
]
