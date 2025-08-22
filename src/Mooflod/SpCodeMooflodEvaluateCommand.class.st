Class {
	#name : 'SpCodeMooflodEvaluateCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Mooflod-Commands',
	#package : 'Mooflod',
	#tag : 'Commands'
}

{ #category : 'defaults' }
SpCodeMooflodEvaluateCommand class >> defaultIconName [

	^ #mooflodo
]

{ #category : 'defaults' }
SpCodeMooflodEvaluateCommand class >> defaultShortcutKey [

	^ $k actionModifier
]

{ #category : 'accessing' }
SpCodeMooflodEvaluateCommand class >> order [

	^ 9
]

{ #category : 'executing' }
SpCodeMooflodEvaluateCommand >> execute [
	"Treat the current text selection as an expression; evaluate it."

	"self evaluateSelectionAndDo: [ :result |  ]"

	Object inform: self context selectedTextOrLine 
]
