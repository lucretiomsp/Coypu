"
I know where SuperCollider keeps its files on the current operating system, mirroring SuperCollider's own `Platform.userAppSupportDir`:

- macOS: `~/Library/Application Support/SuperCollider`
- Linux / other Unix: `$XDG_DATA_HOME/SuperCollider`, by default `~/.local/share/SuperCollider`
- Windows: `%LOCALAPPDATA%\SuperCollider`, by default `~/AppData/Local/SuperCollider`

Quarks (SuperDirt, Dirt-Samples...) are installed in `downloaded-quarks` inside that folder.

Typical use:

```
SuperColliderFileLocator directoryOfSamples.
SuperColliderFileLocator userAppSupportDirectory.
```

The class side asks the running system; an instance can be given another platform, environment and home folder, which is how the tests check every OS:

```
(SuperColliderFileLocator new
	platform: UnixPlatform new;
	environment: Dictionary new;
	home: FileSystem memory root;
	yourself) directoryOfSamples
```
"
Class {
	#name : 'SuperColliderFileLocator',
	#superclass : 'Object',
	#instVars : [
		'platform',
		'environment',
		'home'
	],
	#category : 'Coypu-SuperDirt',
	#package : 'Coypu',
	#tag : 'SuperDirt'
}

{ #category : 'accessing' }
SuperColliderFileLocator class >> directoryOfSamples [
	"the Dirt-Samples folder used by SuperDirt on the current operating system"

	^ self new directoryOfSamples
]

{ #category : 'accessing' }
SuperColliderFileLocator class >> downloadedQuarksDirectory [

	^ self new downloadedQuarksDirectory
]

{ #category : 'accessing' }
SuperColliderFileLocator class >> userAppSupportDirectory [

	^ self new userAppSupportDirectory
]

{ #category : 'private' }
SuperColliderFileLocator >> at: aVariableName orHome: aBlock [
	"the folder named by the environment variable, or aBlock applied to the home folder when it is unset or empty"

	| value |
	value := self environment at: aVariableName ifAbsent: [ nil ].
	^ (value isNil or: [ value isEmpty ])
		  ifTrue: [ aBlock value: self home ]
		  ifFalse: [ self home fileSystem referenceTo: value ]
]

{ #category : 'accessing' }
SuperColliderFileLocator >> directoryOfSamples [

	^ self downloadedQuarksDirectory / 'Dirt-Samples'
]

{ #category : 'accessing' }
SuperColliderFileLocator >> downloadedQuarksDirectory [

	^ self userAppSupportDirectory / 'downloaded-quarks'
]

{ #category : 'accessing' }
SuperColliderFileLocator >> environment [

	^ environment ifNil: [ OSEnvironment current ]
]

{ #category : 'accessing' }
SuperColliderFileLocator >> environment: aDictionaryLike [
	"anything answering at:ifAbsent: with variable names, OSEnvironment current by default"

	environment := aDictionaryLike
]

{ #category : 'accessing' }
SuperColliderFileLocator >> home [

	^ home ifNil: [ FileLocator home asFileReference ]
]

{ #category : 'accessing' }
SuperColliderFileLocator >> home: aFileReference [

	home := aFileReference
]

{ #category : 'accessing' }
SuperColliderFileLocator >> platform [

	^ platform ifNil: [ OSPlatform current ]
]

{ #category : 'accessing' }
SuperColliderFileLocator >> platform: anOSPlatform [

	platform := anOSPlatform
]

{ #category : 'accessing' }
SuperColliderFileLocator >> userAppSupportDirectory [
	"the folder SuperCollider calls Platform.userAppSupportDir"

	self platform isMacOS ifTrue: [ ^ self home / 'Library' / 'Application Support' / 'SuperCollider' ].
	self platform isWindows ifTrue: [ ^ (self at: 'LOCALAPPDATA' orHome: [ :h | h / 'AppData' / 'Local' ]) / 'SuperCollider' ].
	^ (self at: 'XDG_DATA_HOME' orHome: [ :h | h / '.local' / 'share' ]) / 'SuperCollider'
]
