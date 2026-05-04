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

{ #category : 'windows' }
RanaTheme class >> baseColor [ 
"General widget base color (buttons, dropdowns, etc.)"
^ Color fromHexString: '1A1A1A'
]

{ #category : 'windows' }
RanaTheme class >> basePassiveBackgroundColor [
    "Background of passive/unfocused elements"
    ^ Color fromHexString: '111111'
]

{ #category : 'windows' }
RanaTheme class >> baseSelectionColor [
    "Background of selected items (lists, text selection)"
    ^ Color fromHexString: '0A3D0A'
]

{ #category : 'windows' }
RanaTheme class >> borderColor [
    ^ Color fromHexString: '1A3A1A'
]

{ #category : 'colors' }
RanaTheme class >> buttonColor [
    ^ Color fromHexString: '1A2E1A'
]

{ #category : 'colors' }
RanaTheme class >> dangerTextColor [
    "For destructive actions — keep amber for CRT feel"
    ^ Color fromHexString: 'FFAA00'
]

{ #category : 'windows' }
RanaTheme class >> desktopColor [
    ^ Color fromHexString: '050505'
]

{ #category : 'windows' }
RanaTheme class >> lessConspicuousColorFrom: aColor [
    "Used for secondary/dimmed text"
    ^ Color fromHexString: '33AA33'
]

{ #category : 'windows' }
RanaTheme class >> menuBorderColor [
    ^ Color fromHexString: '1A3A1A'
]

{ #category : 'windows' }
RanaTheme class >> menuColor [
    ^ Color fromHexString: '0F0F0F'
]

{ #category : 'windows' }
RanaTheme class >> menuSelectionColor [
    "Highlighted item in menus"
    ^ Color fromHexString: '0A3D0A'
]

{ #category : 'windows' }
RanaTheme class >> scrollbarColor [
    ^ Color fromHexString: '143314'
]

{ #category : 'windows' }
RanaTheme class >> textColor [
    "Default text color everywhere"
    ^ Color fromHexString: '00FF41'
]

{ #category : 'windows' }
RanaTheme class >> textColorForNonStandardBackground [
    "Text color used on highlights/selection"
    ^ Color fromHexString: '66FF66'
]

{ #category : 'accessing' }
RanaTheme class >> themeName [ 

^ 'Rana (Phospor Green)'
]

{ #category : 'windows' }
RanaTheme class >> windowColor [

^ Color fromHexString: '0D0D0D'
]
