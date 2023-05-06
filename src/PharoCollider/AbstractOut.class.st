Class {
	#name : #AbstractOut,
	#superclass : #UGen,
	#category : #'PharoCollider-UGens'
}

{ #category : #topoSorting }
AbstractOut >> checkInputs [

	rate = 'audio' ifTrue: [ 
		self class numFixedArgs to: inputs size - 1 do: [ :i | 
			(inputs at: i) ~= 'audio' ifTrue: [ 
				^ Error new signal:
					  'Input at ' , i asString , 'is Not at audio rate' ] ] ].
	inputs size <= self class numFixedArgs ifTrue: [ 
		^ Error new signal: 'Missing input at index 1' ].
	^ self checkValidInputs
]

{ #category : #initialization }
AbstractOut >> initialize [ 

super initialize .
]

{ #category : #writing }
AbstractOut >> numFixedArgs [

self subclassResponsibility 
]

{ #category : #accessing }
AbstractOut >> numOutputs [ 
^ 0
]

{ #category : #writing }
AbstractOut >> writeOutputSpecs [

"empty as originally in SuperCollider" 
]
