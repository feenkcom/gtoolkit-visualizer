api - geometry
nodeCenterAlignmentCorrection: aTreeNode
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ (self maxHeightAt: aTreeNode parent) - aTreeNode parent height ].
	^ 0@((self maxHeightAt: aTreeNode) - aTreeNode element height
				+ parentCorrection) / 2.0