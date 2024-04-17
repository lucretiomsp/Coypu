"
A collection of examples for the PerformerSuperDirt.
To follow these examples you need to install SuperCollider and SuperDirt and have SuperDirt running.
Check installation here:
https://github.com/lucretiomsp/Coypu
"
Class {
	#name : #SuperDirtExamples,
	#superclass : #Object,
	#category : #'Coypu-Examples'
}

{ #category : #'examples - simple' }
SuperDirtExamples >> dirtNotes101 [

	<script: ' self new dirtNotes101'>
	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"

"we assing the PerformerSuperDirt to the uniqueInstance of Performance"
p := Performance uniqueInstance .
p performer: PerformerSuperDirt new. 

" set the speed of the performance"
p freq: 128 bpm.

"in SuperDirt there are many synthesizer available that you can reach if you assign a sequender to a key corresponding to the name of the synth - you can get a list of the synths by inspecting"
SuperDirt listOfSynths. 

"let create a timeline of claps to have a rhythmic reference"
16 downbeats to: #cp.
"lets play the claps very quick"
p playFor: 4  bars.

" there is a syntax to create melodies sending asDirtNotes message to a string containing a list of numbers where 0 is c4, 1 is c#4, 2 is d4, -12 is c3 , 14 is d5 and so on ."
'' 0 3 7 10 12 -10 '' asDirtNotes to: #superchip.
"play a nice arpeggio for 8 bars , all notes are tirggered"


p playFor: 8  bars.

"if you want to insert a rest, you place a tilde instead of a number"
'' 0 ~ ~ 3 -12 4 ~ ~ 7 ~ 11''  asDirtNotes to: #superchip.
p playFor: 8  bars.

"but you can also multiply notes or rests , but you have to insert COMMAS between the entries"
''-12*6 , ~ , 5 * 2 , ~ , 2 *5 , ~*2'' asDirtNotes to: #superchip.
p playFor: 8  bars.

"lets mute the superchip"
p mute: #superchip .
"or you can make notes or rests last longer by using / followed by a number of steps. reme,ber to separate entries with COMMAS and remember that Coypu works at 1/16th resolution (https://en.wikipedia.org/wiki/Sixteenth_note)"

'' 4 / 16 ,  6 / 16 , 7 /16 , 9 /16'' asDirtNotes  to: #supersaw.
p playFor: 16 bars.


" you can achievee the same result by creating a sequencer and then assigning the notes - the semicolon is very important, you are cascading messages"
4 semibreves dirtNotes: ''4 6 7 9''; to: #supersaw .
p playFor: 16 bars.

"lets mute the supersaw to listen another trick"
p mute: #supersaw.
"the number of trigs (the notes inside a sequencer that are played) can be different from the number of notes - and this yields very interesting stuff"
#(7 16) euclidean dirtNotes: ''-10 9 5 -2''; to: #superhex.
p playFor: 16 bars.


'.

	^ StPlayground openContents: content
]

{ #category : #'examples - simple' }
SuperDirtExamples >> techno101 [

	<script: ' self new techno101'>
	| content |
	content := '
"###########################################################################"

"OPEN SUPERCOLLIDER"
"TYPE: SuperDirt.start;"
"EVALUATE IT - CMD+ENTER"
"###########################################################################"

"we assing the PerformerSuperDirt to the uniqueInstance of Performance"
p := Performance uniqueInstance .
p performer: PerformerSuperDirt new. 

p freq: 138 bpm. 

"we start with Bass Drum and an Hi-Hat"
"WHEN YOU DONT SPECIFY WHICH SOUND YOU WANT TO PLAY, YOU PLAY THE FIRST SAMPLE INTO THE DIRT SAMPLES SUBFOLDER NAMED AS THE SYMBOL - THAT THEREFORE MUST EXISTS, OTHERWISE YOU WILL GET AN RROR MESSAGE IN THE SUPER COLLIDER CONSOLE"
16 downbeats to: #bd.
16 upbeats to: #hh; dirtNotes: ''4''.	


" lets play the Performance!"
p playFor: 512 bars.

"we add a guncky Clap(cp) with an hexbeat"
"place a link about hexbeat"
''080808080809'' hexBeat to: #cp.	

"let it play for a couple of bars and the we add a mix of Toms sending asDirtNotes to a string"
''lt ~ ~ mt ~ ~ ht ~ lt ~ mt ~ ~ ~'' asDirtSounds to: #toms.

"wait some bars and then add an euclidean rhyth made of blips /you can learn more Euclidean rhytms here: https://en.wikipedia.org/wiki/Euclidean_rhythm"
#(3 16) euclidean to: #blip.

"wait a bit and enjoy your funky rhythm then solo the blips"
p solo: #blip.

"now we are ready for a simple subidón with some rollimg cans"
16 semiquavers to: #can.

"and when all the hands are up in the air - you are ready to get back to your minimalist main theme"
p unsolo: #blip.

"let it go for a few bars then we can mute the toms "

p mute: #toms.

" and then add a simple bassline sending asDirtNotes to a string with numbers"



''0 1 2 3 12'' asDirtNotes to: #bass3.

"let it go for a while and then finish with a solo-ed bassline"
p solo: #bass3.


"you can stop the sequencer when you want"
p stop.
'.

	^ StPlayground openContents: content
]
