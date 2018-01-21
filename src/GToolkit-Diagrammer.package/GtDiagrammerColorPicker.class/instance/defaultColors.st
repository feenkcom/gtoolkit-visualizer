initialization
defaultColors
	^ Color registeredColorNames collect: [ :aName | Color named: aName ]