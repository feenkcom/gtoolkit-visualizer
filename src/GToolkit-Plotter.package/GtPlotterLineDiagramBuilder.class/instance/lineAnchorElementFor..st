private - instance creation
lineAnchorElementFor: anObject
	<return: #BlElement>
	| aDotElement |
	
	aDotElement := dotBlock 
		ifNotNil: [ dotBlock cull: anObject cull: self defaultDotElement ]
		ifNil: [ self defaultDotElement ].

	aDotElement
		constraintsDo: [ :c | c plotter domainObject: (GtPlotterDomainObject new value: anObject) ].

	^ aDotElement