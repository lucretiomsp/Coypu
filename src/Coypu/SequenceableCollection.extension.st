Extension { #name : 'SequenceableCollection' }

{ #category : '*Coypu' }
SequenceableCollection >> asOSCMessageForSuperDirt [


	| localAddress scLangPort values|
	localAddress := '127.0.0.1'.
	scLangPort := 57120.
   values := OrderedCollection new.
   values add: '/dirt/play'.
   self do: [:i | values add: i].
	
	
	(OSCMessage for: values asDirtArray ) sendToAddressString: localAddress port: scLangPort 
]

{ #category : '*Coypu' }
SequenceableCollection >> wrap: anInteger [

	"inspire by Cmajor language wrap<int> always wrap the index of the array to the array size"

	| result |
	result := self at: anInteger - 1 % self size + 1.
	^ result
]
