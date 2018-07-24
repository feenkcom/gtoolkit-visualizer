*GToolkit-BlocGraph-Grad
nodeHorizontalCenterAlignment: aTreeNode nodeMaxWidth: aMaxWidthAtNodesDepth parentMaxWidth: aMaxWidthAtParentsDepth
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ aMaxWidthAtParentsDepth - aTreeNode parent height ].
	^ 0 @ (aMaxWidthAtNodesDepth - aTreeNode element height
				+ parentCorrection) / 2.0