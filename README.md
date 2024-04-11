# Coypu #

Coypu is a package with methods and classes for [Pharo](https://pharo.org) designed for programming music on-the-fly.\
It has been originally designed as a server for SymbolicSound Kyma but can be used with any OSC compatible application and external MIDI hardware. It also contains a 'string oriented syntax' heavily influenced by [TidalCycles](https://tidalcycles.org)
to interact with [SuperDirt](https://github.com/musikinformatik/SuperDirt)
The name is an homage to Kyma's Capytalk 'dialect', being the coypu a rodent as the capybara. The coypu is very common on the banks of the rivers in Veneto; everybody thinks it's a rat , but it's a rodent.  Originally from the southern part of the South American continent, introduced into Italy and then bred for fur production in the 1980s, after the end of the animal fur hype of the Yuppies' times it was made to escape from the farms instead of being killed. and it reproduced. It's a nice and peaceful animal, often adopted as a mascot from Italian hackers.

## Install the package 
```Smalltalk
Metacello new
    baseline: 'Coypu';
    repository: 'github://lucretiomsp/coypu:master';
    load
```

## Getting Started ##
Create a performance
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
Metacello new
  baseline: 'OSC';
  repository: 'github://Ducasse/OSC/src';
  load.
```


## Play SuperDirt with Coypu ##
Coypu can be used to play the [SuperDirt](https://github.com/musikinformatik/SuperDirt) audio engine for SuperCollider. 
### Installation ###
[Download SuperCollider](https://github.com/supercollider/supercollider)
Start SuperCollider and type:
```c
include("SuperDirt");
```
evaluate this line of code by placing the cursor on it and pressing ==Cmd+Enter==(MacOs) or ==Ctrl+enter== (Windows).

Download the [sc-3 plugins](https://github.com/supercollider/sc3-plugins/releases)
Unzip the release and move it to your SuperCollider extensions folder. You can find it by evaluating in SuperCollider:
```cplusplus
Platform.userExtensionDir
```
If the folder does not exist, create it yourself. You can do this in your operating system's file explorer or from within SuperCollider by evaluating:
```cplusplus
File.mkdir(Platform.userExtensionDir);
```
### Start your engines ###
Launch SuperCollider and evaluate:
```c
SuperDirt.start;
```
Now you are ready to have fun with Pharo and Coypu; launch Pharo and open a Playground ===Cmd+OW===




## MIDI Support ##
Coypu can be used to play external MIDI hardware. 
(https://github.com/pharo-contributions/pharo-sound)
