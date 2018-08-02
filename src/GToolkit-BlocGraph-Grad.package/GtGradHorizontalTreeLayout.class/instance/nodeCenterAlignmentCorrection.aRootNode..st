api - geometry
nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ (aRootNode maxWidthAt: aTreeNode parent) - aTreeNode parent width ].
	^ (((aRootNode maxWidthAt: aTreeNode) - aTreeNode element width
				+ parentCorrection) / 2.0)@0