"
Tests for the rules of the melody brain (GenWeightFactor subclasses) and the note context, on C major.
"
Class {
	#name : 'GenWeightFactorsTest',
	#superclass : 'TestCase',
	#instVars : [
		'context',
		'cMajor'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'private' }
GenWeightFactorsTest >> contextAfter: someMidiNotes [

	^ GenNoteContext new
		  previousPitches: (someMidiNotes collect: [ :each | self pitch: each ]);
		  yourself
]

{ #category : 'private' }
GenWeightFactorsTest >> melodicMinorPitch: aMidi [

	^ ((GenScaleContext scaleNamed: #melodicMinor root: 0) pitchesFrom: aMidi to: aMidi) first
]

{ #category : 'private' }
GenWeightFactorsTest >> noteOnTheTonicChord [

	^ GenNoteContext new
		  chords: { cMajor };
		  barChord: cMajor;
		  yourself
]

{ #category : 'private' }
GenWeightFactorsTest >> pitch: aMidi [
	"The C major pitch for aMidi, with its scale step."

	^ (context pitchesFrom: aMidi to: aMidi) first
]

{ #category : 'running' }
GenWeightFactorsTest >> setUp [

	super setUp.
	context := GenScaleContext scaleNamed: #major root: 0.
	cMajor := context chordOnDegree: 1
]

{ #category : 'tests - pitch' }
GenWeightFactorsTest >> testAPitchMustFitEveryChordItHears [
	"G belongs to I and V; E clashes with the D of V."

	| factor both |
	factor := GenChordConsonanceFactor new.
	both := GenNoteContext new
		        chords: {
				        cMajor.
				        (context chordOnDegree: 5) };
		        yourself.
	self assert: (factor weightOf: (self pitch: 67) in: both) > ((factor weightOf: (self pitch: 64) in: both) * 2)
]

{ #category : 'tests - bass' }
GenWeightFactorsTest >> testBassLandsOnTheRootWhenTheCoinSaysSo [

	| factor note |
	factor := GenRootLandingFactor new
		          probability: 1;
		          yourself.
	note := self noteOnTheTonicChord
		        barStart: true;
		        yourself.
	self assert: (factor weightOf: (self pitch: 36) in: note) equals: 1.
	self assert: (factor weightOf: (self pitch: 43) in: note) < 0.1
]

{ #category : 'tests - bass' }
GenWeightFactorsTest >> testBassLikesRepeatsOctavesFifthsAndFourths [

	| factor note repeat octave fifth fourth third |
	factor := GenBassMotionFactor new.
	note := self contextAfter: #( 36 ).
	repeat := factor weightOf: (self pitch: 36) in: note.
	octave := factor weightOf: (self pitch: 48) in: note.
	fifth := factor weightOf: (self pitch: 43) in: note.
	fourth := factor weightOf: (self pitch: 41) in: note.
	third := factor weightOf: (self pitch: 40) in: note.
	self assert: repeat > octave.
	self assert: octave > fifth.
	self assert: fifth equals: fourth.
	self assert: fourth > third.
	self assert: (factor weightOf: (self pitch: 47) in: note) < third
]

{ #category : 'tests - pitch' }
GenWeightFactorsTest >> testChordTonesBeatAvoidNotes [

	| factor note |
	factor := GenChordConsonanceFactor new.
	note := self noteOnTheTonicChord
		        beatStrength: 1.0;
		        yourself.
	self assert: (factor weightOf: (self pitch: 64) in: note) > (factor weightOf: (self pitch: 65) in: note).
	self assert: (factor weightOf: (self pitch: 67) in: note) > (factor weightOf: (self pitch: 62) in: note)
]

{ #category : 'tests - composite' }
GenWeightFactorsTest >> testCompositeMultipliesItsFactors [

	| register motion composite note expected |
	register := GenRegisterFactor center: 60 width: 6.
	motion := GenMelodicMotionFactor new.
	composite := GenCompositeFactor withAll: {
			             register.
			             motion }.
	note := self contextAfter: #( 64 ).
	expected := (register weightOf: (self pitch: 67) in: note) * (motion weightOf: (self pitch: 67) in: note).
	self assert: ((composite weightOf: (self pitch: 67) in: note) - expected) abs < 1.0e-12
]

{ #category : 'tests - pitch' }
GenWeightFactorsTest >> testConsonanceCountsMoreOnStrongBeats [

	| factor strong weak ratioOnStrong ratioOnWeak |
	factor := GenChordConsonanceFactor new.
	strong := self noteOnTheTonicChord
		          beatStrength: 1.0;
		          yourself.
	weak := self noteOnTheTonicChord
		        beatStrength: 0.2;
		        yourself.
	ratioOnStrong := (factor weightOf: (self pitch: 67) in: strong) / (factor weightOf: (self pitch: 65) in: strong).
	ratioOnWeak := (factor weightOf: (self pitch: 67) in: weak) / (factor weightOf: (self pitch: 65) in: weak).
	self assert: ratioOnStrong > (ratioOnWeak * 5)
]

{ #category : 'tests - composite' }
GenWeightFactorsTest >> testFactorOfClass [

	| scorer |
	scorer := GenVoice lead scorer.
	self assert: (scorer factorOfClass: GenMelodicMotionFactor) class equals: GenMelodicMotionFactor.
	self assert: (scorer factorOfClass: GenBassMotionFactor) isNil
]

{ #category : 'tests - motion' }
GenWeightFactorsTest >> testFirstNoteMovesFreely [

	self assert: (GenMelodicMotionFactor new weightOf: (self pitch: 60) in: GenNoteContext new) equals: 1.
	self assert: (GenBassMotionFactor new weightOf: (self pitch: 60) in: GenNoteContext new) equals: 1
]

{ #category : 'tests - forms' }
GenWeightFactorsTest >> testFirstNoteUsesTheAscendingForm [

	| factor |
	factor := GenDirectionalFormFactor new.
	self assert: (factor weightOf: (self melodicMinorPitch: 69) in: GenNoteContext new) equals: 1.
	self assert: (factor weightOf: (self melodicMinorPitch: 68) in: GenNoteContext new) equals: 0
]

{ #category : 'tests - forms' }
GenWeightFactorsTest >> testFormsFollowTheDirection [

	| factor fromG fromC |
	factor := GenDirectionalFormFactor new.
	fromG := GenNoteContext new
		         previousPitches: { (self melodicMinorPitch: 67) };
		         yourself.
	fromC := GenNoteContext new
		         previousPitches: { (self melodicMinorPitch: 72) };
		         yourself.
	self assert: (factor weightOf: (self melodicMinorPitch: 69) in: fromG) equals: 1.
	self assert: (factor weightOf: (self melodicMinorPitch: 68) in: fromG) equals: 0.
	self assert: (factor weightOf: (self melodicMinorPitch: 70) in: fromC) equals: 1.
	self assert: (factor weightOf: (self melodicMinorPitch: 71) in: fromC) equals: 0
]

{ #category : 'tests - motion' }
GenWeightFactorsTest >> testLeapRecovery [
	"After leaping up a sixth, stepping back down to G beats stepping on up to B."

	| factor note |
	factor := GenMelodicMotionFactor new.
	note := self contextAfter: #( 60 69 ).
	self assert: (factor weightOf: (self pitch: 67) in: note) > ((factor weightOf: (self pitch: 71) in: note) * 2)
]

{ #category : 'tests - loop' }
GenWeightFactorsTest >> testLoopClosureOnlyActsOnTheLastNote [

	| note |
	note := (self contextAfter: #( 60 64 67 ))
		        lastNote: false;
		        yourself.
	self assert: (GenLoopClosureFactor new weightOf: (self pitch: 81) in: note) equals: 1
]

{ #category : 'tests - lanes' }
GenWeightFactorsTest >> testLowerVoicesPreferConsonance [

	| factor note |
	factor := GenVoiceInteractionFactor new.
	note := GenNoteContext new
		        lowerVoice: #bass pitches: { (self pitch: 48) };
		        yourself.
	self assert: (factor weightOf: (self pitch: 55) in: note) > (factor weightOf: (self pitch: 53) in: note).
	self assert: (factor weightOf: (self pitch: 55) in: note) > (factor weightOf: (self pitch: 50) in: note)
]

{ #category : 'tests - bass' }
GenWeightFactorsTest >> testNoLandingInsideTheBar [

	| factor note |
	factor := GenRootLandingFactor new
		          probability: 1;
		          yourself.
	note := self noteOnTheTonicChord
		        barStart: false;
		        yourself.
	self assert: (factor weightOf: (self pitch: 43) in: note) equals: 1
]

{ #category : 'tests - bass' }
GenWeightFactorsTest >> testNoLandingWhenTheCoinSaysNo [

	| factor note |
	factor := GenRootLandingFactor new
		          probability: 0;
		          yourself.
	note := self noteOnTheTonicChord
		        barStart: true;
		        yourself.
	self assert: (factor weightOf: (self pitch: 43) in: note) equals: 1
]

{ #category : 'tests - context' }
GenWeightFactorsTest >> testNoteContextHistory [

	self assert: (self contextAfter: #( 60 67 )) previousInterval equals: 7.
	self assert: (self contextAfter: #( 60 )) previousInterval equals: 0.
	self assert: (self contextAfter: #( 60 64 )) firstPitch midi equals: 60.
	self assert: (self contextAfter: #( 60 64 )) previousPitch midi equals: 64.
	self assert: GenNoteContext new firstPitch isNil.
	self assert: GenNoteContext new previousPitch isNil
]

{ #category : 'tests - pitch' }
GenWeightFactorsTest >> testNothingToHearIsNeutral [

	self assert: (GenChordConsonanceFactor new weightOf: (self pitch: 62) in: GenNoteContext new) equals: 1.
	self assert: (GenVoiceInteractionFactor new weightOf: (self pitch: 62) in: GenNoteContext new) equals: 1
]

{ #category : 'tests - register' }
GenWeightFactorsTest >> testRegisterIsABellAroundTheCenter [

	| factor note |
	factor := GenRegisterFactor center: 60 width: 6.
	note := GenNoteContext new.
	self assert: (factor weightOf: (self pitch: 60) in: note) equals: 1.
	self assert: (factor weightOf: (self pitch: 67) in: note) > (factor weightOf: (self pitch: 72) in: note).
	self assert: (factor weightOf: (self pitch: 55) in: note) equals: (factor weightOf: (self pitch: 65) in: note)
]

{ #category : 'tests - motion' }
GenWeightFactorsTest >> testRepeatedNotesArePenalized [

	| factor note |
	factor := GenMelodicMotionFactor new.
	note := self contextAfter: #( 64 ).
	self assert: (factor weightOf: (self pitch: 64) in: note) < (factor weightOf: (self pitch: 65) in: note)
]

{ #category : 'tests - motion' }
GenWeightFactorsTest >> testStepsBeatLeaps [

	| factor note |
	factor := GenMelodicMotionFactor new.
	note := self contextAfter: #( 64 ).
	self assert: (factor weightOf: (self pitch: 65) in: note) > (factor weightOf: (self pitch: 67) in: note).
	self assert: (factor weightOf: (self pitch: 62) in: note) > (factor weightOf: (self pitch: 72) in: note)
]

{ #category : 'tests - context' }
GenWeightFactorsTest >> testTheCoinIsFlippedOncePerNote [

	| note |
	note := GenNoteContext new
		        random: (GenScriptedRandom values: #( 0.1 0.9 ));
		        yourself.
	self assert: (note flip: #anything probability: 0.5).
	self assert: (note flip: #anything probability: 0.5).
	self deny: (note flip: #somethingElse probability: 0.5)
]

{ #category : 'tests - lanes' }
GenWeightFactorsTest >> testTheLastNoteLeadsBackToTheFirst [

	| factor note |
	factor := GenLoopClosureFactor new.
	note := (self contextAfter: #( 60 64 67 ))
		        lastNote: true;
		        yourself.
	self assert: (factor weightOf: (self pitch: 62) in: note) equals: 1.
	self assert: (factor weightOf: (self pitch: 59) in: note) equals: 1.
	self assert: (factor weightOf: (self pitch: 67) in: note) < 0.5
]

{ #category : 'tests - lanes' }
GenWeightFactorsTest >> testTheLeadAvoidsDoublingTheMid [

	| avoiding plain note |
	avoiding := GenVoiceInteractionFactor new
		            avoidDoublingWith: #( #mid );
		            yourself.
	plain := GenVoiceInteractionFactor new.
	note := GenNoteContext new
		        lowerVoice: #mid pitches: { (self pitch: 60) };
		        yourself.
	self assert: (avoiding weightOf: (self pitch: 72) in: note) < ((plain weightOf: (self pitch: 72) in: note) / 2).
	self assert: (avoiding weightOf: (self pitch: 76) in: note) equals: (plain weightOf: (self pitch: 76) in: note)
]
