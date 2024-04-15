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
