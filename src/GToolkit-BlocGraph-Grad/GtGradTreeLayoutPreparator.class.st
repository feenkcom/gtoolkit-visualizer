Class {
	#name : #GtGradTreeLayoutPreparator,
	#superclass : #GtGradTreeLayouter,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> attachParent: aTreeNode breadth: aChildrenBreadth [
	| x y1 y2 offset nodeContour previousUpperHead previousLowerHead upperHeadNext lowerHeadNext |
	x := self nodeDistance + self levelDistance.	
	
	"here we make sure that the parent is centered relative to its children"
	y2 := (aChildrenBreadth - (self layout nodeBreadth: aTreeNode)) / 2.0
			- self nodeDistance.

	y1 := y2 + (self layout nodeBreadth: aTreeNode) + (2 * self nodeDistance)
			- aChildrenBreadth.

	offset := (x + (self layout nodeLength: aTreeNode)) @ y1.

	aTreeNode nodes first offset: offset.
	nodeContour := aTreeNode contour.

	previousUpperHead := nodeContour upperHead.
	nodeContour
		upperHead: (GtGradNodeContourLine new position: aTreeNode height @ 0).
	upperHeadNext := (GtGradNodeContourLine new position: x @ y1)
			next: previousUpperHead.
	nodeContour upperHead next: upperHeadNext.

	previousLowerHead := nodeContour lowerHead.
	nodeContour
		lowerHead: (GtGradNodeContourLine new position: aTreeNode height @ 0).
	lowerHeadNext := (GtGradNodeContourLine new position: x @ y2)
			next: previousLowerHead.
	nodeContour lowerHead next: lowerHeadNext
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> mergeWithChildrenContours: aTreeNode [
	| aTotalBreadth aChildBreadth aFirstChildNode aNodeContour |
	aFirstChildNode := aTreeNode nodes first.

	aNodeContour := aFirstChildNode contour.
	aTreeNode contour: aNodeContour.

	aChildBreadth := (self layout nodeBreadth: aFirstChildNode)
			+ (2 * self nodeDistance).

	aTotalBreadth := aChildBreadth.

	aTreeNode nodes
		allButFirstDo: [ :aChildNode | 
			| aDeltaDistance aChildContour |
			aChildContour := aChildNode contour.
			aDeltaDistance := aNodeContour mergeWith: aChildContour.

			aChildNode offset: 0 @ (aChildBreadth + aDeltaDistance).

			aChildBreadth := (self layout nodeBreadth: aChildNode)
					+ (2 * self nodeDistance).
			aTotalBreadth := aTotalBreadth + aChildBreadth + aDeltaDistance ].

	^ aTotalBreadth
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitCompositeNode: aTreeNode [
	| theChildrenBreadth |

	theChildrenBreadth := self mergeWithChildrenContours: aTreeNode.

	self
		attachParent: aTreeNode
		breadth: theChildrenBreadth
]

{ #category : #visiting }
GtGradTreeLayoutPreparator >> visitLeafNode: aTreeNode [
	| leafCountour nodeHeight nodeWidth distance|

	nodeHeight := aTreeNode height.
	nodeWidth := aTreeNode width.
	distance := 2 * self nodeDistance.

	leafCountour := GtGradNodeContour new.
	leafCountour upperTail: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour upperHead: (leafCountour upperTail).
	leafCountour lowerTail: (GtGradNodeContourLine new position: 0@(nodeWidth negated - distance)).
	leafCountour lowerHead: (GtGradNodeContourLine new position: (nodeHeight + distance)@0).
	leafCountour lowerHead next: leafCountour lowerTail.

	aTreeNode contour: leafCountour

]
