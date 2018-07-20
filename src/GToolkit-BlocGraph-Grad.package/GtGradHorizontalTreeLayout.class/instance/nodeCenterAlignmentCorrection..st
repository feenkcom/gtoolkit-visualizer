api - geometry
nodeCenterAlignmentCorrection: aTreeNode
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ (self maxWidthAt: aTreeNode parent) - aTreeNode parent width ].
	^ (((self maxWidthAt: aTreeNode) - aTreeNode element width
				+ parentCorrection) / 2.0)@0