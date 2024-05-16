Extension { #name : #Sequencer }

{ #category : #'*CoypuRecorder' }
Sequencer >> to: aSymbol atTime: aTime [
	" call the message to with a delay"

	| announcement |
	announcement := DelayAnnouncement new.
	announcement delay: aTime.
	PerformanceRecorder uniqueInstance announce: announcement.
	(Delay forSeconds: aTime) wait.
	self to: aSymbol
]
