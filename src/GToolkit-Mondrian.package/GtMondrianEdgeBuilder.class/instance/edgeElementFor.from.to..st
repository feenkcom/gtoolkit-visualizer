private
edgeElementFor: anObject from: fromElement to: toElement
	| edgeElement |
	edgeElement := self edgeElementFor: anObject.
	edgeElement
		fromAnchor: (fromAnchorClass referenceElement: fromElement relatedTo: toElement);
		toAnchor: (toAnchorClass referenceElement: toElement relatedTo: fromElement).
	edgeElement constraints ignoreByLayout.
	edgeElement mondrianModel: anObject.
	edgeElement beMondrianEdge.
	^ edgeElement