Class {
	#name : #GtGradAbstractHorizontalTreeLayout,
	#superclass : #GtGradAbstractTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> calculateTreePositionCorrection: delta [
	^ 0@(delta y)
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> calculateTreeStart: bounds nodesXCorrection: dx nodesYCorrection: dy startX: startX startY: startY [
	| x y |
	x := startX.
	y := bounds bottom + treesDistance.
	dy > 0 ifTrue: [ y := y + dy ].

	^ x @ y
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> childOffsetBreadth: aNodesChild [
	"Return the breadth of the offset of the given child element"
	<return: #Number>

	^ 0
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> childOffsetLength: aNodesChild [
	"Return the length of the offset of the given child element"
	<return: #Number>

	^ aNodesChild offset y
]

{ #category : #accessing }
GtGradAbstractHorizontalTreeLayout >> correctionBreadth: aCorrection [
	^aCorrection y
]

{ #category : #accessing }
GtGradAbstractHorizontalTreeLayout >> correctionLength: aCorrection [
	^aCorrection x
]

{ #category : #'private - layout' }
GtGradAbstractHorizontalTreeLayout >> maxFor: aTreeNode root: aRoot [
	^ aRoot maxWidthAt: aTreeNode
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeBottomAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ ((aRootNode maxWidthAt: aTreeNode) - aTreeNode width) @ 0
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeBreadth: aTreeNode [
	^ aTreeNode height
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeCenterAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^ (((aRootNode maxWidthAt: aTreeNode) - aTreeNode width) / 2.0) @ 0
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeLength: aTreeNode [
	^ aTreeNode width
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeOffsetBreadth: aTreeNode [
	"Return the breadth of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset x
]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeOffsetLength: aTreeNode [
	"Return the length of the offset of the given node element"
	<return: #Number>

	^ aTreeNode offset y

]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> nodeTopAlignmentCorrection: aTreeNode aRootNode: aRootNode [
	^0 @ 0

]

{ #category : #'api - geometry' }
GtGradAbstractHorizontalTreeLayout >> reversedPositionOfNode: aTreeNode rootPosition: theRootPosition bounds: theBounds [
	"calculate position of the node so that it the node is flipped
over a vertical line containing the root node"

	| nodePosition |
	nodePosition := aTreeNode element position.
	^ (2 * theRootPosition x - nodePosition x + theBounds right) @ nodePosition y
]
