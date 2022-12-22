Extension { #name : #Array }

{ #category : #'*PharoCollider' }
Array >> asUGensGraphFunc [
	
| uggf numOfUGens |

numOfUGens := self select: [ :i | i isUGen   ].
(numOfUGens size = self size) ifTrue:
[uggf := UGensGraphFunc with: self. ^ uggf] ifFalse: [ ^ Error new signal: 'Only arrays of UGens can be converted to a UGensGraphFunc' ]
]

{ #category : #'*PharoCollider' }
Array >> sendToSCServer [
"better if literal array"
	(OSCMessage for: self)
		sendToAddressString: SCServer address
		port: SCServer port
]
