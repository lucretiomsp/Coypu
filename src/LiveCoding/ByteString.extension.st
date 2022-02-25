Extension { #name : #ByteString }

{ #category : #'*LiveCoding' }
ByteString >> asKymaGate [
"experimental - send a Kyma trigger"
| destination|
destination := self,'Gate'.
0 toKyma: destination. 1 toKyma: destination.

]

{ #category : #'*LiveCoding' }
ByteString >> asLocalGate [
"experimental - send a local trigger"
| destination|
destination := self,'Gate'.
0 toLocal: destination. 1 toLocal: destination.

]

{ #category : #'*LiveCoding' }
ByteString >> asPacaAddress [
"set the pacaAddress globally from the corresponding Paca(rana) serial number"

Smalltalk at: #pacaAddress put: (NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local')).
^ (NetNameResolver stringFromAddress: (NetNameResolver 	addressForName:'beslime-691.local')).
	
]

{ #category : #'*LiveCoding' }
ByteString >> pattern [ 
" convert a string with an Hexadecimal number to the Kyma array correspondong to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"
|   strings flat|

strings := (1 to: (self size)) collect: [ :i | 
((self at: i) digitValue printStringBase: 2 length: 4 padded: true ) ].
flat := strings flatCollect: [ :each | each ].
^ (( 1 to: (flat size)) collect: [ :i | (flat at: i ) digitValue ]) asRhythm .
]
