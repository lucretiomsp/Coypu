Class {
	#name : #NewRythmUsed,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'rythm'
	],
	#category : #Coypu
}

{ #category : #accessing }
NewRythmUsed >> announcer [

   announcer ifNil: [ 
	announcer := Announcer new
	announcer when: RythmAnnouncement do:[Yop rythmAdded: rythm]]
 
]

{ #category : #accessing }
NewRythmUsed >> newRythmUsed: aRythm [
 rythm := aRythm.
  self announcer
    announce: ( RythmAnnouncement new
                rythm: aRythm;
                yourself).

self newRythmUsedAlert: aRythm
]

{ #category : #accessing }
NewRythmUsed >> newRythmUsedAlert: aRythm [
Transcript 
    show: aRythm;
    show: ' has been used.';
    cr
]
