"
I am a green phosphor CRT-inspired theme for Pharo, designed for live coding music with Coypu and Phausto. Black background, glowing green text, like a frog in the night: small, green, and making sounds. Named after the rana (frog), keeping the Coypu tradition of naming things after animals found on the banks of Veneto's rivers.
"
Class {
	#name : 'RanaTheme',
	#superclass : 'PharoDarkTheme',
	#category : 'Coypu-UI-Themes',
	#package : 'Coypu',
	#tag : 'UI-Themes'
}

{ #category : 'configuration' }
RanaTheme class >> colorConfiguratorClass [

	^ RanaThemeConfigurator
]

{ #category : 'accessing' }
RanaTheme class >> themeName [ 

^ 'Rana (Phospor Green)'
]

{ #category : 'windows' }
RanaTheme class >> windowColor [

^ Color fromHexString: '0D0D0D'
]
