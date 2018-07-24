*GToolkit-BlocGraph-Grad
nodeVerticalTopAlignment: aTreeNode parentMaxHeight: aMaxHeightAtParentsDepth
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0 @ (aMaxHeightAtParentsDepth - (aTreeNode parent) height)