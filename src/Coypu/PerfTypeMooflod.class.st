"
I am a special type pf Performance to be used in MoogLof experiments (Music On-The-Fly with Level Of Details)
"
Class {
	#name : 'PerfTypeMooflod',
	#superclass : 'PerfType',
	#instVars : [
		'isVisualizerOpen',
		'level',
		'visualizer',
		'visualizerSpace',
		'stepVisualizer',
		'displayVisualizer',
		'perfVisualizer',
		'trackVisualizers',
		'freq'
	],
	#category : 'Coypu-Performance',
	#package : 'Coypu',
	#tag : 'Performance'
}

{ #category : 'examples' }
PerfTypeMooflod class >> example [
| code |
code := '
dsp := (Kick new + TpSampler new + PsgPlus new + Fm2Op new ) stereo asDsp.
dsp init.
dsp start.

p := Performance uniqueInstance .
p performer: PerformerPhaust new.
p performanceType: PerfTypeMooflod new .
p freq: 143 bpm.
p activeDSP: dsp.

p performanceType visualizer level: 4.

16 downbeats  to: #Kick.
''1 3 5 ~  ~ 6'' asDirtIndex to: #TpSampler.
	
16 randomNotes: #(56 67 87); to: #PsgPlus. 


p performanceType: PerfTypeMooflod.  

p performanceType visualizer level: 4.
p playFor: 128 bars.'.

^ code
]

{ #category : 'adding' }
PerfTypeMooflod >> addMasterWidgets [

	| delayW cutoffW container slider textElt |
	delayW := MfMasterDelayElement new.
	"slider := ICSlider2 new."
	delayW transformDo: [ :q | q translateBy: 300 @ 610 ].
	cutoffW := ICMasterCutoff new.
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: cutoffW.
	"container addChild: slider."
	container childrenDo: [ :child |
		child margin: (BlInsets vertical: 10) ].
	container transformDo: [ :q | q translateBy: 50 @ 610 ].
	"slider minValue: cutoffW minValue.
	slider maxValue: cutoffW maxValue.

	textElt := BlTextElement new text: slider minValue asRopedText.
	container addChild: textElt.

	slider callBack: [ :value |
		cutoffW setValue: value.
		textElt text: value asRopedText ]."
	self visualizer sliderArray at: 'MasterDelay' put: delayW.
	self visualizer sliderArray at: 'MasterCutoff' put: cutoffW.
	visualizerSpace root addChild: container.
	visualizerSpace root addChild: delayW
]

{ #category : 'adding' }
PerfTypeMooflod >> addSequencer: aSequencer to: aSymbol [

"TOO LONG, NEED REFACTORING"
	| isInKeys perf |
(	self visualizer instruments includes: aSymbol) ifTrue:
[	perf := Performance uniqueInstance.
	isInKeys := false.
	perf keysDo: [ :k |
		k = aSymbol ifTrue: [
			self visualizer level > 1 ifTrue: [
				(self visualizer patternArray at: k) forSequencer: aSequencer ].
			isInKeys := true.
			(self visualizer squareArray at: k) changeAnimationTime:
				Performance uniqueInstance freq * 4 ] ].
	isInKeys ifFalse: [
		self visualizer addInstrument: aSymbol.
		self visualizer level > 1 ifTrue: [
			(self visualizer patternArray associationAt: aSymbol) value
				forSequencer: aSequencer ].
		(self visualizer squareArray associationAt: aSymbol) value
			initializeAnimation: perf freq * 4 ].
	self visualizer level = 5 ifTrue: [ self addMasterWidgets ].
	aSequencer noteIndex: 1.
	aSequencer seqKey: aSymbol asString.
	aSequencer dirtMessage at: '_id' put: aSequencer seqKey.
	aSequencer dirtMessage at: 'orbit' put: aSequencer orbit.
	(aSequencer dirtMessage includesKey: 's')
		ifFalse: [
		aSequencer dirtMessage at: 's' put: aSymbol asString asDirtArray ]
		ifTrue: [  ].
	aSequencer seqChords
		ifNil: [ Performance uniqueInstance at: aSymbol put: aSequencer ]
		ifNotNil: [
		Performance uniqueInstance at: aSymbol put: aSequencer asPolySeq ].
	perf performer class = PerformerPhausto ifFalse: [ ^ self ].
	aSequencer phaustGateDestination: aSequencer seqKey , 'Gate'.
	aSequencer phaustNoteDestination: aSequencer seqKey , 'Note'] ifFalse: [ self inform: 'Instruments is not in MOOFLOD' ]
]

{ #category : 'accessing' }
PerfTypeMooflod >> displayVisualizer [

	^ displayVisualizer
]

{ #category : 'accessing' }
PerfTypeMooflod >> freq: aDurationInSeconds [

Performance uniqueInstance freq: aDurationInSeconds .
isVisualizerOpen ifTrue: [ 
	visualizer squareArray do: [ :s|
		s changeAnimationTime: Performance uniqueInstance freq * 4 ] .]
]

{ #category : 'initialization' }
PerfTypeMooflod >> initialize [

	super initialize.
	displayVisualizer := true.
	visualizer := MfVisualizerElement new.
	visualizerSpace := BlSpace new.
   visualizer := MfVisualizerElement new level: 5.
	stepVisualizer := MfPerformanceStepsDisplayer new.
	isVisualizerOpen := false
]

{ #category : 'accessing' }
PerfTypeMooflod >> isVisualizerOpen [

	^ isVisualizerOpen
]

{ #category : 'accessing' }
PerfTypeMooflod >> isVisualizerOpen: aBoolean [ 

isVisualizerOpen:= aBoolean 
]

{ #category : 'accessing' }
PerfTypeMooflod >> level [

	^ level
]

{ #category : 'accessing' }
PerfTypeMooflod >> level: anObject [
|perf |
	level := anObject.
		"perf := Performance uniqueInstance.
		perf keysDo: [ :k |
			perf visualizer cleanRow:
					(perf tracks indexOf: k)
					
			 ]"
]

{ #category : 'accessing - ui' }
PerfTypeMooflod >> levelOfDetail: anInteger [

	visualizer level: anInteger 
]

{ #category : 'accessing' }
PerfTypeMooflod >> openVisualizers [

	visualizerSpace root removeChildren.
	visualizerSpace := BlSpace new extent:
		                   World extent x * (5 / 12) @ World extent y.
	visualizerSpace position: 500 @ 0.
	visualizerSpace useMorphicHost.
	stepVisualizer transformDo: [ :q | q translateBy: 100 @ 0 ].
	visualizer transformDo: [ :q | q translateBy: 0 @ 60 ].
	visualizerSpace root addChild: stepVisualizer.
	visualizerSpace root addChild: visualizer.
	visualizerSpace root childrenDo: [ :child |
		child margin: (BlInsets vertical: 10) ].
	visualizerSpace position: World extent x * (10 / 12) @ 20.
	visualizerSpace toTheme: MfMooflodTheme new.
	visualizerSpace root background: (Color fromHexString: '#313339').
	visualizerSpace show
]

{ #category : 'accessing' }
PerfTypeMooflod >> perfVisualizer [

	^ perfVisualizer
]

{ #category : 'accessing' }
PerfTypeMooflod >> perfVisualizer: aPerfVisualizer [
	"assing a perfVisualzier and initialize a new Dictionary for trackVisualziers"

	perfVisualizer := aPerfVisualizer.
	self trackVisualizers: Dictionary new.
]

{ #category : 'playing' }
PerfTypeMooflod >> playFor: aNumberOfSteps [
	" reset all the Sequencers"

	"just on performance at once"

	| perf bpm performer |
	bpm := 60 / (Performance uniqueInstance freq * 4).
	perf := Performance uniqueInstance.
	performer := PerformerPhaustoMooflod new. "Mooflod"
	"Transcript
		show: 'PERFOMOOFLOD';
		open."
	perf activeProcess isTerminated ifTrue: [
		performer playFor: aNumberOfSteps ].
	self displayVisualizer ifTrue: [
		self isVisualizerOpen ifFalse: [
			stepVisualizer addSteps: perf transportStep.
			"stepVisualizer initializeAnimation: perf freq"
			self openVisualizers ].

		
		"if we want to increment steps"
		"15 / perf bpm / 60 * (aNumberOfSteps / 16)"

		visualizer initAnimation: 15 / perf bpm / 60 * (aNumberOfSteps / 16) ].
	perf resetAllSequencers
]

{ #category : 'accessing' }
PerfTypeMooflod >> playPhaustEventAt: anIndex forSequencer: aSequencer [
	"sends a message to Phausto / the DSP api must be written in a sensible way "

	| dur stepDuration assignedDsp perf |
	perf := Performance uniqueInstance.
	assignedDsp := perf activeDSP.
	stepDuration := perf freq asFloat.

	" please use also duration for gate !!! - future implementation"
	dur := aSequencer durations asDirtArray wrap: anIndex.

	aSequencer extraParams keysAndValuesDo: [ :k :v |
		assignedDsp
			setValue: (v wrap: anIndex)
			parameter: aSequencer seqKey , k asString ].

	assignedDsp
		setValue: (aSequencer notes wrap: anIndex) midiNoteToFreq
		parameter: aSequencer phaustNoteDestination. "convert note Number to Frequency"
	"as in early sequencers, standard gate time is 80% of duration"
	assignedDsp
		trig: aSequencer phaustGateDestination
		for: dur * stepDuration * 0.8.

	^ true
]

{ #category : 'accessing' }
PerfTypeMooflod >> stepVisualizer [

	^ stepVisualizer
]

{ #category : 'accessing' }
PerfTypeMooflod >> stepVisualizer: anObject [

	stepVisualizer := anObject
]

{ #category : 'accessing' }
PerfTypeMooflod >> stop [

	visualizer cleanVisualizer.
	stepVisualizer animationIsRunning: false.
	Performance uniqueInstance activeProcess terminate.
	"Performance uniqueInstance stepAdvancement terminate".
]

{ #category : 'accessing' }
PerfTypeMooflod >> trackVisualizers [

	^ trackVisualizers
]

{ #category : 'accessing' }
PerfTypeMooflod >> trackVisualizers: aDictionary [

	trackVisualizers := aDictionary
]

{ #category : 'accessing' }
PerfTypeMooflod >> visualizer [
	^visualizer 
]

{ #category : 'accessing' }
PerfTypeMooflod >> visualizer: anObject [

	visualizer := anObject
]

{ #category : 'accessing' }
PerfTypeMooflod >> visualizerSpace [

	^ visualizerSpace
]

{ #category : 'accessing' }
PerfTypeMooflod >> visualizerSpace: anObject [

	visualizerSpace := anObject
]
