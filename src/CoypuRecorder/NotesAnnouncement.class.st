Class {
	#name : #NotesAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'notes'
	],
	#category : #'CoypuRecorder-Announcements'
}

{ #category : #accessing }
NotesAnnouncement >> notes [

	^notes
]

{ #category : #accessing }
NotesAnnouncement >> notes: aStringOfNotes [

	notes := aStringOfNotes 
]
