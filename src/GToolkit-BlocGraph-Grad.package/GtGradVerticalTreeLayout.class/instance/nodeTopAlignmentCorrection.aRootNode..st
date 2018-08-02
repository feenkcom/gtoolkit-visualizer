api - geometry
nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0@((aRootNode maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height)