api - geometry
nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
	^ aTreeNode hasParent
		ifTrue: [ ((aRootNode maxWidthAt: (aTreeNode parent)) - (aTreeNode parent) width)@0 ]
		ifFalse: [ 0@0 ]