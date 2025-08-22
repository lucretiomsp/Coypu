Class {
	#name : 'MfEvaluator',
	#superclass : 'Object',
	#category : 'Coypu',
	#package : 'Coypu'
}

{ #category : 'world menu' }
MfEvaluator class >> activate [


| entry categoryToAdd |
entry := KMKeymap
		         named: #EvaluateCheto
		         shortcut: $e meta
		         action: [ Object inform: 'ciao' ].
		
categoryToAdd := KMCategory named: #MoofLodCategory.
categoryToAdd addKeymapEntry: entry.
KMRepository default addCategory: categoryToAdd .

World attachKeymapCategory: #MooflodCategory. 
]
