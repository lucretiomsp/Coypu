"
# MarkovJazzMelodyGenerator
A lightweight generative melody engine using a 7-degree Markov chain.
## Usage
```language=Pharo
| generator melody |
gen := MarkovJazzMelodyGenerator new.
melody := gen generateMelodyFromScaleDegrees: Scale bebop root: 60 startDegree: 0 length: 32.
```
[] Generates melodies as sequences of scale degrees.
[] Supports any scale by providing a list of semitone offsets.
[] Degree transitions are weighted, allowing probabilistic motion.
[] Designed for jazz-style melodic patterns, but flexible for other styles.


"
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

{ #category : 'generating' }
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
JazzMarkovMelody >> initialize [
    super initialize.
    self initializeDegreeMarkovTable.
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

{ #category : 'private' }
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
