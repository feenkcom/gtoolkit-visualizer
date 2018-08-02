api - geometry
nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ (aRootNode maxHeightAt: aTreeNode parent) - aTreeNode parent height ].
	^ 0@((aRootNode maxHeightAt: aTreeNode) - aTreeNode element height
				+ parentCorrection) / 2.0