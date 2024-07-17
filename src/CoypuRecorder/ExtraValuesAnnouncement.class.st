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
