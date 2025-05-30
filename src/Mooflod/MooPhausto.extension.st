Extension { #name : 'MooPhausto' }

{ #category : '*Mooflod' }
MooPhausto >> cleanRow: aNumber [

Performance uniqueInstance performanceType visualizer cleanRow: aNumber
]

{ #category : '*Mooflod' }
MooPhausto >> cutoffSweepTo: aMIDIValue in: aTimeInseconds [
	"  sweep the value of the selected parameter in a TimeInSeconds - the value is update every 10 milliseconds"

	| startValue currentValue range timeInDeciSec step numberOfSteps stepDelay incrementingProcess decrementingProcess aParamAsString aTargetValue |
	startValue := self masterCutoff .
	range := (startValue max: aMIDIValue )
	         - (startValue min: aMIDIValue ).
	timeInDeciSec := aTimeInseconds * 10.
	step := range / timeInDeciSec.
	stepDelay := Delay forSeconds: 0.1.
	numberOfSteps := timeInDeciSec.
	currentValue := startValue.
	decrementingProcess := [
	                       numberOfSteps timesRepeat: [
		                       currentValue := currentValue - step.
		                       self
			                       masterCutoff currentValue
			                      
		                       stepDelay wait ] ].
	incrementingProcess := incrementingProcess := [
	                                              numberOfSteps
		                                              timesRepeat: [
			                                              currentValue := currentValue
			                                                              +
			                                                              step.
			                                              self
				                                              setValueMooflod:
				                                              currentValue
				                                              parameter:
				                                              aParamAsString.
			                                              stepDelay wait ] ].
	startValue < aTargetValue
		ifTrue: [ incrementingProcess fork ]
		ifFalse: [ decrementingProcess fork ]
]

{ #category : '*Mooflod' }
MooPhausto >> masterCutoff [

^ masterCutoff 
]

{ #category : '*Mooflod' }
MooPhausto >> masterCutoff: aMIDIValue [

	self midiSender sendCC: 22 withValue: aMIDIValue onChannel: 15.
	Performance uniqueInstance performanceType visualizer sliderArray
		at: 'MasterCutoff'
		ifPresent: [ :slider | slider setValue: aMIDIValue ].
   masterCutoff := aMIDIValue .
]

{ #category : '*Mooflod' }
MooPhausto >> masterDelayAmount: aMIDIValue [

	self midiSender sendCC: 113 withValue: aMIDIValue onChannel: 16.
	Performance uniqueInstance performanceType visualizer sliderArray
		at: 'MasterDelay'
		ifPresent: [ :slider | slider delayAmount: aMIDIValue ].
	masterDelayAmount := aMIDIValue
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
