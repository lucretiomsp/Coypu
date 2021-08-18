Extension { #name : #GPoint }

{ #category : #'*LiveCoding' }
GPoint >> toLocal: aString [
" send 2 floats to the address of aString"
|  localAddress |
	localAddress := '127.0.0.1'. 

	
	(OSCMessage for: { ('/', aString)  . ((self x )asFloat).  ((self y )asFloat) }) sendToAddressString: localAddress  port: 8000.
]
