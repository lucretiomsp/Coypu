"
I store the MIDI implementation chart for Digitakt2.
To get the CC number for the desired parameter, send a message to the class.
"
Class {
	#name : 'DTakt2',
	#superclass : 'Object',
	#category : 'ElektronMIDIChart',
	#package : 'ElektronMIDIChart'
}

{ #category : 'amp parameters' }
DTakt2 class >> attackTime [ 
^ 79
]

{ #category : 'fx parameters' }
DTakt2 class >> bitReduction [ 
^ 54
]

{ #category : 'fx parameters' }
DTakt2 class >> chorusSend [ 
^ 12
]

{ #category : 'amp parameters' }
DTakt2 class >> decayTime [ 
^ 81
]

{ #category : 'sendFX parameters' }
DTakt2 class >> delayFeedback [
^ 24
]

{ #category : 'sendFX parameters' }
DTakt2 class >> delayHighPass [
^ 26
]

{ #category : 'sendFX parameters' }
DTakt2 class >> delayLowPass [
^ 26
]

{ #category : 'fx parameters' }
DTakt2 class >> delaySend [ 
^ 84
]

{ #category : 'sendFX parameters' }
DTakt2 class >> delayTime [ 
^ 21
]

{ #category : 'filter parameters' }
DTakt2 class >> envDepth [ 
^ 77
]

{ #category : 'filter parameters' }
DTakt2 class >> filterDecay [ 
^ 71
]

{ #category : 'filter parameters' }
DTakt2 class >> filterFreq [ 
^ 74
]

{ #category : 'filter parameters' }
DTakt2 class >> filterType [ 
^ 76
]

{ #category : 'fx parameters' }
DTakt2 class >> overdrive [ 
^ 57
]

{ #category : 'amp parameters' }
DTakt2 class >> pan [ 
^ 90
]

{ #category : 'source parameters' }
DTakt2 class >> playMode [ 
^ 17
]

{ #category : 'amp parameters' }
DTakt2 class >> releaseTime [ 
^ 83
]

{ #category : 'filter parameters' }
DTakt2 class >> resonance [ 
^ 75
]

{ #category : 'fx parameters' }
DTakt2 class >> reverbSend [ 
^ 85
]

{ #category : 'source parameters' }
DTakt2 class >> sampleBankSelect [ 
^ 24
]

{ #category : 'source parameters' }
DTakt2 class >> sampleLevel [
^ 13
]

{ #category : 'fx parameters' }
DTakt2 class >> sampleRateReduction [ 
^ 55
]

{ #category : 'source parameters' }
DTakt2 class >> sampleSlotSelect [ 
^ 19
]

{ #category : 'amp parameters' }
DTakt2 class >> sustainLevel [ 
^ 82
]

{ #category : 'source parameters' }
DTakt2 class >> tune [ 
^ 16
]

{ #category : 'amp parameters' }
DTakt2 class >> volume [ 
^ 89
]
