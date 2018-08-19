accessing
edgeElementFor: anObject
	^ elementStencilBuilder
		ifNotNil: [ elementStencilBuilder value: anObject ]
		ifNil: [ self defaultEdgeElement ]