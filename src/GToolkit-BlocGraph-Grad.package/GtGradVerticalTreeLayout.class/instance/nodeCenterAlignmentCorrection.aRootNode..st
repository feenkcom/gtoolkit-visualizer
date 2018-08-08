api - geometry
nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode
	| parentCorrection |
	parentCorrection := aTreeNode hasParent
		ifFalse: [ 0 ]
		ifTrue: [ (aRootNode maxHeightAt: aTreeNode parent) - aTreeNode parent height ].
	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height
				+ parentCorrection) / 2.0