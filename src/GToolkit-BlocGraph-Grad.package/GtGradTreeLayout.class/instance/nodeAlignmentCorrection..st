api - geometry
nodeAlignmentCorrection: aTreeNode
	nodesAlignment = 'top'
		ifTrue: [ ^ self nodeTopAlignmentCorrection: aTreeNode ].
	nodesAlignment = 'center'
		ifTrue: [ ^ self nodeCenterAlignmentCorrection: aTreeNode ].
	nodesAlignment = 'bottom'
		ifTrue: [ ^ self nodeBottomAlignmentCorrection: aTreeNode ]