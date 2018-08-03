api - geometry
nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
	^ aTreeNode hasParent
		ifTrue: [ 0@((aRootNode maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height) ]
		ifFalse: [ 0@0 ]