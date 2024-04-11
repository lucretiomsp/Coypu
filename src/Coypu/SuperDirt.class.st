"
Convenience class to interface with and get information on the SuperDirt audioEngine for SuperCollider
"
Class {
	#name : #SuperDirt,
	#superclass : #Object,
	#category : #'Coypu-SuperDirt'
}

{ #category : #'SuperDirt-List' }
SuperDirt class >> listOfDrumSynth [


| drumList  |

drumList := OrderedCollection new.
drumList add: (SuperDirtSynth name: 'superkick' parameters: #('n' 'accelerate' 'pitch1' 'decay')); add: (SuperDirtSynth name: 'super808' parameters: #('n' 'voice' 'rate')).

^ drumList 
]

{ #category : #'SuperDirt-List' }
SuperDirt class >> listOfDrums [


| drumList  |

drumList := OrderedCollection new.
drumList add: (SuperDirtSynth name: 'superkick' parameters: #('n' 'accelerate' 'pitch1' 'decay')); add: (SuperDirtSynth name: 'super808' parameters: #('n' 'voice' 'rate')).

^ drumList 
]

{ #category : #'as yet unclassified' }
SuperDirt class >> listOfSamples [

	^ SamplesFolderInspectorPresenter new
]

{ #category : #'SuperDirt-List' }
SuperDirt class >> listOfSynths [
"print on Transcript the list of SuperDirt available Synths"
| synthList  cr |
synthList := #( '##### SYNTHS #####' 'supermandolin' 'supergong' ' superpiano' 'superhex' 'supersquare'
'supersaw' 'superpwm' 'supercomparator' 'superchip' 'superfork' 'superhammond' 
'superhive' 'superzow' 'supergrind' 'superprimes' 'superwavemechanichs' 'supertron'
'superreese' 'superfm' 'supersiren' 'supernoise'
'##### DRUMS #####' 'superkick' ' super808' 'supersnare' 'superclap' ' soskick'
'soshats' 'sostoms' 'sossnare'
).


^ synthList 
]

{ #category : #'as yet unclassified' }
SuperDirt class >> listOfSynths2 [
"print on Transcript the list of SuperDirt available Synths"
| synthList  |

synthList := OrderedCollection new.
synthList add: (SuperDirtSynth name: 'supermandolin' parameters: #('sustain' 'accelerate' 'detune')); 
add: (SuperDirtSynth name: 'supergong' parameters: #('voice' 'accelerate' 'decay'));
add: (SuperDirtSynth name: 'supersquare' parameters: #('voice' 'accelerate' 'decay' 'semitone' 'resonance' 'lfo' 'rate' 'pitch1'));
add: (SuperDirtSynth name: 'supersaw' parameters: #('voice' 'accelerate' 'decay' 'semitone' 'resonance' 'lfo' 'rate' 'pitch1'));
add: (SuperDirtSynth name: 'superpwm' parameters: #('voice' 'accelerate' 'decay' 'semitone' 'resonance' 'lfo' 'rate' 'pitch1'));
add: (SuperDirtSynth name: 'superchip' parameters: #('voice' 'slide' 'accelerate' 'rate' 'pitch2' 'pitch3' ));
add: (SuperDirtSynth name: 'superhoover' parameters: #('decay' 'accelerate' 'slide'));
add: (SuperDirtSynth name: 'superzow' parameters: #('decay' 'accelerate' 'slide' 'detune'));
add: (SuperDirtSynth name: 'supertron' parameters: #('voice' 'accelerate' 'detune'));
add: (SuperDirtSynth name: 'superreese' parameters: #('voice' 'accelerate' 'detune'));
add: (SuperDirtSynth name: 'superstatic' parameters: #('voice' 'accelerate' 'pitch1' 'slide' 'resonance'));
add: (SuperDirtSynth name: 'supercomparator' parameters: #('voice' 'decya' 'accelerate' 'lfo' 'rate' 'pitch1' 'slide' 'resonance'))

.







^ synthList 
]

{ #category : #'as yet unclassified' }
SuperDirt class >> openListOfSynths [

	| instrumentsTable drumsTable presenter |
	instrumentsTable := SpTablePresenter new.
	instrumentsTable
		items: self listOfSynths2;
		addColumn:
			(SpStringTableColumn title: 'synth' evaluated: [ :e | e name ]);
		addColumn: (SpStringTableColumn
				 title: 'parameters'
				 evaluated: [ :e | e parameters joinUsing: ' ' ]).

	drumsTable := SpTablePresenter new.
	drumsTable
		items: self listOfDrums;
		addColumn:
			(SpStringTableColumn title: 'drums' evaluated: [ :e | e name ]);
		addColumn: (SpStringTableColumn
				 title: 'parameters'
				 evaluated: [ :e | e parameters joinUsing: ' ' ]).
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
			 add: instrumentsTable;
			 add: drumsTable;
			 yourself).
	(presenter open) title: 'ListOfSynths'; extent: 600@400.
	^ presenter
]

{ #category : #'as yet unclassified' }
SuperDirt class >> samplesFolder [
 "return the path to the folder where the superdirt samples are located"
| home folder |
home := FileLocator home.
folder := (home / 'Library') / 'Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/'.
^ folder 
]
