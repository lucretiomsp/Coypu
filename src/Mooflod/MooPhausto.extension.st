Extension { #name : 'MooPhausto' }

{ #category : '*Mooflod' }
MooPhausto >> cleanRow: aNumber [

Performance uniqueInstance performanceType visualizer cleanRow: aNumber
]

{ #category : '*Mooflod' }
MooPhausto >> masterCutoff: aMIDIValue [

	self midiSender sendCC: 22 withValue: aMIDIValue onChannel: 15.
	Performance uniqueInstance performanceType visualizer sliderArray
				at: 'MasterCutoff'
				ifPresent: [ :slider | slider setValue: aMIDIValue ] 
]

{ #category : '*Mooflod' }
MooPhausto >> masterDelayAmount: aMIDIValue [

	self midiSender sendCC: 113 withValue: aMIDIValue onChannel: 16.
	Performance uniqueInstance performanceType visualizer sliderArray
		at: 'MasterDelay'
		ifPresent: [ :slider | slider delayAmount: aMIDIValue ]
]

{ #category : '*Mooflod' }
MooPhausto >> masterDelayFeedback: aMIDIValue [

	self midiSender sendCC: 110 withValue: aMIDIValue onChannel: 16
]

{ #category : '*Mooflod' }
MooPhausto >> masterDelayTime: aMIDIValue [

	self midiSender sendCC: 107 withValue: aMIDIValue onChannel: 16.
		Performance uniqueInstance performanceType visualizer sliderArray
		at: 'MasterDelay'
		ifPresent: [ :slider | slider delayTime: aMIDIValue ]
]

{ #category : '*Mooflod' }
MooPhausto >> masterFilterType: aFilterType [

	| filterTypes filterType |
	filterTypes := Dictionary new.
	filterTypes
		add: #lp -> 1;
		add: #bp -> 5;
		add: #hp -> 9.
	filterType := filterTypes at: aFilterType ifAbsent: 1.
	self midiSender sendCC: 30 withValue: filterType onChannel: 15
]

{ #category : '*Mooflod' }
MooPhausto >> masterResonance: aMIDIValue [

	self midiSender sendCC: 23 withValue: aMIDIValue onChannel: 15.
	Performance uniqueInstance performanceType visualizer sliderArray
		at: 'MasterCutoff'
		ifPresent: [ :slider | slider resonance: aMIDIValue ]

]

{ #category : '*Mooflod' }
MooPhausto >> midiSender [

	^ midiSender
]

{ #category : '*Mooflod' }
MooPhausto >> midiSender: aMIDISender [

	midiSender := aMIDISender 
]
