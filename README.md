# PharoLiveCoding
Package of convenient methods and classes for Pharo designed for live coding performances using Kyma or other musica languages by sending OSC messages in an economic, iconic and transparent way.
It has been originally designed to work with SymbolicSound Kyma but can be used with any OSC compatible application.
##########################
BASIC USAGE
Integers and arrays understand the messages 
toKyma: 'anOSCaddress'



OSC package versions stable 1.0 must be available in your Pharo image.
You can get it with this Metacello script (just copy and paste it into your Playground) 

Metacello script
Metacello new
	smalltalkhubUser: 'Pharo' project: 'MetaRepoForPharo50';
	configuration: 'OSC';
	version: #stable;
	load. during: 
