Class {
	#name : #ExtraValuesAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'extraValues'
	],
	#category : 'CoypuRecorder-Announcements'
}

{ #category : #accessing }
ExtraValuesAnnouncement >> extraValues [

	^ extraValues
]

{ #category : #accessing }
ExtraValuesAnnouncement >> extraValues: aSymbol [

	extraValues := aSymbol
]
