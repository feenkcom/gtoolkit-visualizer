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
	y2 := ((aChildrenBreadth - (self layout nodeBreadth: aTreeNode)) / 2.0) - self nodeDistance.

	y1 := (y2 + (self layout nodeBreadth: aTreeNode)) + (2 * self nodeDistance) - aChildrenBreadth.

	offset := (x + (self layout nodeLength: aTreeNode))@y1.

	aTreeNode nodes first offset: offset.

	GtGradTreeLayoutOffsetSetSignal new 
		node: aTreeNode; 
		offsetX: offset x; 
		offsetY: offset y;
		emit.

	nodeContour := aTreeNode contour.

	previousUpperHead := nodeContour upperHead.
	nodeContour upperHead: (GtGradNodeContourLine new position: (aTreeNode height)@0).
	upperHeadNext := (GtGradNodeContourLine new position: x@y1) next: previousUpperHead.
	nodeContour upperHead next: upperHeadNext.
	
	previousLowerHead := nodeContour lowerHead.
	nodeContour lowerHead: (GtGradNodeContourLine new position: (aTreeNode height)@0).
	lowerHeadNext := (GtGradNodeContourLine new position: x@y2) next: previousLowerHead.
	nodeContour lowerHead next: lowerHeadNext
		

]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> calculateOffset: contour1 otherContourLine: contour2 x: x y: y [
	<return: #Number>
	| offset contour1x contour1y contour2x contour2y |

	offset := 0.
	contour1x := contour1 position x.
	contour1y := contour1 position y.
	contour2x := contour2 position x.
	contour2y := contour2 position y.

	(contour2x <= x or: [ x + contour1x <= 0 ])
		ifTrue: [ ^ 0 ].
	((contour2x * contour1y) - (contour1x * contour2y)) > 0
		ifTrue: [ x < 0
				ifTrue: [ offset := ((x * contour1y) / contour1x) - y ].
			x > 0
				ifTrue: [ offset := ((x * contour2y) / contour2x) - y ].
			x = 0
				ifTrue: [ offset := 0 - y ]. ]
		ifFalse: [ offset := contour2x < (x + contour1x)
				ifTrue: [ contour2y - (y + (((contour2x - x) * contour1y) / contour1x)) ]
				ifFalse: [ contour2x > (x + contour1x)
						ifTrue: [ (((contour1x + x) * contour2y) / contour2x) - (y + contour1y) ]
						ifFalse: [ contour2y - (y + contour1y) ]. ]. ].
	offset > 0
		ifTrue: [ ^ offset ].
	^ 0
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> mergeContour: aParentContour with: aChildContour [
	<return: #Number>
	| x y total upper lower parentUpperTail childUpperTail parentLowerTail childLowerTail |

	x := 0.
	y := 0.
	total := 0.

	parentUpperTail := aParentContour upperTail.
	parentLowerTail := aParentContour lowerTail.
	
	childUpperTail := aChildContour upperTail.
	childLowerTail := aChildContour lowerTail.
	upper := aParentContour lowerHead.
	lower := aChildContour upperHead.

	[ lower isNotNil and: [ upper isNotNil ] ]
		whileTrue: [ | offset lowerX upperX lowerY upperY |
			offset := self calculateOffset: lower otherContourLine: upper x: x y: y.
			y := y + offset.
			total := total + offset.
			lowerX := lower position x.
			upperX := upper position x.
			lowerY := lower position y.
			upperY := upper position y.
			x + lowerX <= upperX
				ifTrue: [ x := x + lowerX.
					y := y + lowerY.
					lower := lower next ]
				ifFalse: [ x := x - upperX.
					y := y - upperY.
					upper := upper next ] ].
	lower isNotNil
		ifTrue: [ | connectingLine |
			connectingLine := parentUpperTail connectingLine: lower x1: 0 y1: 0 x2: x y2: y.
			parentUpperTail := connectingLine next isNotNil
				ifTrue: [ childUpperTail ]
				ifFalse: [ connectingLine ].
			parentLowerTail := childLowerTail ]
		ifFalse: [ | connectingLine |
			connectingLine := childLowerTail connectingLine: upper x1: x y1: y x2: 0 y2: 0.
			connectingLine next isNil
				ifTrue: [ parentLowerTail := connectingLine ] ].
	
	aParentContour lowerHead: aChildContour lowerHead.

	^ total
]

{ #category : #'private - layout' }
GtGradTreeLayoutPreparator >> mergeWithChildrenContours: aTreeNode [
	| aTotalBreadth aChildBreadth aFirstChildNode aNodeContour | 

	aFirstChildNode := aTreeNode nodes first.

	"store a reference to the parent's contour outside of the loop to eliminate unnecessary dictionary accesses"
	aNodeContour := aFirstChildNode contour.
	aTreeNode contour: aNodeContour.

	aChildBreadth := (self layout nodeBreadth: aFirstChildNode) + (2 * self nodeDistance).

	aTotalBreadth := aChildBreadth.

	aTreeNode nodes
		select: [ :aChildNode | aChildNode ~~ aFirstChildNode ]
		thenDo: [ :aChildNode | 
				| aDeltaDistance |

				aDeltaDistance := self
					mergeContour: aNodeContour
					with: aChildNode contour.

				aChildNode offset: 0@(aChildBreadth + aDeltaDistance).

				GtGradTreeLayoutOffsetSetSignal new
					node: aChildNode; 
					offsetX: 0; 
					offsetY: aChildBreadth + aDeltaDistance;
					emit.

				aChildBreadth := (self layout nodeBreadth: aChildNode) + (2 * self nodeDistance).
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
