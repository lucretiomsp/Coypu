# Pharo LiveCoding Package #

Experimental Package of convenient methods and classes for Pharo designed for live coding performances using Kyma
or other musica languages by sending OSC messages in an economic, iconic and transparent way.
It has been originally designed to work with SymbolicSound Kyma but can be used with any OSC compatible application.

## Getting Started ##
Create a performance\
```Smalltalk
p := Performance uniqueInstance.
```
assign a Performer to the Performance (PerformerLocal or PerformerKyma or PerformerMIDI or PerformerSuperDirt)
```Smalltalk
p performer: aPerformerSubClass new
```
add sequencers to the performance
```Smalltalk
16 rumba to: #snare
```
or
```Smalltalk
16 semiquavers to: #hats; midich: 7
```

play the performance
```Smalltalk
 p play
```
if you want to stop your performance\
```Smalltalk
p terminate
```

### Basic usage ###
The default OSC send port is 57120, the same of SuperCollider audio server.

Integers and arrays implements the messages\
```Smalltalk
9 toKyma: 'anOSCaddressWithoutTheFirstSlash'
```
and\
``` Smalltalk
8 toLocal: 'anOSCaddressWithoutTheFirstSlash'
```
when arrays are sent, each index of the array will be sent to the corresponding OSCAddress suffixed with the array index.

#### Requirements ####

OSC package versions stable 1.0 must be available in your Pharo image. 
You can get it with this Metacello script (just copy and paste it into your Playground)

``` Smalltalk
Metacello new baseline: 'OSC'; repository: 'github://Ducasse/OSC/src'; load.
```
## MIDI Support ##
The Pharo LiveCoding Package can be used to play external MIDI hardware. 
[pharo-sound] (https://github.com/pharo-contributions/pharo-sound)

## SuperDirt Connection ##
The Pharo LiveCoding Package can be used to play the SuperDirt audio engine for SuperCollider. 
[install SuperDirt ] (https://github.com/musikinformatik/SuperDirt)
