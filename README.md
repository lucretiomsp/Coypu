# PharoLiveCoding
Package of convenient methods and classes for Pharo designed for live coding performances using Kyma or other musica languages by sending OSC messages in an economic, iconic and transparent way.
It has been originally designed to work with SymbolicSound Kyma but can be used with any OSC compatible application.
<br>
##########################
<br>
BASIC USAGE
<br>
Integers and arrays implements the messages
<br>
toKyma: 'anOSCaddressWithoutTheFirstSlash'
<br>
and
<br>
toLocal: 'anOSCaddressWithoutTheFirstSlash'
<br>
when arrays are sent, each index of the array will be sent to the corresponding OSCAddress suffixed with the array index.



<br>
OSC package versions stable 1.0 must be available in your Pharo image.
<br>
You can get it with this Metacello script (just copy and paste it into your Playground) 
<br>
Metacello script
<br>
Metacello new
	smalltalkhubUser: 'Pharo' project: 'MetaRepoForPharo50';
	configuration: 'OSC';
	version: #stable;
	load. during: 
