Class {
	#name : #PortAudio,
	#superclass : #FFILibrary,
	#instVars : [
		'outStream'
	],
	#category : #Coypu
}

{ #category : #'accessing - platform' }
PortAudio >> getDeviceCount [
^ self ffiCall: #(int Pa_GetDeviceCount())
]

{ #category : #'accessing - platform' }
PortAudio >> macModuleName [ 

^ 'libportaudio.2.dylib'
]

{ #category : #'accessing - platform' }
PortAudio >> pa_Initialize [
^ self ffiCall: #(int Pa_Initialize())
]
