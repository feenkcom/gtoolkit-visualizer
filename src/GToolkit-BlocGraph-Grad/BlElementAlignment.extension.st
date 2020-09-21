Extension { #name : #BlElementAlignment }

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeHorizontalCenterAlignment: aTreeNode nodeMaxWidth: aMaxWidthAtNodesDepth parentMaxWidth: aMaxWidthAtParentsDepth [
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ aMaxWidthAtParentsDepth - aTreeNode parent height ].
	^ 0 @ (aMaxWidthAtNodesDepth - aTreeNode element measuredHeight
				+ parentCorrection) / 2.0
]

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeHorizontalRightAlignment: aTreeNode nodeMaxWidth: aMaxWidthAtNodesDepth [ 
	^ 0 @ (aMaxWidthAtNodesDepth - aTreeNode element measuredWidth)
]

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeHozitonalLeftAlignment: aTreeNode parentMaxWidth: aMaxWidthAtParentsDepth [
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0 @ (aMaxWidthAtParentsDepth - (aTreeNode parent) height)
]

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeVerticalBottomAlignment: aTreeNode nodeMaxHeight: aMaxHeightAtNodesDepth [
	^ 0 @ (aMaxHeightAtNodesDepth - aTreeNode element measuredHeight)
]

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeVerticalCenterAlignment: aTreeNode nodeMaxHeight: aMaxHeightAtNodesDepth parentMaxHeight: aMaxHeightAtParentsDepth [
	| parentCorrection |
	parentCorrection := aTreeNode parent isNil
		ifTrue: [ 0 ]
		ifFalse: [ aMaxHeightAtParentsDepth - aTreeNode parent height ].
	^ 0 @ (aMaxHeightAtNodesDepth - aTreeNode element measuredHeight
				+ parentCorrection) / 2.0
]

{ #category : #'*GToolkit-BlocGraph-Grad' }
BlElementAlignment >> nodeVerticalTopAlignment: aTreeNode parentMaxHeight: aMaxHeightAtParentsDepth [
	aTreeNode parent isNil
		ifTrue: [ ^ 0@0 ].
	^ 0 @ (aMaxHeightAtParentsDepth - (aTreeNode parent) height)
]
