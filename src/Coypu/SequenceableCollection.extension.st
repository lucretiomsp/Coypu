Extension { #name : #SequenceableCollection }

{ #category : #'*Coypu' }
SequenceableCollection >> asOSCMessageForSuperDirt [


	| localAddress scLangPort values|
	localAddress := '127.0.0.1'.
	scLangPort := 57120.
   values := OrderedCollection new.
   values add: '/dirt/play'.
   self do: [:i | values add: i].
	
	
	(OSCMessage for: values asDirtArray ) sendToAddressString: localAddress port: scLangPort 
]
