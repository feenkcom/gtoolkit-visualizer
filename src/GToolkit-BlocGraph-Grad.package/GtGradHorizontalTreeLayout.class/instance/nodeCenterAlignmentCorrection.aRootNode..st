api - geometry
nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode
	| parentCorrection |
	parentCorrection := aTreeNode hasParent
		ifFalse: [ 0 ]
		ifTrue: [ (aRootNode maxWidthAt: aTreeNode parent) - aTreeNode parent width ].
	^ (((aRootNode maxWidthAt: aTreeNode) - aTreeNode element width
				+ parentCorrection) / 2.0)@0