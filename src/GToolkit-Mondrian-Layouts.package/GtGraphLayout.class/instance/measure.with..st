layout
measure: anElement with: anExtentSpec
	
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ].
	
	self measureIgnored: anElement with: anExtentSpec.

	self applyOn: (anElement children select: [ :aChild | aChild constraints ignoredByLayout not ]).

	self fit: anElement with: anExtentSpec