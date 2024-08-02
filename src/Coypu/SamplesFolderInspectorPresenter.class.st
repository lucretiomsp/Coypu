Class {
	#name : 'SamplesFolderInspectorPresenter',
	#superclass : 'Object',
	#category : 'Coypu-SuperDirt',
	#package : 'Coypu',
	#tag : 'SuperDirt'
}

{ #category : 'inspect' }
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
