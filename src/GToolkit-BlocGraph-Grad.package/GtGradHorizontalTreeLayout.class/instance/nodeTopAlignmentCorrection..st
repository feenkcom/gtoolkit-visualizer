api - geometry
nodeTopAlignmentCorrection: aTreeNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ ((self maxWidthAt: (aTreeNode parent)) - (aTreeNode parent) width)@0