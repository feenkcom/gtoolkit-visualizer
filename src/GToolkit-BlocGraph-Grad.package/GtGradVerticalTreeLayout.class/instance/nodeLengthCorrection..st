api - geometry
nodeLengthCorrection: aTreeNode
	aTreeNode parent isNil
		ifTrue: [ ^ 0 ].
	^ (self maxHeightAt: (aTreeNode parent)) - (aTreeNode parent) height