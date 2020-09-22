Extension { #name : #BlLayoutParentNodeWithFilter }

{ #category : #'*GToolkit-BlocGraph' }
BlLayoutParentNodeWithFilter >> withGraphEdges [
	| aParentNodeWithEdges |
	
	aParentNodeWithEdges := parentNode withGraphEdges.
	
	^ self class new
		parentNode: aParentNodeWithEdges;
		filterBlock: filter;
		children: (aParentNodeWithEdges children select: filter)
]
