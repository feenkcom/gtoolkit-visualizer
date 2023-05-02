Class {
	#name : #GtGradTreeLayoutPreparator,
	#superclass : #GtGradTreeLayouter,
	#category : #'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> attachParent: aTreeNode breadth: aChildrenBreadth [
	| x y offset nodeContour |
	x := self nodeDistance + self levelDistance.
	y := ((self layout nodeBreadth: aTreeNode) - aChildrenBreadth) / 2.0
			+ self nodeDistance.
	offset := (x + (self layout nodeLength: aTreeNode)) @ y.

	aTreeNode nodes first offset: offset.
	nodeContour := aTreeNode contour.
	nodeContour addPointsToUpperHead: {x @ y}.
	nodeContour addPointsToLowerHead: {x @ y negated}
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
			| aDeltaDistance |
			aDeltaDistance := aNodeContour mergeWith: aChildNode contour.
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
	aTreeNode
		contour: (GtGradNodeContourLists
				newWithHeight: aTreeNode height
				width: aTreeNode width
				distance: 2 * self nodeDistance)
]
