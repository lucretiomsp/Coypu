"
Dummy class to use to look for the Paca(rana) address
"
Class {
	#name : #PacaAdddress,
	#superclass : #Object,
	#category : #'LiveCoding-Performance'
}

{ #category : #accessing }
PacaAdddress class >> search [


	| serialNumber |
	serialNumber := 'beslime-51.local'.
	Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress:
			 (NetNameResolver addressForName: serialNumber)).
	^ NetNameResolver stringFromAddress:
		  (NetNameResolver addressForName: serialNumber)
]
