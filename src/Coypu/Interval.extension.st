Extension { #name : 'Interval' }

{ #category : '*Coypu' }
Interval >> map: value to: range [

	^ value - self first / (self last - self first)
	  * (range last - range first) + range first
]
