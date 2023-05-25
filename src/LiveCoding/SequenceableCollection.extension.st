Extension { #name : #SequenceableCollection }

{ #category : #'*LiveCoding' }
SequenceableCollection >> asOSCMessageForSuperDirt [


	| localAddress scLangPort values|
	localAddress := '127.0.0.1'.
	scLangPort := 57120.
   values := OrderedCollection new.
   values add: '/dirt/play'.
   self do: [:i | values add: i].
	
	
	(OSCMessage for: values asArray ) sendToAddressString: localAddress port: scLangPort 
]