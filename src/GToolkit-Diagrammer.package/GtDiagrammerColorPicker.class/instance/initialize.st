initialization
initialize
	super initialize.
	
	self display: [ Color registeredColorNames collect: [ :aName | Color named: aName ] ].
	self shape: [ :aColor |
		BlElement new
			size: 20@20;
			background: aColor;
			geometry: (BlRectangle cornerRadius: 3) ].
	self selected: [ :anElement | anElement border: (BlBorder paint: Color blue width: 1.5) ].
	self deselected: [ :anElement :aColor | anElement border: (BlBorder paint: aColor darker width: 1) ]