*GToolkit-BlocGraph-Grad
nodeHozitonalLeftAlignment: aTreeNode parentMaxWidth: aMaxWidthAtParentsDepth
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0 @ (aMaxWidthAtParentsDepth - (aTreeNode parent) height)