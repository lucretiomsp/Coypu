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

## QUICKSTART: Play SuperDirt with Coypu ##
Coypu can be used to play the [SuperDirt](https://github.com/musikinformatik/SuperDirt) audio engine for SuperCollider. 
### Installation ###
[Download SuperCollider](https://github.com/supercollider/supercollider)
Start SuperCollider and type:
```c
include("SuperDirt");
```
evaluate this line of code by placing the cursor on it and pressing <mark>Cmd+Enter=</mark>MacOs) or <mark>Ctrl+enter</mark>(Windows).

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
Now you are ready to have fun with Pharo and Coypu; launch Pharo and open a Playground <mark>Cmd+OW</mark>
```Smalltalk
"Create a new Performance"
p := Performance uniqueInstance.
"Assign a SuperDirt Performer to the Performance"
p performer: PerformerSuperDirt new.
"If you want you can change the spee of the Performance -- don't forget the bpm !!!
p freq: 138 bpm.
```
Evaluate all these lines of code by selectimg them and pressing <mark>Cmd+D</mark>.  
Add 16 steps of rumba the lt(stand for LowTom) track of your Performance by evaluating:
```Smalltalk
16 rumba to: #conga.
```
Now let's play the Perfomance for 4 bars, by evaluating:
```Smalltalk
p playFor: 4 bars.
"of course you can play as many bars you want "
```
Now we can add a four-to-the-floor Bass Drum(bd) and a Closed High-Hat (ch) to our Performance:
```Smalltalk
16 downbeats to: #bd.
16 upbeats to: #ch.
```
and play it for 16 bars:
```Smalltalk
p playFor: 16 bars
"of course you can play as many bars you want "
```
if you want to get a list of the samples available inspect ===Cmd+i===
```Smalltalk
SuperDirt listOfSamples
```



## MIDI Support ##
Coypu can be used to play external MIDI hardware. 
(https://github.com/pharo-contributions/pharo-sound)
