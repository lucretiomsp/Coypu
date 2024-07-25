"
## For the Class part:
Is a announcement called when an extra value is added to a sequencer.

## For the Responsibility part: 
- I am used when an extra value is applied to a sequencer in the goal of announcing to the PerformanceRecorder.
-  Has an instance variable which is the extra value added to the sequencer.

## For the Collaborators Part:
 PerformanceRecorder announcer.
 Sequencer extra: values:

## how to create instances :
```
ExtraValuesAnnouncement new.
```

"
Class {
	#name : 'ExtraValuesAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'extraValues'
	],
	#category : 'CoypuRecorder-Announcements',
	#package : 'CoypuRecorder',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
ExtraValuesAnnouncement >> extraValues [

	^ extraValues
]

{ #category : 'accessing' }
ExtraValuesAnnouncement >> extraValues: aSymbol [

	extraValues := aSymbol
]
