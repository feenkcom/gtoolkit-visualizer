accessing
geometry: anObject
	geometry := anObject.

	self dispatchEvent: (GtDiagrammerChangeGeometry new geometry: self geometry)