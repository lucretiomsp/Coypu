Extension { #name : #ByteString }

{ #category : #'*LiveCoding' }
ByteString >> pattern [ 
" convert a string with an Hexadecimal number to the Kyma array correspondong to the expression  BinaryArray ofSize: (self size) fromInteger: (self asHex)"
|   strings flat|

strings := (1 to: (self size)) collect: [ :i | 
((self at: i) digitValue printStringBase: 2 length: 4 padded: true ) ].
flat := strings flatCollect: [ :each | each ].
^ (( 1 to: (flat size)) collect: [ :i | (flat at: i ) digitValue ]) asRhythm .
]
