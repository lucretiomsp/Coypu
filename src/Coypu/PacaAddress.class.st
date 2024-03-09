"
Dummy class to use to look for the Paca(rana) address
"
Class {
	#name : #PacaAddress,
	#superclass : #Object,
	#classInstVars : [
		'address'
	],
	#category : #'Coypu-Performance'
}

{ #category : #accessing }
PacaAddress class >> address [

	^ address
]

{ #category : #accessing }
PacaAddress class >> address: anObject [

	address := anObject
]

{ #category : #accessing }
PacaAddress class >> search [


	| serialNumber |
	serialNumber := 'beslime-51.local'.
	Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress:
			 (NetNameResolver addressForName: serialNumber)).
	address := NetNameResolver stringFromAddress:
		  (NetNameResolver addressForName: serialNumber).
	^ address
]
