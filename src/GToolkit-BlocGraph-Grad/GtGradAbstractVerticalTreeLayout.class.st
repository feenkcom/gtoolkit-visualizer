Class {
	#name : #GtGradAbstractVerticalTreeLayout,
	#superclass : #GtGradAbstractTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> calculateTreePositionCorrection: delta [
	^ (delta x)@0
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY [
	| x y |
	x := bounds right + treesDistance.
	dx > 0 ifTrue: [ x := x + dx ].
	y := startY.

	^ x @ y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> childOffsetBreadth: aNodesChild [
	"Return the breadth of the offset of the given child element"
	<return: #Number>

	^ aNodesChild offset y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> childOffsetLength: aNodesChild [
	"Return the length of the offset of the given child element"
	<return: #Number>
	
	^ 0
]

{ #category : #accessing }
GtGradAbstractVerticalTreeLayout >> correctionBreadth: aCorrection [
	^aCorrection x
]

{ #category : #accessing }
GtGradAbstractVerticalTreeLayout >> correctionLength: aCorrection [
	^aCorrection y
]

{ #category : #accessing }
GtGradAbstractVerticalTreeLayout >> maxFor: aTreeNode root: aRoot [
	^ aRoot maxHeightAt: aTreeNode
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ 0 @ ((aRootNode maxHeightAt: aTreeNode) - aTreeNode height)
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeBreadth: aTreeNode [
	^ aTreeNode width
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ 0 @ ((aRootNode maxHeightAt: aTreeNode) - aTreeNode height) / 2.0
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeLength: aTreeNode [
	^ aTreeNode height
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeOffsetBreadth: aTreeNode [
	"Return the breadth of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset y
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeOffsetLength: aTreeNode [
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset x
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ 0 @ 0
]

{ #category : #'api - geometry' }
GtGradAbstractVerticalTreeLayout >> reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds [
	"calculate position of the node so that it the node is flipped
over a horizontal line containing the root node"

	| nodePosition |
	nodePosition := aTreeNode element position.
	^ nodePosition x @ (2 * theRootPosition y - nodePosition y + theBounds bottom)
]
