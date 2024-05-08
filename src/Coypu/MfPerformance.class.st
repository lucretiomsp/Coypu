"
I am a Performance for MoofLod. I send information to a MfVisualizer child when Sequencers are stores in me.
Single tracks visualizers are stored into a Dictionary to be easily accessed
"
Class {
	#name : #MfPerformance,
	#superclass : #Performance,
	#type : #variable,
	#instVars : [
		'perfVisualizer',
		'trackVisualizers'
	],
	#category : #'Coypu-Performance'
}

{ #category : #initialization }
MfPerformance >> initialize [ 

super initialize .
trackVisualizers := Dictionary new.
]

{ #category : #accessing }
MfPerformance >> perfVisualizer [

	^ perfVisualizer
]

{ #category : #accessing }
MfPerformance >> perfVisualizer: anMfPerfVisualizer [

	perfVisualizer := anMfPerfVisualizer
]

{ #category : #accessing }
MfPerformance >> trackVisualizers [

	^ trackVisualizers
]

{ #category : #accessing }
MfPerformance >> trackVisualizers: anObject [

	trackVisualizers := anObject
]
