actions
selectColor: aColor
	self color: aColor do: [ :anElement | anElement border: (BlBorder paint: Color blue width: 1.5) ].
	self notColor: aColor do: [ :anElement | (self colorOf: anElement do: [ :eachColor | anElement border: (BlBorder paint: eachColor darker width: 1) ]) ].

	self dispatchEvent: (GtDiagrammerColorPickerSelected new color: aColor)