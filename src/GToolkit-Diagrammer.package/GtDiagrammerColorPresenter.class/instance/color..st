accessing
color: aColor

	color := aColor.

	self background: aColor.
	self border: (BlBorder paint: aColor darker width: 1)