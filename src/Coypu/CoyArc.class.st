"
A time arc represented as two Fractions [begin, end) within a cycle. 0 is the cycle start, 1 its end. Used by the cyclic engine to query and schedule pattern events. Equivalent to Arc in TidalCycles/Vortex.
"
Class {
	#name : 'CoyArc',
	#superclass : 'Object',
	#instVars : [
		'begin',
		'end'
	],
	#category : 'Coypu-Cyclic',
	#package : 'Coypu',
	#tag : 'Cyclic'
}

{ #category : 'instance creation' }
CoyArc class >> from: aBegin to: anEnd [ 
	  ^ self new begin: aBegin end: anEnd; yourself
]

{ #category : 'comparing' }
CoyArc >> = anObject [
    ^ anObject class = self class 
        and: [ begin = anObject  begin 
        and: [ end = anObject end ] ]
]

{ #category : 'accessing' }
CoyArc >> begin [ 
^ begin
]

{ #category : 'accessing' }
CoyArc >> begin: aFraction [

begin := aFraction 
]

{ #category : 'accessing' }
CoyArc >> begin: aBegin end: anEnd [
  
    begin := aBegin.
    end := anEnd
]

{ #category : 'accessing' }
CoyArc >> duration [

	^ end - begin
]

{ #category : 'accessing' }
CoyArc >> end [ 
^ end
]

{ #category : 'accessing' }
CoyArc >> end: aFraction [

end := aFraction 
]

{ #category : 'comparing' }
CoyArc >> hash [
    ^ begin hash bitXor: end hash
]

{ #category : 'querying' }
CoyArc >> includeTime: aTimeFraction [

^ aTimeFraction >= begin and: (aTimeFraction < end )
]

{ #category : 'printing' }
CoyArc >> printOn: aStream [
    aStream 
        nextPutAll: 'CoyArc(';
        print: begin;
        nextPutAll: ', ';
        print: end;
        nextPut: $)
]

{ #category : 'querying' }
CoyArc >> sect: anotherArc [
	"for splitting arcs, useful later for subdivision"

	    | b e |
    b := begin max: anotherArc begin.
    e := end min: anotherArc end.
    ^ self class from: b to: (e max: b)
]
