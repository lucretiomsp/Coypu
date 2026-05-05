"
Rana theme configurator
"
Class {
	#name : 'RanaThemeConfigurator',
	#superclass : 'DarkThemeColorConfigurator',
	#category : 'Coypu-UI-Themes',
	#package : 'Coypu',
	#tag : 'UI-Themes'
}

{ #category : 'colors' }
RanaThemeConfigurator >> backgroundColor [
    ^ Color black
]

{ #category : 'colors' }
RanaThemeConfigurator >> baseColor [ 
"General widget base color (buttons, dropdowns, etc.)"
^ Color fromHexString: '1A1A1A'
]

{ #category : 'colors' }
RanaThemeConfigurator >> basePassiveBackgroundColor [
    "Background of passive/unfocused elements"
    ^ Color fromHexString: '111111'
]

{ #category : 'colors' }
RanaThemeConfigurator >> baseSelectionColor [
    "Background of selected items (lists, text selection)"
    ^ Color fromHexString: '0A3D0A'
]

{ #category : 'colors' }
RanaThemeConfigurator >> borderColor [


	^ Color fromHexString: '1A3A1A'
]

{ #category : 'colors' }
RanaThemeConfigurator >> buttonColor [
    ^ Color fromHexString: '1A2E1A'
]

{ #category : 'colors' }
RanaThemeConfigurator >> currentLineNumberColor [
    "The line number of the line where the cursor is"
    ^ Color white
]

{ #category : 'colors' }
RanaThemeConfigurator >> dangerTextColor [
    "For destructive actions — keep amber for CRT feel"
    ^ Color fromHexString: 'FFAA00'
]

{ #category : 'colors' }
RanaThemeConfigurator >> desktopColor [
	

	^ Color fromHexString: '050505'
]

{ #category : 'colors' }
RanaThemeConfigurator >> lessConspicuousColorFrom: aColor [
    "Used for secondary/dimmed text"
    ^ Color fromHexString: '33AA33'
]

{ #category : 'colors' }
RanaThemeConfigurator >> lightBackgroundColor [
    ^ Color black
]

{ #category : 'colors' }
RanaThemeConfigurator >> lineNumberColor [
    "Line number text color"
    ^ Color white
]

{ #category : 'colors' }
RanaThemeConfigurator >> menuBorderColor [
    ^ Color fromHexString: '1A3A1A'
]

{ #category : 'menus' }
RanaThemeConfigurator >> menuColor [

	^ Color fromHexString: '0F0F0F'
]

{ #category : 'colors' }
RanaThemeConfigurator >> menuSelectionColor [
    "Highlighted item in menus"
    ^ Color fromHexString: '0A3D0A'
]

{ #category : 'colors' }
RanaThemeConfigurator >> scrollbarColor [


	^ Color fromHexString: '143314'
]

{ #category : 'colors' }
RanaThemeConfigurator >> textColor [
    "Default text color everywhere"
    ^ Color fromHexString: '00FF41'
]

{ #category : 'colors' }
RanaThemeConfigurator >> textColorForNonStandardBackground [
    "Text color used on highlights/selection"
    ^ Color fromHexString: '66FF66'
]

{ #category : 'colors' }
RanaThemeConfigurator >> textEditorNormalFillStyleFor: aTextEditor [
    "Background of text areas (Playground, code panes, etc.)"
    ^ Color fromHexString: '000000'
]
