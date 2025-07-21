Class {
	#name : 'JazzMarkovMelody',
	#superclass : 'Object',
	#type : 'variable',
	#instVars : [
		'markovTable'
	],
	#category : 'Coypu-ScalesAndChords',
	#package : 'Coypu',
	#tag : 'ScalesAndChords'
}

{ #category : 'as yet unclassified' }
JazzMarkovMelody >> generateMelodyFromScaleDegrees: scaleDegrees
                                      root: rootMidiNote
                                      startDegree: start
                                      length: n [
  | melody degree note |
  melody := OrderedCollection new.
  degree := start.

  n timesRepeat: [
    (degree between: 0 and: scaleDegrees size - 1)
      ifTrue: [
        note := rootMidiNote + (scaleDegrees at: degree + 1).
        melody add: note.
      ].
    degree := self weightedNextFrom: degree.
    degree ifNil: [ ^ melody asArray ].
  ].
  ^ melody asArray

]

{ #category : 'initialization' }
JazzMarkovMelody >> initializeDegreeMarkovTable [
  markovTable := Dictionary new.

  markovTable at: 0 put: { 1 -> 3. 2 -> 1 }.
  markovTable at: 1 put: { 2 -> 2. 0 -> 1 }.
  markovTable at: 2 put: { 3 -> 2. 1 -> 1 }.
  markovTable at: 3 put: { 4 -> 2. 2 -> 1 }.
  markovTable at: 4 put: { 5 -> 2. 3 -> 1 }.
  markovTable at: 5 put: { 6 -> 2. 4 -> 1 }.
  markovTable at: 6 put: { 5 -> 2. 3 -> 1 }.

]

{ #category : 'as yet unclassified' }
JazzMarkovMelody >> weightedNextFrom: degree [

	| options total roll sum |
	options := markovTable at: degree ifAbsent: [ ^ nil ].
	total := options inject: 0 into: [:acc :assoc | acc + assoc value].


	roll := (Random new next * total) ceiling.
	sum := 0.
	options do: [ :assoc |
			sum := sum + assoc value.
			roll <= sum ifTrue: [ ^ assoc key ] ].
	^ nil
]
