Class {
	#name : #SamplesFolderInspectorPresenter,
	#superclass : #Object,
	#category : #'Coypu-SuperDirt'
}

{ #category : #'as yet unclassified' }
SamplesFolderInspectorPresenter >> sampleDirectories [

	<inspectorPresentationOrder:0 title:'Sample directories' >
	| sampleDirectories |

	sampleDirectories := SuperDirt samplesFolder directories reject: [ :e |
		e basename beginsWith: '.' ].
	^ SpListPresenter new
		  items: sampleDirectories;
		  sortingBlock: [ :a :b | a basename < b basename  ];
		display: [ :e | e basename ]
]
