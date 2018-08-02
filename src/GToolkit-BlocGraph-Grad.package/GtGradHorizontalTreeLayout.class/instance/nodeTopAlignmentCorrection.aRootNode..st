api - geometry
nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ ((aRootNode maxWidthAt: (aTreeNode parent)) - (aTreeNode parent) width)@0