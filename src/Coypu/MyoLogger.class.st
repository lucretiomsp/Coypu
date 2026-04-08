"
I am a simple logger for Coypu 
"
Class {
	#name : 'MyoLogger',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'Coypu-Logger',
	#package : 'Coypu',
	#tag : 'Logger'
}

{ #category : 'initialization' }
MyoLogger >> initialize [ 

super initialize .
stream := ReadWriteStream on: ''
]

{ #category : 'accessing' }
MyoLogger >> stream [

^ stream 
]
