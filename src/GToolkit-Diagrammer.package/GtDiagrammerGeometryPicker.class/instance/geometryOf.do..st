enumeration
geometryOf: anElement do: aBlock
	anElement userData
		at: #geometry
		ifPresent: aBlock