api - geometry
nodeTopAlignmentCorrection: aTreeNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0@((self maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height)