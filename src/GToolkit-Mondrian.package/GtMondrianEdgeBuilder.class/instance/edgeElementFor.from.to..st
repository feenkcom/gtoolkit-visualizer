private
edgeElementFor: anObject from: fromElement to: toElement
	| edgeElement |
	edgeElement := elementStencilBuilder
		ifNotNil: [ elementStencilBuilder 
				cull: anObject
				cull: fromElement
				cull: toElement ]
		ifNil: [ self defaultEdgeElement ].
	edgeElement
		fromAnchor: (fromAnchorClass referenceElement: fromElement relatedTo: toElement);
		toAnchor: (toAnchorClass referenceElement: toElement relatedTo: fromElement).
	edgeElement constraints ignoreByLayout.
	edgeElement graph model: anObject.
	edgeElement graph beEdge.
	^ edgeElement