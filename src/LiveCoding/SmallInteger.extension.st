Extension { #name : #SmallInteger }

{ #category : #'*LiveCoding' }
SmallInteger >> asInt8 [

	| bitArray firsComplement binaryString secondComplementAsString secondComplement result |
	bitArray := self asBitsArrayOfSize: 8.
	firsComplement := (bitArray at: 1) * 128 negated.
	binaryString := String new: 7.
	2 to: 8 do: [ :i | 
	binaryString at: i - 1 put: (bitArray at: i) asCharacterDigit ].
	secondComplementAsString := '2r' , binaryString.
	secondComplement := Smalltalk compiler evaluate:
		                    secondComplementAsString.
	result := firsComplement + secondComplement.
	^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> bars [
	"return number of steps in self bars"
	^ self*16
]

{ #category : #'*LiveCoding' }
SmallInteger >> isVoiceMessage [
	"In MIDI communication, each MIDI message consists of a status byte followed by one or two data bytes. The status byte contains information about the type of message being sent, such as note-on, note-off, control change, etc.
The status byte has a specific format: The most significant nibble (the leftmost 4 bits) indicates the type of message. The least significant nibble (the rightmost 4 bits) typically represents the MIDI channel. For example, in the MIDI protocol:

Note-on messages usually have a status byte starting with 0x90 (binary 1001xxxx), where xxxx represents the MIDI channel.
Note-off messages usually have a status byte starting with 0x80 (binary 1000xxxx), again with xxxx representing the MIDI channel.
When receiving MIDI messages, it's common to filter and process messages based on their type. In your case, you're interested in detecting note-on messages, which typically have a status byte starting with 0x90.
The reason for performing bitwise AND with 16rF0 (which is 11110000 in binary) is to mask out the least significant nibble of the status byte, effectively isolating the most significant nibble. This allows you to compare only the most significant nibble with a given value to determine the type of MIDI message.

"

	^ (self bitAnd: 16rf0) = self
]

{ #category : #'*LiveCoding' }
SmallInteger >> saw [

	"fill an array of self steps with values representing a sawtooth with range 0 - 1"

	^ (0 to: 1 by: 1 / (self -1)) asDirtArray
]

{ #category : #'*LiveCoding' }
SmallInteger >> sawCC: aRange [

	"fill an array of self steps with values representing a sawtooth with aRange 1"

	| min max range arrayOfFloats result |
	min := aRange at: 1.
	max := aRange at: 2.
	range := max - min.
	arrayOfFloats := (min to: max by: range / (self - 1)) asDirtArray.
	result := arrayOfFloats collect: [ :i | i rounded ].
^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> triangle [

	"return an array of self size with a triangle wave with range 0 -1"

	| increment up down result |
	increment := 1 / (self / 2 - 1).
	up := (0 to: 1 by: increment) asDirtArray.
	down := up reverse.
	result := up , down.
	^ result
]

{ #category : #'*LiveCoding' }
SmallInteger >> triangleCC: aRange [

	"return an array of self size with a triangle wave with aRange suited for MIDI ccs"

	| increment range min max up down arrayOfFloats result |
	min := aRange at: 1.
	max := aRange at: 2.
	range := (max - min).
	increment := range / (self / 2 - 1).
	up := (min to: max by: increment) asDirtArray.
	down := up reverse.
	arrayOfFloats  := up , down.
	result := arrayOfFloats collect: [ :i | i rounded ].
	^ result
]
