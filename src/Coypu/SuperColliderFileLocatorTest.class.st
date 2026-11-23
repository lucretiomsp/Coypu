"
I check that SuperColliderFileLocator finds the SuperCollider folders of every operating system, using a memory file system as home folder and a Dictionary as environment.
"
Class {
	#name : 'SuperColliderFileLocatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'home'
	],
	#category : 'Coypu-Tests',
	#package : 'Coypu',
	#tag : 'Tests'
}

{ #category : 'running' }
SuperColliderFileLocatorTest >> locatorOn: aPlatform environment: aDictionary [

	^ SuperColliderFileLocator new
		  platform: aPlatform;
		  environment: aDictionary;
		  home: home;
		  yourself
]

{ #category : 'running' }
SuperColliderFileLocatorTest >> setUp [

	super setUp.
	home := FileSystem memory root / 'Users' / 'coypu'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testClassSideAnswersTheCurrentSystemFolder [

	self assert: SuperColliderFileLocator directoryOfSamples equals: SuperColliderFileLocator new directoryOfSamples.
	self assert: SuperColliderFileLocator directoryOfSamples basename equals: 'Dirt-Samples'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testLinuxDefault [

	self
		assert: (self locatorOn: UnixPlatform new environment: Dictionary new) directoryOfSamples
		equals: home / '.local' / 'share' / 'SuperCollider' / 'downloaded-quarks' / 'Dirt-Samples'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testLinuxEmptyXdgDataHomeFallsBackToDefault [

	self
		assert: (self locatorOn: UnixPlatform new environment: { ('XDG_DATA_HOME' -> '') } asDictionary) userAppSupportDirectory
		equals: home / '.local' / 'share' / 'SuperCollider'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testLinuxXdgDataHome [

	self
		assert:
		(self locatorOn: UnixPlatform new environment: { ('XDG_DATA_HOME' -> '/data/share') } asDictionary) userAppSupportDirectory
		equals: home fileSystem root / 'data' / 'share' / 'SuperCollider'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testMacOS [

	self
		assert: (self locatorOn: MacOSXPlatform new environment: Dictionary new) directoryOfSamples
		equals: home / 'Library' / 'Application Support' / 'SuperCollider' / 'downloaded-quarks' / 'Dirt-Samples'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testSuperDirtSamplesFolderUsesTheLocator [

	self assert: SuperDirt samplesFolder equals: SuperColliderFileLocator directoryOfSamples
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testWindowsDefault [

	self
		assert: (self locatorOn: Win64Platform new environment: Dictionary new) userAppSupportDirectory
		equals: home / 'AppData' / 'Local' / 'SuperCollider'
]

{ #category : 'tests' }
SuperColliderFileLocatorTest >> testWindowsLocalAppData [

	self
		assert:
		(self locatorOn: Win64Platform new environment: { ('LOCALAPPDATA' -> '/appdata/local') } asDictionary) directoryOfSamples
		equals: home fileSystem root / 'appdata' / 'local' / 'SuperCollider' / 'downloaded-quarks' / 'Dirt-Samples'
]
