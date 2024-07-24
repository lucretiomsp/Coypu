Extension { #name : #Sequencer }

{ #category : #'*CoypuRecorder' }
Sequencer >> to: aSymbol atTime: aDelayinMilliseconds [
	" call the message to with a delay"

	| announcement |
	announcement := DelayAnnouncement new.
	announcement delay: aDelayinMilliseconds.
	PerformanceRecorder uniqueInstance announce: announcement.
	(Delay forMilliseconds: aDelayinMilliseconds) wait.
	self to: aSymbol
]
