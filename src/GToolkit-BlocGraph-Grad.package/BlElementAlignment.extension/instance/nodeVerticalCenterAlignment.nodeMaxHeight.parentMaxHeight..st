*GToolkit-BlocGraph-Grad
nodeVerticalCenterAlignment: aTreeNode nodeMaxHeight: aMaxHeightAtNodesDepth parentMaxHeight: aMaxHeightAtParentsDepth
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ aMaxHeightAtParentsDepth - aTreeNode parent height ].
	^ 0 @ (aMaxHeightAtNodesDepth - aTreeNode element height
				+ parentCorrection) / 2.0