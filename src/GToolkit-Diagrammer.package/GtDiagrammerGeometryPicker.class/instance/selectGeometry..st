actions
selectGeometry: aGeometry
	self geometry: aGeometry do: [ :anElement | anElement border: (BlBorder paint: Color blue width: 1.5) ].
	self notGeometry: aGeometry do: [ :anElement | anElement border: (BlBorder paint: (Color gray alpha: 0.5) width: 1) ].

	self dispatchEvent: (GtDiagrammerGeometryPickerSelected new geometry: aGeometry copy)