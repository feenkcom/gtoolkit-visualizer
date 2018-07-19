api - geometry
nodeBreadthCorrection: aTreeNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0 ].
	^ (self maxWidthAt: (aTreeNode parent)) - (aTreeNode parent) width