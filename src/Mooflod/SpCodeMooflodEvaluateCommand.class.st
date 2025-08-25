Class {
	#name : 'SpCodeMooflodEvaluateCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Mooflod-CodeDisplay',
	#package : 'Mooflod',
	#tag : 'CodeDisplay'
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

	Object inform: self context selectedTextOrLine.
	self context selectedTextOrLine inspect.
]
