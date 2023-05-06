# Pharo LiveCoding Package #

Experimental Package of convenient methods and classes for Pharo designed for live coding performances using Kyma
or other musica languages by sending OSC messages in an economic, iconic and transparent way.
It has been originally designed to work with SymbolicSound Kyma but can be used with any OSC compatible application.

## Basic usage ##

Integers and arrays implements the messages
toKyma: 'anOSCaddressWithoutTheFirstSlash'
and
toLocal: 'anOSCaddressWithoutTheFirstSlash'
when arrays are sent, each index of the array will be sent to the corresponding OSCAddress suffixed with the array index.

### Requirements ###

OSC package versions stable 1.0 must be available in your Pharo image.
You can get it with this Metacello script (just copy and paste it into your Playground)

Metacello new baseline: 'OSC'; repository: 'github://Ducasse/OSC/src'; load.
