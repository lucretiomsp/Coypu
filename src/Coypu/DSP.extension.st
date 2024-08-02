Extension { #name : 'DSP' }

{ #category : '*Coypu' }
DSP >> setValueMooflod: aFloat parameter: aParamAsString [
	"  set the value of the parameter named aParamAsString"

	| indexInteger |
	self isNull
		ifTrue: [ ^ self class invalidException ]
		ifFalse: [
			indexInteger := self getParamIndex: aParamAsString.
			indexInteger ~= -1
				ifTrue: [
					self setValue: aFloat parameterIndex: indexInteger.
					Performance uniqueInstance visualizer sliderArray
						at: aParamAsString
						ifPresent: [ :slider | slider setValue: aFloat ] ]
				ifFalse: [ ^ self class invalidException ] ]
]

{ #category : '*Coypu' }
DSP >> trigMooflod: aString for: aDurationInSeconds [
	"send a 10 ms trigger to a Faust parameter, designed to trig envelopes and percussions-like sounds"

	" parameter must exist"

	(self getParamIndex: aString) = -1
		ifTrue: [ ^ self class paramException ]
		ifFalse: [
			[
			self setValueMooflod: 1 parameter: aString.
			aDurationInSeconds wait.
			self setValueMooflod: 0 parameter: aString ] forkAt: 70 ]
]
