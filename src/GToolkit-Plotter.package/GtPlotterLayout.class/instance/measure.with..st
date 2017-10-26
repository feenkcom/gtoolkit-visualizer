measure
measure: anElement with: anExtentSpec
	
	horizontalAxisElement := anElement children
		detect: [ :aChildElement | aChildElement constraints plotter isHorizonalAxis ]
		ifNone: [ ^ self ].

	verticalAxisElement := anElement children
		detect: [ :aChildElement | aChildElement constraints plotter isVerticalAxis ]
		ifNone: [ ^ self ].

	horizontalAxis := horizontalAxisElement constraints plotter horizontal axis.
	verticalAxis := verticalAxisElement constraints plotter vertical axis.

	domainElements := anElement children
		select: [ :aChildElement | aChildElement constraints plotter hasDomainObject ].
	
	self
		measuredChildren: anElement
		do: [ :aChildElement | self measureChild: aChildElement parentSpec: anExtentSpec ].
		
	anElement measuredExtent: (anExtentSpec sizeFor: anElement extent)