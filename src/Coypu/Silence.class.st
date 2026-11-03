"
I am a convenience class to immediately mute a Sequencer, for example:

```language=Pharo
Silence to: #breaks.
```
"
Class {
	#name : 'Silence',
	#superclass : 'Object',
	#category : 'Coypu-Sequencers',
	#package : 'Coypu',
	#tag : 'Sequencers'
}

{ #category : 'accessing' }
Silence class >> to: aKeyInPerformance [
	" immediately mute a Sequencer in the performance"
16 rests to: aKeyInPerformance 
]
